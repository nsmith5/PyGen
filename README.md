# PyGen

|  **Build Status**         |  **Coverage**                |
|:-------------------------:|:----------------------------:|
|[![travis-img]][travis-url]|[![codecov-img]][codecov-url] |

Python generators are great, Julia is great. Why compromise? 

```julia
julia> using PyGen

julia> @pygen function fibonacci()
           n, m = 0, 1
           while true
               yield(m)
               n, m = m, n + m
           end 
       end
fibonacci (generic function with 1 method)

julia> for i in fibonacci()
           println(i)
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

Voila! Generators without all the ceremony!

[codecov-img]: https://codecov.io/gh/nsmith5/PyGen.jl/branch/master/graph/badge.svg
[codecov-url]: https://codecov.io/gh/nsmith5/PyGen.jl

[travis-img]: https://travis-ci.org/nsmith5/PyGen.jl.svg?branch=master
[travis-url]: https://travis-ci.org/nsmith5/PyGen.jl
