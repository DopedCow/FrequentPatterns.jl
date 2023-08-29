"""
"""
function support()
end

"""
"""
function confidence(rules, supp, minimum_confidence = 0)
    confidence = Dict()

    for k in keys(rules)
        for s in powerset(k, 2, 3)
            println(s)
        end
        c = rules[k] / supp[k[1]]
        c >= minimum_confidence && push!(confidence, k => c)
    end
    return confidence
end


"""
"""
function lift(x, y) = confidence(x, y) / support(y)
  
# TODO Consider adding additional functions for coverage and Fisher's exact test
