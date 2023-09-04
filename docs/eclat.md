# ECLAT
The ECLAT algorithm is the best known of the set combination algorithms for
mining association rules. The interface in FrequentPatterns.jl follow the same
simple template as all the other algorithms:

1. Prepare data
2. Mine rules
3. Query rules

Since the collection of rules generated in step 2 support the DataTables
interface, the last step can be done using a wide variety of solutions that
run on top of this interface.

## Implementation
The ECLAT algorithm has been implemented using a brute force approach to the
generation of sets to consider and currently has no optimisations to ignore
combinations that contain infrequent subsets.

```mermaid
flowchart LR
    raw(raw data)
    tid(TID set)
    e(ECLAT)
    cat(Catalog<br/> of Items)
    m{Matrix?}

    raw --> m
    m --> |yes - convert to Vector| tid
    m --> |"`**no**`"| tid
    tid --> e
    tid --> cat
    cat --> e
```


```mermaid
sequenceDiagram
    autonumber
    title The ECLAT algorithm

    actor u as User
    participant db as Database
    participant p as Parser
    participant e as ECLAT
    participant r as Rules

    Note over r : Vector{Rule}

    u ->> db : ingest raw data
    e ->>+ r : create collection
    loop
    alt
        e ->> r : push! rule
    end
    end
    r ->>- e : g
    p --) db : end
```

Please note! The 