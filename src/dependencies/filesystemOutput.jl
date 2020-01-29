struct FilesystemOutput <: OutputDependency
    name::String
end

getalias(dep::FilesystemOutput)::String = dep.name
