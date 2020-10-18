pack_sim_elems([], _, ElemAcc, ListAcc,Res) :- 
    append(ListAcc, [ElemAcc], Res), !.

pack_sim_elems([H|L], H, ElemAcc, ListAcc, Res) :-
    pack_sim_elems(L, H, [H | ElemAcc], ListAcc, Res), !.

pack_sim_elems([H1|L], H2, ElemAcc, ListAcc,Res) :- 
    not(H1 = H2),
    append(ListAcc, [ElemAcc], List), 
    pack_sim_elems([H1|L], H1, [], List, Res), !.

pack([], Res) :- Res = [], !.
pack([H | L], Res) :-
    pack_sim_elems(L, H, [H], [], Res).

% Task 4 pack([a,c, b,c,c,c, b, 1, 1, a, a, a, d, b], X)