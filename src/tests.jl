include("eclat.jl")
include("tools.jl")

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

# generate collections

collections = generate_collections(10)