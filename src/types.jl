module Types


export Tree, Node, insert_node, update_node!

#=
    Node
=#
"""
"""
mutable struct Node
    id::Int
    label::String
    parent::Int
    children::Vector{Int}
    siblings::Vector{Int}
    support::Int

    function Node(; id = 0,
                    label = "",
                    parent = 0,
                    children = Int[],
                    siblings = Int[],
                    support = 0)

        new(id, label, parent, children, siblings, support)
    end

    Node(id, label, parent, children, siblings, support) = new(id, label, parent, children, siblings, support)

end


#=
    Tree
=#
"""
"""
mutable struct Tree
    nodes::Vector{Node}
    ids::Vector{Int}
    labels::Vector{String}
    size::Int


    function Tree(; nodes = Node[],
        ids = Int[],
        labels = String[],
        size = 0)

        new(nodes, ids, labels, size)
    end

    Tree(nodes, ids, labels, size) = new(nodes, ids, labels, size)

end


#=
    Pretty print functions
=#
"""
"""
function Base.show(io::IO, tree::Tree)
    @info "FP Growth Tree"
    @info "Nodes..."
    foreach(x -> println("--", x), tree.nodes)
end

function Base.show(io::IO, node::Node)
    @info "FP Growth Node"
    println("-- ", node.id, " ", node.label)
end


#=
    Manipulating nodes
=#
"""
"""
function insert_node(tree::Tree, label::String, parent::Int)
    tree.size += 1
    id = tree.size
    push!(tree.nodes, Node(id, label, parent, [], [], 0))
    push!(tree.labels, label)
    @info "Added node number $id with the label $label"
end


"""
    update_node!(node)
Increases the support count of the supplied node by 1.
"""
update_node!(node::Node) = node.support += 1

end