struct AttributeReader{T} <: Reader
    label::String
    exp::Regex
    parseFn::Function

    function AttributeReader(::Type{String}, label::String, exp::Regex)::AttributeReader{String}
        return new{String}(label, exp, x->x)
    end

    function AttributeReader(type::Type{T}, label::String, exp::Regex)::AttributeReader{T} where {T}
        return new{T}(label, exp, x->parse(type, x))
    end
end

getlabel(r::AttributeReader{T}) where {T} = r.label

function read!(io::IO, r::AttributeReader{T})::Union{T,Missing} where {T}
    while !eof(io)
        line = readline(io)
        m = match(r.exp, line)

        if !isnothing(m)
            try
                return r.parseFn(m.captures[1])
            catch e
                @warn "Error processing '$(r.label)'. Exp: $(r.exp). Line: '$(line)'"
                break
            end
        end
    end

    return missing
end
