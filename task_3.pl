revert([], _, _) :- !, fail.
revert([H| []], Prev, [H | Prev]) :- !.
revert([H|L], Prev, Result):-
    revert(L, [H | Prev], Result).

list_eq([], []) :- !, true.
list_eq([H1|L1], [H2|L2]) :-
    H1 = H2,
    list_eq(L1, L2).

is_palindrome(List) :-
    revert(List, [], Reverted),
    list_eq(List, Reverted).