double_symbol(Symbol, [Symbol | [Symbol] ]) :- !.

dupli_recursive([], Acc, Acc) :- !.
dupli_recursive([H|L], Acc, Res) :-
    double_symbol(H, Symbols),
    append(Acc, Symbols, Appended_list),
    dupli_recursive(L, Appended_list, Res).

dupli(List, Res) :- 
    dupli_recursive(List, [], Res).

% dupli([a, c, b, c, c, c, b, 1, 1, a, a, a, d, b], X)