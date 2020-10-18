:- use_module(library(clpfd)).	% Finite domain constraints

element_at(_, [], _) :- !, fail.
element_at(Result, [Result|_], 0) :- !.
element_at(Result, [_|L], Pos) :-
    Next_pos #= Pos - 1,
    element_at(Result, L, Next_pos).