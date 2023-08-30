using Combinatorics
using StatsBase

include("measurements.jl")
include("rules.jl")

# TODO: document this function
"""
"""
unique_items(db::Vector) = unique(vcat(db...))


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
        s >= minimum_support && push!(rules, Rule(first(i, length(i)-1), last(i), s, 0, 0, 0, 0))
    end
    return rules
end



"""
    tid_set()

Returns a Dict() with items as keys and a Set of transaction IDs as values.

The Transaction ID Set, or the TID set, is a vertical representation of data
that has an entry for each unique item in the database. Each entry contains the
IDs of the transaction, the item occurred in.
"""
function tid_set(db)
    # dim and initialise vdb
    catalog = unique_items(db)
    s = [Set() for i in 1:length(catalog)]
    vdb = Dict(catalog .=> s)

    # populate vdb
    for (i, transaction) in enumerate(db), item in transaction
        push!(vdb[item], i)
    end

    return vdb
end

eclat(tid_set(db), 3, 4)

db = [["beer", "wine", "cheese"],
      ["beer", "potato chips"],
      ["eggs", "flour", "butter", "cheese"],
      ["eggs", "flour", "butter", "beer", "potato chips"],
      ["wine", "cheese"],
      ["potato chips"],
      ["eggs", "flour", "butter", "wine", "cheese"],
      ["eggs", "flour", "butter", "beer", "potato chips"],
      ["wine", "beer"],
      ["beer", "potato chips"],
      ["butter", "eggs"],
      ["beer", "potato chips"],
      ["flour", "eggs"],
      ["beer", "potato chips"],
      ["eggs", "flour", "butter", "wine", "cheese"],
      ["beer", "wine", "potato chips", "cheese"],
      ["wine", "cheese"],
      ["beer", "potato chips"],
      ["wine", "cheese"],
      ["beer", "potato chips"]]

eclat_set(db)



"""
    eclat(transactions)
"""     
function eclat_set(db)
    rules = []

    # dim and initialise vdb
    catalog = unique_items(db)
    s = [Set() for i in 1:length(catalog)]
    vdb = Dict(catalog .=> s)

    # populate vdb
    for (i, transaction) in enumerate(db), item in transaction
        push!(vdb[item], i)
    end

    # 
    return vdb
end
