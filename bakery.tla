---- MODULE bakery ----

EXTENDS Naturals

CONSTANT bakers
VARIABLE numbers, choose, area

ASSUME
    /\ area \in [bakers -> {"foyer", "doorway", "bakery"}]

(* Unsure how to define max function across a list *)
max(S) == CHOOSE e \in S : \forall o \in S : e >= o

Type_Invariant ==
    /\ numbers \in [bakers -> Nat]
    /\ choose \in [bakers -> Nat]

Initial_State ==
    /\ numbers = [b \in bakers |-> 0 ]
    /\ choose = [b \in bakers |-> 1 ]
    /\ area = [b \in bakers |-> "foyer" ]


Enter_Doorway(b) ==
    /\ area[b] = "foyer"
    /\ choose[b] = 1
    /\ numbers' = [numbers EXCEPT ![b] = max({numbers[b] : b \in bakers}) + 1]
    /\ area' = [area EXCEPT ![b] = "doorway"]
    /\ choose' = [choose EXCEPT ![b] = 0]

Enter_Bakery(b) ==
    /\ area[b] = "doorway"
    /\ UNCHANGED choose
    /\ area' = [area EXCEPT ![b] = "bakery"]
    /\ numbers' = [numbers EXCEPT ![b] = 0]
    (* ensure lowest ticket is selected *)
    
Enter_Foyer(b) ==
    /\ area[b] = "bakery"
    /\ UNCHANGED choose
    /\ area' = [area EXCEPT ![b] = "foyer"]
    /\ number' = [number EXCEPT ![b] = 0]
    /\ choose' = [choose EXCEPT ![b] = 1]

(*
- what instruction is each baker executing
- map bakers -> current instruction
- action only enabled if baker is in that state
*)

Next ==
    \/ \exists b \in bakers
        /\ TRUE (* b is currently in foyer *)
        /\ enterDoorway(b)
    \/ \exists b \in bakers
        /\ TRUE (* b is currently in doorway *)
        /\ TRUE (* b has lowest ticket *)
        /\ TRUE (* There is no one in the bakery *)
        /\ enterBakery(b)
    \/ \exists b \in bakers
        /\ TRUE (* b is currently in bakery *)
        /\ enterFoyer(b)

\* Assume weak fairness on Next, specifically on leavebakery
\* Show deadlock freedom
\* Show starvation freedom

==================
