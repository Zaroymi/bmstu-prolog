:- use_module(library(clpfd)).	% Finite domain constraints


% Task 11 remove_at([1,2,3,4,5], 2, X, Y), remove_at([1,2,3,4,5], -3, X, Y)

remove_at_([], _, _, Acc, _, Acc) :- !, fail. 
remove_at_([H|L], Pos, Pos, Acc, X, Res) :- X = H, append(Acc, L, Res), !.
remove_at_([H|L], Pos, Index, Acc, X, Res) :-
    Next_index is Index + 1,
    append(Acc, [H], Appended_list),
    remove_at_(L, Pos, Next_index, Appended_list, X, Res).

remove_at(List, Pos, X, Res) :-
    (   Pos #< 0 ->
    	length(List, Len),
        Index is Len + Pos
    ;
    	Index is Pos
    ),
    remove_at_(List, Index, 0, [], X, Res).

% Task 12 insert_at(token, [1,2,3,4,5], -1, X), insert_at(token, [1,2,3,4,5], 5, X)

insert_at_(Token, List, Pos, Pos, Acc, Res) :- append(Acc, [ Token | List ], Res), !.
insert_at_(Token, [H|L], Pos, Index, Acc, Res) :-
    Next_index is Index + 1,
    append(Acc, [H], Appended_list),
    insert_at_(Token, L, Pos, Next_index, Appended_list, Res).

insert_at(Token, List, Pos, Res) :-
    (   Pos #< 0 ->
    	length(List, Len),
        Index is Len + Pos + 1
    ;
    	Index is Pos
    ),
    insert_at_(Token, List, Index, 0, [], Res). 


% Task 10 

shift_left(List, Res) :-
    length(List, Len),
    Index_end is Len - 1,
    remove_at(List, 0, Token, Processed_list),
    insert_at(Token, Processed_list, Index_end, Res).

shift_right(List, Res) :-
    length(List, Len),
    Index_end is Len - 1,
    remove_at(List, Index_end, Token, Processed_list),
    insert_at(Token, Processed_list, 0, Res). 

rotate([], _, []) :- !.
rotate(List, 0, List) :- !.
rotate(List, Count, Res) :-
    (   Count > 0 ->  
   		shift_left(List, NewList),
        Count_change = -1
    ;   
    	shift_right(List, NewList),
        Count_change = 1
    ),
    New_count is Count + Count_change,
    rotate(NewList, New_count, Res).

% remove_at([1,2,3,4,5], 2, X, Y), remove_at([1,2,3,4,5], -3, X, Y)
% insert_at(token, [1,2,3,4,5], -1, X), insert_at(token, [1,2,3,4,5], 5, X)
% rotate([1,2,3,4,5], 4, X),rotate([1,2,3,4,5], 9, X)