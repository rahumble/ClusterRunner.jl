struct TableReader <: Reader
    label::String
    descExp::Regex
    delim::String

    function TableReader(label::String, descExp::Regex, delim::String = " ")
        return new(label, descExp, delim)
    end
end

getlabel(r::TableReader) = r.label

function read!(io::IO, r::TableReader)::Union{DataFrame,Missing}
    # Find start of table
    startPos = -1
    while !eof(io)
        line = readline(io)
        m = match(r.descExp, line)

        if !isnothing(m)
            startPos = position(io)
            break
        end
    end

    # Get size of table
    numLines = 0
    while !eof(io) && readline(io) != ""
        numLines += 1
    end

    if startPos > 0
        endPos = position(io)
        seek(io, startPos)

        limit = numLines - 1 # Subtract off header

        result =  CSV.read(io; limit=limit, delim=r.delim, ignorerepeated=true)

        seek(io, endPos)

        return result
    end

    return missing
end
