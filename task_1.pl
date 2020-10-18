last_item([], _):- !, fail.
last_item([ Head | [] ], Head):- !.
last_item([ _ | Tail], Result) :-
    last_item(Tail, Result).
