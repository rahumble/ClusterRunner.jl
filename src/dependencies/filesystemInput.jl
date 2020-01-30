struct FilesystemInput <: InputDependency
    filename::String
    orgLocation::String
    symlink::Bool

    function FilesystemInput(filename::String, orgLocation::String; symlink::Bool = false)::FilesystemDependency
        return new(filename, orgLocation, symlink)
    end
end

function setup(dep::FilesystemInput, rootFolder::String)::Nothing
    filename = joinpath(rootFolder, dep.filename)

    if !ispath(dep.orgLocation)
        throw(ArgumentError("dependency $(dep.orgLocation) does not exist."))
    end

    if dep.symlink
        @info "Symlinking $(dep.orgLocation) with $(filename)."
        @warn "Symlinking inhibits reproducibility."

        symlink(dep.orgLocation, filename)
    else
        @info "Copying $(dep.orgLocation) to $(filename)."

        cp(dep.orgLocation, filename)
    end

    return nothing
end

getalias(dep::FilesystemInput)::String = splitext(dep.filename)[1]
