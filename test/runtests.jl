using PyGen
using Base.Test

# write your own tests here
@test PyGen.asput("yield pi") == "put!(c, pi)"