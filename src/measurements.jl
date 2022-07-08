"""
"""
function support()
end

"""
"""
function confidence()
end

"""
"""
function lift(x, y) = confidence(x, y) / support(y)
  
# TODO Consider adding additional functions for coverage and Fisher's exact test
