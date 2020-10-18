repeat_symbol(_, 0, Acc, Acc) :- !.
repeat_symbol(Symbol, Count, Res, Acc) :-
    Next_count is Count - 1,
    append(Acc, [Symbol], Appended_list),
    repeat_symbol(Symbol, Next_count, Res, Appended_list).

decode_by_sublist([], Acc, Acc) :- !.
decode_by_sublist([[Symbol|Count]|L], Acc, Res) :-
    repeat_symbol(Symbol, Count, Symbol_list, []),
    append(Acc, Symbol_list, Appended_list),
    decode_by_sublist(L, Appended_list, Res).

decode_modified([], Res) :- Res = [], !.
decode_modified(List, Res) :-
    decode_by_sublist(List, [], Res).

% decode_modified([[a, 1], [c, 1], [b, 1], [c, 3], [b, 1], [1, 2], [a, 3], [d, 1], [b, 1]], Z)