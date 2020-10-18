drop_([], _, _, Acc, Acc) :- !.
drop_([H|L], I, Index_acc, Acc, Res) :-
    Next_index is Index_acc + 1,
    ( not(0 is mod(Next_index, I)) -> 
    	append(Acc, [H], Appended_list),
        drop_(L, I, Next_index, Appended_list, Res)
    ;   
    	drop_(L, I, Next_index, Acc, Res)
    ).

drop(List, I, Res) :-
    drop_(List, I, 0, [], Res).

% 8 drop([1,2,3,4,5,6], 3, X)