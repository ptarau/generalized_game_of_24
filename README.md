#Generalized Game of 24 solver and generator

## Written in portable Prolog, as elegantly as possible :-)

##### To solve an instance of the classic [Game of 24](https://en.wikipedia.org/wiki/24_(puzzle)) where you need to use all the 4 numbers with any of the 4 basic arithmetic operation to obtain the result 24.

```
?- go(3,5,5,7). % all solutions
3*(5/5+7)=24
(5-3)*(5+7)=24
(5/5+7)*3=24
(5-3)*(7+5)=24
(5+7)*(5-3)=24
3*(7+5/5)=24
(7+5)*(5-3)=24
(7+5/5)*3=24


?- go(3,5,7,7). % unsolvable

```

##### To generate all solutions of all game 24 ptoblems:

```
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
```

##### To count how many distinct one are there:

```
?- count(X,gen24(X),Ctr).
Ctr = 13096.
```

##### To generate all solutions for the generalized problem where you provide the numbers and operations to be used as well as the intended result value:

```
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


```



*Enjoy*,

Paul Tarau

December 2023
