# Implementation
I decided that a list, being a recursive structure in prolog, would be suitable for the format of the 2-3 trees.
Using lists allowed me to expand variables into list and sublist, as well as isolate the heads and tails of trees and subtrees.
I figured that storing the parent nodes of the tree as the head and the children in the tail of the list would be most effective for storing 2-3 trees in the list.

## add() predicate
First, I outlined the base cases for a 2-3 Tree
-	I created a fact at the start of my program for adding a node to an empty tree.
-	Although it was communicated that it was optional to have nil children, I decided to design the base case so that all nodes must have “nil” children.
I then considered the single node tree and tree with only one child node.
-	I kept in mind that parent nodes with 1 element would become 2 element parents as part of the 2-3 tree structure.

I then explicitly set the rules for adding nodes to the Left, Middle and Right children/subtrees of the 2-node parent.

## member() predicate
Since our tree and subtree are stored as lists, we can recursively check all lists for the Node in question.
-	We can also find all elements of the tree using this predicate.

I checked if the element is in the Head of a list with only one parent as the base case.
-	I then recursively checked the Children in the tail of the list using the base case and the rule itself.
-	I then recursively checked the Heads of 2-node parents for the Node in question as it could be the Left (Head) or Right (Tail) of the 2-node parent list.

## height() predicate
Our 2-3 tree is implemented as a series of trees and subtree that follow suit.

To get the total height of the tree, we can calculate the height of all subtrees in the 2-3 tree and add 1 to the maximum height of the subtree at each level.

I created a simple maxHeight() predicate to find the maximum between 3 heights of Left, Middle and Right subtrees.
I then set up the base cases for an empty tree and a single node.
I recursively called the height() predicate and the Left, Middle and Right nodes/subtrees of the 2-3 tree and its subtrees.

## prettyPrint() predicate
When pretty printing, we need ensure that all nodes of the same depth appear on the same level
-	I also used bars (“—”) around 2-node parents to signify that they are a combined 2-node parent
I first created a predicate that invoked a prettyPrint/2 rule that took the tree's depth into consideration.
I used a Depth that increased by 5 each time it was called and used it to create tabs to illustrate the depth of the depth of each node/subtree.
I then set up the base case printing an empty tree/node.
I wrote a simple rule for printing a single node to include its depth in the tree.
When writing the recursive rules for 2 nodes and 3 nodes, I increased the number of tabs printed through the Depth variable and recursively printed the Left, Right and, if necessary, Middle children.
-	Newlines were also used to create spaces between different nodes and subtrees throughout the design of the rules.

For the design of the prettyPrint() predicate, I referred to the “Operation on Data Structure” section from Prolog Programming in Artificial Intelligence for printing 2-3 trees. [1]
Testing
I used a series of trees of various complexities to test the rigour of my predicates.
In order to see if a rule was operating as intended, I would draw out the expected result beforehand and compare it to the results of my predicates.
While testing my predicates, I expressed each 2-3 tree as a list and expected results to follow suit.
I tested add, member and height to produce both results and expected inputs for certain results to examine the validity of each predicate.

## Examples
?- add(8, [ [10,20], [2,nil,nil],nil,[25,nil,nil] ], [ [10,20],[[2,8],nil,nil, nil],nil,[25,nil,nil] ]).
% True

?- add(8, [ [10,20], [2,nil,nil],nil,[25,nil,nil] ], [ [10,20],[[2,8],nil, nil],nil,[25,nil,nil] ]).
% False

?- add(8, [ [10,20], [2,nil,nil],nil,[25,nil,nil] ], [ [10,20], [2,nil,nil], [8,nil,nil], [25,nil,nil] ]).
% False -> 8 node is not between [10,20] to be a Middle child

?- add( 50, [ [10, 20], [[5, 7], [3, nil, nil], [6, nil, nil]],  nil, nil ], X).
% X = [[10, 20], [[5, 7], [3, nil, nil], [6, nil, nil]], nil, [50, nil, nil]].

?- member(2, [ [10,20], [2,nil,nil],nil,[25,nil,nil] ]).
% True
?- member(20, [ [10,20], [2,nil,nil],nil,[25,nil,nil] ]).
% True

?- member(40, [ [10,20], [2,nil,nil],nil,[25,nil,nil] ]).
% False

?- height([ [10,20], [2,nil,nil],nil,[25,nil,nil] ], X).
% X is 2

?- height([ [10,20],[1,nil,nil],[[15,18],nil,[17,nil,nil],nil],[[25,30],nil,nil,[[32,40],nil,nil,nil]] ], 2).
% False

