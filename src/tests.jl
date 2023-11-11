include("eclat.jl")
include("measurements.jl")
include("rules.jl")
include("tools.jl")

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

#=
Test of the ECLAT algorithm using the Games Sales dataset
=#
using DelimitedFiles

idb = readdlm("./src/games_sales_dataset.csv", ',', String)

#idb = [idb[i, :] for i in 1:size(idb, 1)]

eclat(idb, 5000, 3)

# remove empty entries


#=----------

----------=#
include("types.jl")

testTree = Tree()

testTree.nodes

insert_node(testTree, "label A", 1)
insert_node(testTree, "label B", 1)

println(" - - - ")
testTree.nodes
testTree