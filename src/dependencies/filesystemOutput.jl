struct FilesystemOutput <: OutputDependency
    alias::String
end

getalias(dep::FilesystemOutput)::String = dep.name
