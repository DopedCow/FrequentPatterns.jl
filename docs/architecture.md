How the bits and pieces tie together in the FrequentPatterns.jl package.

Article on ECLAT algorithm https://medium.com/p/8ae3276d2d17

```mermaid
sequenceDiagram
    autonumber
    title ECLAT

    actor u as User
    participant idb as Initial Database
    participant tid as Transaction ID Set (TID)
    participant int as Intersection

    u ->> idb : Load()
    u ->> tid : Supply Minimum Support
    tid ->> tid: Filter for Support
    
```

Considering the reliance on set intersections, it makes sense to use Sets in
Julia to accomplish this.