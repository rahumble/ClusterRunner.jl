abstract type Reader end

"""
    getlabel(r::Reader)::String
    Return the label of the reader r
"""
function getlabel end

"""
    read!(io::IO, r::Reader)
    Return the value obtained from reading the I/O io with reader r
"""
function read! end
