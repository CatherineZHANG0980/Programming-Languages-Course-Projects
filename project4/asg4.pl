/*
∗ CSCI3180 Principles of Programming Languages ∗
∗ --- Declaration --- ∗
∗ I declare that the assignment here submitted is original except for source
∗ material explicitly acknowledged. I also acknowledge that I am aware of
∗ University policy and regulations on honesty in academic work, and of the
∗ disciplinary guidelines and procedures applicable to breaches of such policy
∗ and regulations, as contained in the website
∗ http://www.cuhk.edu.hk/policy/academichonesty/ ∗
∗ Assignment 4
∗ Name : Zhang Xin Yu
∗ Student ID : 1155091989
∗ Email Addr : xyzhang7@cse.cuhk.edu.hk 
*/


% 1.a Rules
element_last(X, [X]).
element_last(X, [_|L]) :- element_last(X, L).

% 1.b Rules
element_n(X, [X|_], s(0)).
element_n(X, [_|L], s(N)) :- element_n(X, L, N).

% 1.c Rules
remove_n(X, [X|L2], s(0), L2).
remove_n(X, [Y|L1], s(N), [Y|L2]) :- remove_n(X, L1, N, L2).

% 1.d Query
% remove_n(a, L1, s(s(0)), [c,b,d,e]).

% 1.e Rules
insert_n(X, L1, N, L2) :- remove_n(X, L2, N, L1).

% 1.f Rule
repeat_three([], []).
repeat_three([X|L1], [X, X, X|L2]) :- repeat_three(L1, L2).

% 1.g Query
% repeat_three(L, [i,i,i,m,m,m,n,n,n]).

% 2.a 
% mt(a, [mt(b, [mt(e, []), mt(f, [])]), mt(c, []), mt(d, [mt(g, [])])]).

% 2.b
is_tree(mt(_, F)) :- isf(F).
isf([]).
isf([T|F]) :- is_tree(T), isf(F).

% 2.c
sum(0,X,X).
sum(s(X),Y,s(Z)) :- sum(X,Y,Z).
num_node([], 0).
num_node(mt(_, F), s(N)) :- num_node(F, N).
num_node([T|F], N) :- num_node(T, X), num_node(F, Y), sum(X, Y, N).

% 2.d
sum_length(T, L) :- sumlen(T, 0, L).
sumlen([], _, 0).
sumlen(mt(_, F), H, L) :- sumlen(F, s(H), L1), sum(L1, H, L).
sumlen([T|F], H, L) :- sumlen(T, H, L1), sumlen(F, H, L2), sum(L1, L2, L).