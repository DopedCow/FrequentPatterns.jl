# tools

"""
"""
function convert_items_transactions()
end


"""
    generate_collections(num_collections, max_length = 7)

Generate a random selection of collections of items.

The maximum length of the individual collections is controlled by `max_length`,
while the minimum size is 2 to make it useful for rule generation.

# Examples
```julia
c = generate_collections(10)
```
"""
function generate_collections(num_collections, max_length = 7)
    db = []
    items = ["home page", "account", "settings", "shop",
             "forum", "about us", "contact"]
    for i = 1:num_collections
        push!(db, rand(items, rand(2:max_length)))
    end
    return db
end

#generate_transactions(10)
#generate_transactions(1000, 5)