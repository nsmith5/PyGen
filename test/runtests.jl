using PyGen
using Base.Test

# write your own tests here
@pygen function λ()
    yield(10)
end

# Test for \n in first line issue
@test isdefined(:λ) == true

# Test that the poodle function doesn't error out
@pygen function 🐩()
    yield("🐩")
end

@test isdefined(:🐩) == true

# Test that one of these generators actually works
@pygen function squares(n)
    i = 0
    while i <= n
        yield(i^2)
        i += 1
    end
end

@test sum(squares(10)) == sum(i^2 for i in 1:10)
