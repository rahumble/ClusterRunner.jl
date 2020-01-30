struct FilesystemOutput <: OutputDependency
    filename::String
end

getalias(dep::FilesystemOutput)::String = splitext(dep.filename)[1]
