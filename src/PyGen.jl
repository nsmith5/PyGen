module PyGen

using MacroTools

export @pygen

if VERSION > v"0.6-"

macro pygen(f)

    # generate a new symbol for the channel name and 
    # wrapper function
    c = gensym()
    η = gensym()

    # yield(λ) → put!(c, λ)
    f′ = MacroTools.postwalk(f) do x
        @capture(x, yield(λ_)) || return x
        return :(put!($c, $λ))
    end 
    
    # Fetch the function name and args
    @capture(f′, function func_(args__) body_ end)

    # wrap up the η function
    final = quote 
        function $func($(args...))
            function $η($c)
                $body
            end
            return Channel(c -> $η(c))
        end
    end

    return esc(final)
end

else  # for versions less than v0.6-

macro pygen(f)
    η = gensym()
    
    f′ = MacroTools.postwalk(f) do x
        @capture(x, yield(λ_)) || return x
        return :(produce($λ))
    end

    @capture(f′, function func_(args__) body_ end)

    final = quote
        function $func($(args...))
            function $η()
                $body
            end
            return Task($η)
        end
    end
    
    return esc(final)
end

end

"""
    @pygen

Making julia walk a little *more* like python. Stick 
the @pygen macro in front of a function declaration and
you can use `yield(foo)` statements to make a python style
generator!

## Examples

```julia
julia> @pygen function fibonacci()
           n, m = 0, 1
           while true
               yield(m)
               n, m = m, n + m
           end
       end
fibonacci (generic function with 1 method)

julia> for n in fibonacci()
           println(n)
           sleep(1)
       end
1
1
2
3
5
8
13
.
.
.
``` 
"""
:(@pygen)

end
