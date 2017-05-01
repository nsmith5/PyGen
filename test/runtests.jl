using PyGen
using Base.Test

# write your own tests here
@test PyGen.asput("yield pi") == "put!(c, pi)"

@pygen "

function λ()
    yield 10
end
"

# Test for \n in first line issue
@test isdefined(:λ) == true
