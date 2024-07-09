---
id: sheet
aliases: []
tags: []
---



- We use `==` for assignment
```tlaplus
TransferToFrom(a,b) ==
    LET transfer == min(size[b]-fillLevel[b], fillLevel[a]) IN
    fillLevel' = [
      fillLevel EXCEPT
          ![a] = fillLevel[a] - transfer,
          ![b] = fillLevel[b] + transfer
    ]


```tlaplus
Goal == ~ \exists b \in buckets : fillLevel[b] = goal_level
```
there does 
Elements of a symmetry set cannot appear in a choose expression.

# Lecture 8

Encoding vacuous truth:
```tlaplus
IF P THEN Q ELSE TRUE
```

- Liveness properties
`Eventually`
Every trace in the program eventually ends up in the goal state.

- Why?


# System
The system starts with `x=0` and incredments x by one every state

- Weak Fairness on the "increment action"
    - [ ] If a action is continuously enabled, then it must eventually be taken.

- Exercise
Hour Clock
`1->12` 
eventualy h = 10


```tlaplus
ASSUME wf 
VARIABLE clock

Init == clock \in 0..11

Tick == IF clock = 11 THEN clock' = 0 ELSE clock' = clock + 1

Spec == Init /\ [][Tick]_<<clock>>
```
