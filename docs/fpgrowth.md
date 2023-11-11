# FP growth

## Build the tree

### How to process a transaction
1. Sort in decending order of support
2. Point to root node
3. Loop over content of transaction while not empty
    - If the current item is in the children of the current node, update the
      count and move to the relevant child node.
    - If not, insert the item as a child node and move to the relevant node.

### process(::Transaction)

```mermaid
graph
    s(["◉"]) -- DB --> bc("catalog()")
    bc -- catalog, DB --> p("plant()")
    p --> g("graft()")

    subgraph g ["graft()"]
        sn("sort nodes") -->
        ic{pop_first <br/> in children}
        ic -- yes --> c("update!(node)")
        ic -- no --> i("insert!(node)")
        c --> sg("graft()")
        i --> sg
    end

    g -- tree --> e(["⦿"])
```

Some random text

```mermaid
sequenceDiagram
    actor u as User
    participant d as DB
    participant t as FP Tree
    participant r as Rule Collection

    u ->> + d : prepare()
    u ->> t : plant() 
    n ->> n : sort()

    loop until transaction is empty
        alt Item in Children
            n ->> d : d
        else Item 
            d ->> n : push!()
        end
    end

    t --> d : d
    u ->> + r : query()
    r --> - u : return selection
```

### Auxillary functions
* push!(::Node) _remember to import from Base_
* pop!(::Node) _to be used during pruning_
* append!(::Node) _no sure if needed_
