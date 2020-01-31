struct InputDependency <: Dependency
    filename::String
    orgLocation::String
    symlink::Bool

    function InputDependency(filename::String, orgLocation::String; symlink::Bool = false)::InputDependency
        return new(filename, orgLocation, symlink)
    end
end

function setup(dep::InputDependency, rootFolder::String)::Nothing
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

getalias(dep::InputDependency)::String = splitext(dep.filename)[1]
getfilename(dep::InputDependency)::String = dep.filename
