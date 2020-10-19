pack_sim_elems([], ElemAcc, ListAcc,Res) :- 
    append(ListAcc, [ElemAcc], Res), !.

pack_sim_elems([AccumElem|L], [AccumElem|Elems], ListAcc, Res) :-
    append([AccumElem|Elems], [AccumElem], Accum),
    pack_sim_elems(L, Accum, ListAcc, Res), !.

pack_sim_elems([NewElem|L], ElemAcc, ListAcc,Res) :- 
    append(ListAcc, [ElemAcc], List), 
    pack_sim_elems(L, [NewElem], List, Res).

pack([], Res) :- Res = [], !.
pack([H | L], Res) :-
    pack_sim_elems(L, [H], [], Res).
% Task 4 pack([a,c, b,c,c,c, b, 1, 1, a, a, a, d, b], X)