
% Adding a node to a 2-3 tree
add( Node, nil, [ Node, nil, nil ] ). % adding to an empty tree (nil) -> base case

% Rules for adding to a single node
add( Node, [ Node2, L, R ], [ [Node,Node2], L, nil, R ] ) :- Node =< Node2.
add( Node, [ Node2, L, R ], [ [Node2,Node], L, nil, R ] ) :- Node > Node2.
% - create a new 2-node parent for subtrees with only one node
% - also add a third child for the new middle child

% Adding to a tree with 2-node parent and 3 children
% - The Parents of Tree1 & Tree2 must be the same
% - The tail of Tree2 should be the tail of Tree1 plus the Node

% Can recursively add to left, middle or right children
add( Node, [ [P1|P2], L1, M, R ], [ [P1|P2], L2, M, R ]) :-
	P1 =< P2, Node =< P1,
	add(Node, L1, L2).

add( Node, [ [P1|P2], L, M1, R ], [ [P1|P2], L, M2, R ]) :-
	P1 =< P2, Node > P1, Node =< P2,
	add(Node, M1, M2).

add( Node, [ [P1|P2], L, M, R1 ], [ [P1|P2], L, M, R2 ]) :-
	P1 =< P2, Node > P2,
	add(Node, R1, R2).


% Checking if a node is a member of a tree
% - since we store all trees and subtrees as lists
% - we can recursively check if an element (node) is in a list or sublists
member(Node, [ Node | _ ]). % base case -> node is the sole parent

member(Node, [ _ | Child ]) :- member(Node, Child). % P is in one of the sublists
member(Node, [ Parent | _ ]) :- member(Node, Parent). % Left or right node is 2-node parent


% Calculating the height of a 2-3 tree
% - predicate to calculate the maximum between 3 heights
% - height of each subtree will be the maximum between L, M, R children + 1
maxHeight(L, M, R, Max) :-
	Max1 is max(L, M), Max2 is max(Max1, R),
	Max is Max2+1.

height(nil, 0). % base case -> empty tree has a height of 0
height([ _, nil, nil ], 1). % fact -> height of a single node is 1

% Recursively calculate the height of a 2-node parents with 3 children
height([ _, L, M, R ], N) :-
	height(L, L1), height(M, M1), height(R, R1),
	maxHeight(L1, M1, R1, N).


% Pretty Print the 2-3 Tree (without nils)
% All subtrees appear on the same level
% We use bars (--) to signify 2-node parents -> both nodes between bars

% invoke prettyPrint/2 predicate
prettyPrint(Tree) :-
	prettyPrint(Tree, 0).

prettyPrint(nil, _). % Base Case -> an empty node

% Single integer node
prettyPrint(Node, Depth) :-
	integer(Node),
	tab(Depth), write(Node), nl.

% A single node with 2 children
prettyPrint([P,L,R], Depth) :-
	D is Depth+5,
	prettyPrint(L, D),
	tab(Depth), write(--), nl,
	tab(Depth), write(P), nl,
	tab(Depth), write(--), nl,
	prettyPrint(R, D).

% A 2-node Parent with 3 children
prettyPrint([[P1, P2], L, M, R], Depth) :-
	D is Depth+5,
	prettyPrint(R, D),
	tab(Depth), write(--), nl,
	tab(Depth), write(P2), nl,
	prettyPrint(M, D),
	tab(Depth), write(P1), nl,
	tab(Depth), write(--), nl,
	prettyPrint(L, D).
