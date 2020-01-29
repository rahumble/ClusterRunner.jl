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
folderDep = FilesystemInput("newFolderAlias", subdir)
setup(folderDep, rootFolder)
newLocation = joinpath(rootFolder, "newFolderAlias")
@test isdir(newLocation)
@test isfile(joinpath(newLocation, "subfile.txt"))

# Good file copy
fileDep = FilesystemInput("newFileAlias", file)
setup(fileDep, rootFolder)
newLocation = joinpath(rootFolder, "newFileAlias")
@test isfile(newLocation)

# Good folder symlink
symFolderDep = FilesystemInput("symFolderAlias", subdir; symlink = true)
@test_logs (:warn, "Symlinking inhibits reproducibility.") setup(symFolderDep, rootFolder)
newLocation = joinpath(rootFolder, "symFolderAlias")
@test islink(newLocation)
@test isfile(joinpath(newLocation, "subfile.txt"))

# Good file symlink
symFileDep = FilesystemInput("symFileAlias", subdir; symlink = true)
@test_logs (:warn, "Symlinking inhibits reproducibility.") setup(symFileDep, rootFolder)
newLocation = joinpath(rootFolder, "symFileAlias")
@test islink(newLocation)

# Missing location
missingDep = FilesystemInput("newFolderAlias", joinpath(rootFolder, "fakePath"))
@test_throws ArgumentError setup(missingDep, rootFolder)

### Clean up
rm(dir; recursive = true)
