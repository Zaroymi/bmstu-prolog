split_([], _, _, Acc1, Acc2, Acc1, Acc2) :- !.
split_([H|L], Len, Index, Acc1, Acc2, Res1, Res2) :-
    Next_index is Index + 1,
    ( Next_index =< Len ->
    	append(Acc1, [H], Appended_list),
        split_(L, Len, Next_index, Appended_list, Acc2, Res1, Res2)
    ;   
    	append(Acc2, [H], Appended_list),
        split_(L, Len, Next_index, Acc1, Appended_list, Res1, Res2)
    ).

split(List, Len, Res1, Res2) :-
    split_(List, Len, 0, [], [], Res1, Res2).

% split([1,2,3,4,5], 3, X, Y)