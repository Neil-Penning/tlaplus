---- MODULE nbuckets ----
EXTENDS Naturals

CONSTANT size, goal_level, buckets
VARIABLE fillLevel

ASSUME 
    /\ size \in [buckets -> Nat]
    /\ \exists b \in buckets : goal_level <= size[b]


min(a,b) == IF a < b THEN a ELSE b


Initial_State == 
    /\ fillLevel = [b \in buckets |-> 0]
fill(n) == 
    fillLevel' = [fillLevel EXCEPT ![n] = size[n]]
Empty(n) ==
    fillLevel' = [fillLevel EXCEPT ![n] = 0]
TransferToFrom(a,b) ==
      LET transfer == min(size[b]-fillLevel[b], fillLevel[a]) IN
      fillLevel` = [
        fillLevel EXCEPT 
            ![a] = fillLevel[a] - transfer,
            ![b] = fillLevel[b] + transfer
      ]

Next ==
    \/ \exists b \in buckets : fill(b)
    \/ \exists b \in buckets : empty(b)
    \/ \exists a,b \in buckets : TransferToFrom(a,b)


Spec ==
    /\ Initial_State
    /\ [][Next]_fillLevel \* Do not understand


Goal == ~ \exists b \in bucket : size[b] = goal_level

========================
