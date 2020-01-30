# Good alias
outfile = FilesystemOutput("output.csv")
@test getalias(outfile) == "output"

outfile = FilesystemOutput("output")
@test getalias(outfile) == "output"
