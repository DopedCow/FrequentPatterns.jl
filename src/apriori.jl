# Apriori

using Combinatorics
using StatsBase

struct Rule
    lhs
    rhs
    support
end


"""
    support(transactions)

Returns a Dict with the labels as keys and the support (count) as values.
"""
support(itemsets) = countmap(vcat(itemsets...))


"""
    apriori(itemsets, min_support, max_length)

Returns a collection of rules with a minimum support of min_support and of
maximum length, max_length.
"""
function apriori()
end

function proces_itemsets(itemsets)
    # detect
end

# Tests

transactions = [["apples", "bananas", "eggs"],
                ["bananas", "drink mixer"],
                ["bananas", "cake"],
                ["apples", "bananas", "drink mixer"],
                ["apples", "cake"],
                ["bananas", "cake"],
                ["apples", "cake"],
                ["apples", "bananas", "cake", "eggs"],
                ["apples", "bananas", "cake"]]

s = support(transactions)
candidates = sort(s, byvalue = true, rev = true)
c = collect(keys(s))
p[1] ⊆ transactions[2]
p = powerset(c, 2, 3)

for k in p
    foreach(x -> println(issubset(k, x)), transactions)
end

for k in p
    println(k, " ", sum(map(x -> issubset(k, x), transactions)))
end
