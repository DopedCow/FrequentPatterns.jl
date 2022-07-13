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


# Check for overlaps in the below code


using Combinatorics     # for powerset(), combinations(), multiset_combinations()
using CSV   
using DataFrames
using StatsBase         # for countmap()

struct Rule
    lhs::Vector{String}
    rhs::Vector{String}
    support::Int
    frequency::Float
end


"""
    support(transactions)

Returns a Dict with the labels as keys and the support (count) as values.

Expects the `itemsets` to be an array of arrays.
"""
support(itemsets) = countmap(vcat(itemsets...))


"""
    apriori(transactions, min_support, max_length)

Returns a collection of rules with a minimum support of min_support and of
maximum length, max_length.
"""
function apriori(transactions, min_support, max_length)
    N = length(transactions)
    candidates = support(transactions)
    qualified = values(candidates) .>= min_support
    l = collect(keys(candidates))[qualified]
    p = combinations(l, 2)
    c = Dict()
    for k in p
        s = sum(map(x -> issubset(k, x), transactions))
        s > min_support && push!(c, k => s/N)
    end
    return sort(c, byvalue = true, rev = true)
end


∪([["a", "b"], ["b", "c"]]...)


# Tests

transactions = [["a", "b", "e"],
                ["b", "d"],
                ["b", "c"],
                ["a", "b", "d"],
                ["a", "c"],
                ["b", "c"],
                ["a", "c"],
                ["a", "b", "c", "e"],
                ["a", "b", "c"]]

s = support(transactions)
candidates = sort(s, byvalue = true, rev = true)
c = collect(keys(s))
p[1] ⊆ transactions[2]
p = powerset(c, 2, 2)

for k in p
    foreach(x -> println(issubset(k, x)), transactions)
end

for k in p
    println(k, " ", sum(map(x -> issubset(k, x), transactions)))
end


"""
    sort_conditionally(target, condition)

Sort target array according to the frequencies in the condition Dict. The
elements in target will be sort in ascending order according to the frequencies
in condition.

The function expects a Dict that has keys that are a superset of the elements
in target. The values should be the frequencies to sort according to.
"""
function sort_conditionally(target::Vector, condition::Dict)
    # look up frequencies using indices from target in the condition Dict
    idx = map(x -> condition[x], target)

    # sort the target according to the frequencies
    sorted = target[sortperm(idx)]
    return sorted
end


example = [["a", "d"],
           ["c", "d", "e"],
           ["b", "d"],
           ["a", "b", "c", "d"],
           ["b", "c"],
           ["a", "b", "d"],
           ["b", "d", "e"],
           ["b", "c", "e", "g"],
           ["c", "d", "f"],
           ["a", "b", "d"]]

test = ["e", "d", "a"]

frequencies = support(example)
sort_conditionally(test, frequencies)

@time map(x -> sort_conditionally(x, frequencies), example)



"""
    sparse_to_transaction(df)

Converts the 

Please note! The function assumes there are columns named `id` and `variable` in
the DataFrame.
"""
function sparse_to_transactions(df::DataFrame)
    transactions = []
    gdf = groupby(df, :id)
    for group in gdf
        push!(transactions, group.variable)
    end
    return transactions
end


# A bigger test dataset
df = CSV.File("groceries.tsv", delim=',') |> DataFrame
df.id = 1:size(df, 1)   # add transaction id
long = stack(df, Not(:id))  # stack everything but the id column
longer = long[long.value .== true, Not(:value)] # select lines w/ items and drop value column
groceries = sparse_to_transactions(longer)

groceries_freq = support(groceries)
@time map(x -> sort_conditionally(x, groceries_freq), groceries)
rules = apriori(groceries, 100, 3)

