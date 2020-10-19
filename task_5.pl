count_elem_seq([], Elem, CountAcc, ListAcc,Res) :- 
    append(ListAcc, [ [Elem | [CountAcc]] ], Res), !.

count_elem_seq([H|L], H, CountAcc, ListAcc, Res) :-
    Acc is CountAcc + 1,
    count_elem_seq(L, H, Acc, ListAcc, Res), !.

count_elem_seq([H1|L], H2, CountAcc, ListAcc,Res) :- 
    append(ListAcc, [ [H2 | [CountAcc]] ], List), 
    count_elem_seq(L, H1, 1, List, Res), !.

encode_modified([], Res) :- Res = [], !.
encode_modified([H | L], Res) :-
    count_elem_seq(L, H, 1, [], Res).

% Task 5 encode_modified([a,c, b,c,c,c, b, 1, 1, a, a, a, d, b], Y)