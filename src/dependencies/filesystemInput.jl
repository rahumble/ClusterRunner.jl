struct FilesystemInput <: InputDependency
    alias::String
    orgLocation::String
    symlink::Bool

    function FilesystemInput(alias::String, orgLocation::String; symlink::Bool = false)::FilesystemDependency
        return new(alias, orgLocation, symlink)
    end
end

function setup(dep::FilesystemInput, rootFolder::String)::Nothing
    filename = joinpath(rootFolder, dep.alias)

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

getalias(dep::FilesystemInput)::String = dep.alias
