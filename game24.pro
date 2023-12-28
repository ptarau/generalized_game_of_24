% the game of 24
% find single digit A,B,C,D that give 24 using any of the 4 operations


%% generates game solution
%% N numbers on the cards
%% R intended result
%% Os list of operators
%% list of available values (e.g., single digits)
generate(N,R,Os,Ds, T,Vs):-
   N1 is N-1,
   gen_vars(N,Ds,Vs),
   gen_vars(N1,Os,Ops),
   gen_op_tree(Ops,Vs,T),
   catch(R is T,_,fail).

%% given a Card, generate all solutions for it (if any)
solve(N,R,Os,Ds,Card, T,Vs):-
  distperm(Card,Vs),
  generate(N,R,Os,Ds, T,Vs).
 
%% game 24 generator  
gen24(Vs:T=R):-
   N=4,
   R=24,
   Os=[+,*,-,/],
   Ds=[1,2,3,4,5,6,7,8,9],  
   generate(N,R,Os,Ds, T,Vs).
 
%% game24 solver for given Card  
solve24(Card,T=R):-
   N=4,
   R=24,
   Os=[+,*,-,/],
   Ds=[1,2,3,4,5,6,7,8,9],  
   solve(N,R,Os,Ds,Card, T,_Vs).  
 
%% given 4 digits (distinct or not) show game24 answers  
go(A,B,C,D):-
  solve24([A,B,C,D],T=R),
  write(T=R),nl,
  fail
; nl.

% tools

%% permutations
perm([],[]).
perm([X|Xs],Zs):-perm(Xs,Ys),ins(X,Ys,Zs).

ins(X,Xs,[X|Xs]).
ins(X,[Y|Ys],[Y|Xs]):-ins(X,Ys,Xs).

%% distict permutations
distperm(Xs,Ps):-distinct_(Ps,perm(Xs,Ps)).

%% multiset partitions, generated from set in second argument
mpart_of([],[]).
mpart_of([U|Xs],[U|Us]):-mcomplement_of(U,Xs,Rs),mpart_of(Rs,Us).

mcomplement_of(_,[],[]).
mcomplement_of(U,[X|Xs],NewZs):-
  mcomplement_of(U,Xs,Zs),
  mplace_element(U,X,Zs,NewZs).

mplace_element(U,U,Zs,Zs).
mplace_element(_,X,Zs,[X|Zs]).

%% subsets of K elements of a set
ksubset(0,_,[]).
ksubset(K,[X|Xs],[X|Rs]):-K>0,K1 is K-1,ksubset(K1,Xs,Rs).
ksubset(K,[_|Xs],Rs):-K>0,ksubset(K,Xs,Rs).

%% generator of operator and/or value multisets
gen_vars(N,Ds,Vs):-
   length(Vs,N),
   between(1,N,K),
   ksubset(K,Ds,Ns),
   expand_from(Ns,Vs).

%% generates permutations of multisets   
expand_from(Ns,Vs):-
   perm(Ns,Ps),
   mpart_of(Vs,Ps).
   
%% generates trees with given operators and values
gen_op_tree(Ops,Vs,T):-op_tree(T,Ops,[],Vs,[]).
  
%% consumes operators and values while building tree out of them
op_tree(V,Ops,Ops,[V|Vs],Vs).
op_tree(T,[Op|Ops1],Ops3,Vs1,Vs3):-
  op_tree(A,Ops1,Ops2,Vs1,Vs2),
  op_tree(B,Ops2,Ops3,Vs2,Vs3),
  T=..[Op,A,B].
 
% just for inter-Prolog portability, faster variants available in libraries

count(X,G,Ctr):-findall(X,G,Xs),length(Xs,Ctr).

discount(X,G,Ctr):-findall(X,G,Xs0),sort(Xs0,Xs),length(Xs,Ctr).

distinct_(X,G):-findall(X,G,Xs),sort(Xs,Sorted),member(X,Sorted).

% examples

/*
?- go(3,5,5,7). % all solutions
3*(5/5+7)=24
(5-3)*(5+7)=24
(5/5+7)*3=24
(5-3)*(7+5)=24
(5+7)*(5-3)=24
3*(7+5/5)=24
(7+5)*(5-3)=24
(7+5/5)*3=24

true.

?- go(3,5,7,7). % unsolvable

true.

?- gen24(X).

X = ([3, 3, 3, 3]:3*(3*3)-3=24) ;
X = ([3, 3, 3, 3]:3*3*3-3=24) ;
X = ([4, 4, 4, 4]:4*4+(4+4)=24) ;
X = ([4, 4, 4, 4]:4+(4+4*4)=24) ;
X = ([4, 4, 4, 4]:4+(4*4+4)=24) ;
X = ([4, 4, 4, 4]:4+4+4*4=24) ;
X = ([4, 4, 4, 4]:4+4*4+4=24) ;
X = ([4, 4, 4, 4]:4*4+4+4=24) ;
X = ([5, 5, 5, 5]:5*5-5/5=24) ;
X = ([6, 6, 6, 6]:6+(6+(6+6))=24) .
.....

?- count(X,gen24(X),Ctr).
Ctr = 13096.

?- N=5,R=42,Ds=[1,2,3,4,5,6,7,8,9],Os=[+,*,-,/],generate(N,R,Os,Ds, T,Vs).
N = 5,
R = 42,
Ds = [1, 2, 3, 4, 5, 6, 7, 8, 9],
Os = [+, *, -, /],
T = 6-6*(6-6-6),
Vs = [6, 6, 6, 6, 6] .

?- N=5,R=101,Ds=[1,2,3,4,5,6,7,8,9],Os=[+,*,-,/],generate(N,R,Os,Ds, T,Vs).
N = 5,
R = 101,
Ds = [1, 2, 3, 4, 5, 6, 7, 8, 9],
Os = [+, *, -, /],
T = 1+5*(5*(5-1)),
Vs = [1, 5, 5, 5, 1] 
*/