struct FilesystemDependency <: Dependency
    alias::String
    location::String
    symlink::Bool

    function FilesystemDependency(alias::String, location::String; symlink::Bool = false)::FilesystemDependency
        return new(alias, location, symlink)
    end
end

function setup(dep::FilesystemDependency, rootFolder::String)::Nothing
    filename = joinpath(rootFolder, dep.alias)

    if !ispath(dep.location)
        throw(ArgumentError("dependency $(dep.location) does not exist."))
    end

    if dep.symlink
        @info "Symlinking $(dep.location) with $(filename)."
        @warn "Symlinking inhibits reproducibility."

        symlink(dep.location, filename)
    else
        @info "Copying $(dep.location) to $(filename)."

        cp(dep.location, filename)
    end

    return nothing
end
