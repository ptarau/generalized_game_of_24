  
place(D,[],[D]).
place(D,[X|Ds],[D,X|Ds]):-D<X.

han(N):-
  han(N,Stack,Moves),
  play(Moves,Stack),
  nl,
  fail.
  
han(N, stack(Xs,[],[]),Moves):-
   M is integer(2**N-1),
   length(Moves,M),
   numlist(1,N,Xs),
   han(Moves,Xs,[],[]).
   
  
han([], [],[],_).

han([1-2|Moves],[D|Xs],Ys,Zs):-
     place(D,Ys,DYs),
     han(Moves,Xs,DYs,Zs).
han([1-3|Moves], [D|Xs],Ys,Zs):-
     place(D,Zs,DZs),
     han(Moves,Xs,Ys,DZs).
han([2-3|Moves],Xs,[D|Ys],Zs):-
     place(D,Zs,DZs),
     han(Moves, Xs,Ys,DZs).
  
han([2-1|Moves], Xs,[D|Ys],Zs):-
   place(D,Xs,DXs),
   han(Moves, DXs,Ys,Zs).  
han([3-1|Moves], Xs,Ys,[D|Zs]):-
   place(D,Xs,DXs),
   han(Moves, DXs,Ys,Zs).
han([3-2|Moves],Xs,Ys,[D|Zs]):-
   place(D,Ys,DYs),
   han(Moves, Xs,DYs,Zs).
 
play([],Stack):-show(Stack).
play([I-J|Ms],Stack):-
    show(Stack),
    arg(I,Stack,[D|Fs]),
    arg(J,Stack,Ts),
    nb_setarg(I,Stack,Fs),
    nb_setarg(J,Stack,[D|Ts]),
    play(Ms,Stack).
    
show(Stack):-write(Stack),nl.

go:-han(3).

