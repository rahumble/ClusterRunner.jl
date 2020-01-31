# Good alias
outfile = OutputDependency("output.csv")
@test getalias(outfile) == "output"

outfile = OutputDependency("output")
@test getalias(outfile) == "output"
