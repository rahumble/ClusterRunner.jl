struct Param <: Dependency
    name::String
end

getalias(dep::Param)::String = dep.name
