strAttrReader = AttributeReader(String, "key", r"<<key=(.*)$")
intAttrReader = AttributeReader(Int, "key", r"<<key=(.*)$")

# Good string read
io = createTestIO("<<key=abc")
@test read!(io, strAttrReader) == "abc"

# Good int read
io = createTestIO("<<key=123")
@test read!(io, intAttrReader) == 123

# Good read after several lines
io = createTestIO("padding", "<<key=123")
result = read!(io, intAttrReader)
@test result == 123

# Bad int parse
io = createTestIO("<<key=abc")
result = @test_logs (:warn, r"Error processing .*") read!(io, intAttrReader)
@test result === missing

# Missing capture
io = createTestIO()
result = read!(io, intAttrReader)
@test result === missing
