struct OutputDependency <: Dependency
    filename::String
end

getalias(dep::OutputDependency)::String = splitext(dep.filename)[1]
getfilename(dep::OutputDependency)::String = dep.filename
