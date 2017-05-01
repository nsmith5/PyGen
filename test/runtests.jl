using PyGen
using Base.Test

# write your own tests here
@test 1 == 2
@test PyGen.asput("yield pi") == "put!(c, pi)"