using Combinatorics
using StatsBase


"""
    Rule(lhs, rhs, support, confidence, lift, coverage)

Hold composition of and information about rules from Frequent Pattern Mining.

LHS (Left-Hand-Side) and RHS (Right-Hand-Side) are the items that compose the
rule. Support, frequence, confidence, lift and coverage are calculated metrics
that measure the strength of the rule.
"""
mutable struct Rule
    lhs
    rhs
    support
    frequence
    confidence
    lift
    coverage
end



"""
    support(transactions)

Returns a Dict with the labels as keys and the support (count) as values.

Expects the `itemsets` to be an array of arrays.
"""
support(transactions) = Dict(keys(transactions) .=> length.(values(transactions)))


"""
    eclat(transactions, minimum_support = 2, maximum_length = 2)

Run ECLAT algorithm on the transactions db and return rules above thresholds.

Note that while you can set minimum support to something less, it hardly makes
sense as this would include items which only occurs once or not at all. In both
cases, it would lead to useless rules.
"""
function eclat(transactions, minimum_support = 2, maximum_length = 2)
    rules = Vector{Rule}()

    c = collect(powerset(collect(keys(transactions)), 2, maximum_length))

    for i in c
        t = tuple((transactions[j] for j in i)...)
        s = length(∩(t...))
        s >= minimum_support && push!(rules, Rule(first(i, length(i)-1), last(i), s, 0, 0, 0))
    end
    return rules
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



#=------------------------------------------------------------------------------
    T E S T S
------------------------------------------------------------------------------=#

transactions = Dict("Bread" => [1, 4, 5, 7, 8, 9],
                    "Butter" => [1, 2, 3, 4, 6, 8, 9],
                    "Milk" => [3, 5, 6, 7, 8, 9],
                    "Coke" => [2, 4],
                    "Jam" => [1, 8])

#
s = support(transactions)
rules = eclat(transactions, 2, 4)

confidence(rules, s)

