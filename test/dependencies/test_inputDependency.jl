### Setup temporary files and directories
dir = mktempdir()

subdir = mktempdir(dir)
subFile = joinpath(subdir, "subfile.txt")
close(open(subFile, "w"))

file = joinpath(dir, "test.txt")
open(file, "w") do io
    write(io, "Some file contents")
end

### Run tests
rootFolder = mktempdir(dir)

# Good folder copy
folderDep = InputDependency("newFolderAlias", subdir)
setup(folderDep, rootFolder)
newLocation = joinpath(rootFolder, "newFolderAlias")
@test isdir(newLocation)
@test isfile(joinpath(newLocation, "subfile.txt"))

# Good file copy
fileDep = InputDependency("newFileAlias.txt", file)
setup(fileDep, rootFolder)
newLocation = joinpath(rootFolder, "newFileAlias.txt")
@test isfile(newLocation)

# Good folder symlink
symFolderDep = InputDependency("symFolderAlias", subdir; symlink = true)
@test_logs (:warn, "Symlinking inhibits reproducibility.") setup(symFolderDep, rootFolder)
newLocation = joinpath(rootFolder, "symFolderAlias")
@test islink(newLocation)
@test isfile(joinpath(newLocation, "subfile.txt"))

# Good file symlink
symFileDep = InputDependency("symFileAlias", subdir; symlink = true)
@test_logs (:warn, "Symlinking inhibits reproducibility.") setup(symFileDep, rootFolder)
newLocation = joinpath(rootFolder, "symFileAlias")
@test islink(newLocation)

# Missing location
missingDep = InputDependency("newFolderAlias", joinpath(rootFolder, "fakePath"))
@test_throws ArgumentError setup(missingDep, rootFolder)

# Good alias and filename
fileDep = InputDependency("newFileAlias.txt", file)
@test getalias(fileDep) == "newFileAlias"
@test getfilename(fileDep) == "newFileAlias.txt"

### Clean up
rm(dir; recursive = true)
