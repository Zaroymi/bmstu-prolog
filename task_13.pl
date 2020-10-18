range_(Start, End, _, _) :- End < Start, !, fail.
range_(End, End, Acc, Res) :- append(Acc, [ End ], Res), !.
range_(Start, End, Acc, Res) :-
    Next is Start + 1,
    append(Acc, [ Start ], Appended_list),
    range_(Next, End, Appended_list, Res).

range(Start, End, Res) :-
	range_(Start, End, [], Res).

% range(-10, 10, X)
