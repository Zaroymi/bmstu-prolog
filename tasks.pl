:- use_module(library(clpfd)).	% Finite domain constraints

% Task 1

last_item([], _):- !, fail.
last_item([ Head | [] ], Head):- !.
last_item([ _ | Tail], Result) :-
    last_item(Tail, Result).

% Task 2

element_at(_, [], _) :- !, fail.
element_at(Result, [Result|_], 0) :- !.
element_at(Result, [_|L], Pos) :-
    Next_pos #= Pos - 1,
    element_at(Result, L, Next_pos).

%Task 3

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

% Task 4 pack([a,c, b,c,c,c, b, 1, 1, a, a, a, d, b], X),

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

% Task 5 encode_modified([a,c, b,c,c,c, b, 1, 1, a, a, a, d, b], Y)

count_elem_seq([], Elem, CountAcc, ListAcc,Res) :- 
    append(ListAcc, [ [Elem | [CountAcc]] ], Res), !.

count_elem_seq([H|L], H, CountAcc, ListAcc, Res) :-
    Acc is CountAcc + 1,
    count_elem_seq(L, H, Acc, ListAcc, Res), !.

count_elem_seq([H1|L], H2, CountAcc, ListAcc,Res) :- 
    not(H1 = H2),
    append(ListAcc, [ [H2 | [CountAcc]] ], List), 
    count_elem_seq([H1|L], H1, 0, List, Res), !.

encode_modified([], Res) :- Res = [], !.
encode_modified([H | L], Res) :-
    count_elem_seq(L, H, 1, [], Res).



% Task 6 decode_modified([[a, 1], [c, 1], [b, 1], [c, 3], [b, 1], [1, 2], [a, 3], [d, 1], [b, 1]], Z)

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


% Task 7 dupli([a, c, b, c, c, c, b, 1, 1, a, a, a, d, b], X)

double_symbol(Symbol, [Symbol | [Symbol] ]) :- !.

dupli_recursive([], Acc, Acc) :- !.
dupli_recursive([H|L], Acc, Res) :-
    double_symbol(H, Symbols),
    append(Acc, Symbols, Appended_list),
    dupli_recursive(L, Appended_list, Res).

dupli(List, Res) :- 
    dupli_recursive(List, [], Res).



% Task 8 drop([1,2,3,4,5,6], 3, X)

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


% Task 9 split([1,2,3,4,5], 3, X, Y)

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


% Task 13 range(-10, 10, X)

range_(Start, End, _, _) :- End < Start, !, fail.
range_(End, End, Acc, Res) :- append(Acc, [ End ], Res), !.
range_(Start, End, Acc, Res) :-
    Next is Start + 1,
    append(Acc, [ Start ], Appended_list),
    range_(Next, End, Appended_list, Res).

range(Start, End, Res) :-
	range_(Start, End, [], Res).
