tableReader = TableReader("table", r"Test description")

# Good table read
io = createTestIO(
    "Fluff",
    "Test description",
    "Cnt        Float       Int    String        Mixed",
    "  0      3.6e-03       472       abc      6.4e-05",
    "  1      3.3e-05      -665       dfe          320",
    "  2      1.6e-05         0       o!e          str",
    "  3      8.0e-06     20431       12a          *73",
    "  4      1.0e-06     -1234       *73          ^%#"
)
output = read!(io, tableReader)

@test size(output) == (5,5)
@test names(output) == [:Cnt, :Float, :Int, :String, :Mixed]
@test describe(output, :eltype).eltype == DataType[Int64, Float64, Int64, String, String]

# Reached end of table read
io = createTestIO(
    "Test description",
    "Cnt        Float       Int    String        Mixed",
    "  0      3.6e-03       472       abc      6.4e-05",
    "  1      3.3e-05      -665       dfe          320",
    "",
    "  2      1.6e-05         0       o!e          str",
    "  3      8.0e-06     20431       12a          *73",
    "  4      1.0e-06     -1234       *73          ^%#"
)
output = read!(io, tableReader)

@test size(output) == (2,5)

# Never found table
io = createTestIO(
    "Fluff"
)
output = read!(io, tableReader)

@test output === missing
