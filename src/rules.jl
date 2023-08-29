"""
    Rule(lhs, rhs, support, confidence, lift, coverage)

Hold composition of and information about rules from Frequent Pattern Mining.

LHS (Left-Hand-Side) and RHS (Right-Hand-Side) are the items that compose the
rule. Support, frequence, confidence, lift and coverage are calculated metrics
that measure the strength of the rule.
"""
mutable struct Rule
    lhs
    rhs
    support
    frequence
    confidence
    lift
    coverage
end
