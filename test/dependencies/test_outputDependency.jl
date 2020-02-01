# Good alias and filename
outfile = OutputDependency("output.csv")
@test getalias(outfile) == "output"
@test getfilename(outfile) == "output.csv"

outfile = OutputDependency("output")
@test getalias(outfile) == "output"
