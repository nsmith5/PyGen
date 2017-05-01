module PyGen

export @pygen
#=
    @pygen is a macro that allows for python like generator functions.
The idea is that a function like this:

function f(args)
    ...
    yield x
    ...
    yield y
    ...
end

should become....

function f(args)
    function γ(c::Channel)
        ...
        put!(c, x)
        ...
        put!(c, y)
        ...
    end
    return Channel(γ)
end
=#

const yregex = r"(yield .*)"


function asput(str)
    # Convert "yield λ" to "put!(c, λ)
    λ = replace(str, "yield ", "")
    return "put!(c, $λ)"
end


"""
    @pygen

Making julie walking a little *more* like python. Stick the @pygen macro in front of a 
function declaration and you can use `yield` statements to make a python style
generator! 
"""
macro pygen(f)
    f′ = replace(f, yregex, asput)
    lines = f′ |> IOBuffer |> readlines
    insert!(lines, 2, "function γ(c::Channel)")
    push!(lines, "return Channel(γ)\nend")
    return join(lines, "\n") |> parse |> esc 
end

end 
