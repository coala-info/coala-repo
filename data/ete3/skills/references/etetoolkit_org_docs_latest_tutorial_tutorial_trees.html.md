[ETE Toolkit](../index.html)

3.0

* [Changelog history](../changelog/index.html)
* [The ETE tutorial](index.html)
  + Working With Tree Data Structures
    - [Trees](#trees)
    - [Reading and Writing Newick Trees](#reading-and-writing-newick-trees)
      * [Reading newick trees](#reading-newick-trees)
      * [Writing newick trees](#writing-newick-trees)
    - [Understanding ETE Trees](#understanding-ete-trees)
    - [Basic tree attributes](#basic-tree-attributes)
      * [Root node on unrooted trees?](#root-node-on-unrooted-trees)
    - [Browsing trees (traversing)](#browsing-trees-traversing)
      * [Getting Leaves, Descendants and Node’s Relatives](#getting-leaves-descendants-and-node-s-relatives)
      * [Traversing (browsing) trees](#traversing-browsing-trees)
      * [Advanced traversing (stopping criteria)](#advanced-traversing-stopping-criteria)
      * [Iterating instead of Getting](#iterating-instead-of-getting)
      * [Finding nodes by their attributes](#finding-nodes-by-their-attributes)
    - [Checking the monophyly of attributes within a tree](#checking-the-monophyly-of-attributes-within-a-tree)
    - [Caching tree content for faster lookup operations](#caching-tree-content-for-faster-lookup-operations)
    - [Node annotation](#node-annotation)
    - [Comparing Trees](#comparing-trees)
      * [Calculate distances between trees](#calculate-distances-between-trees)
      * [Robinson-foulds distance](#robinson-foulds-distance)
    - [Modifying Tree Topology](#modifying-tree-topology)
      * [Creating Trees from Scratch](#creating-trees-from-scratch)
      * [Deleting (eliminating) and Removing (detaching) nodes](#deleting-eliminating-and-removing-detaching-nodes)
    - [Pruning trees](#pruning-trees)
    - [Concatenating trees](#concatenating-trees)
    - [Copying (duplicating) trees](#copying-duplicating-trees)
    - [Solving multifurcations](#solving-multifurcations)
    - [Tree Rooting](#tree-rooting)
    - [Working with branch distances](#working-with-branch-distances)
      * [Getting distances between nodes](#getting-distances-between-nodes)
      * [getting midpoint outgroup](#getting-midpoint-outgroup)
  + [The Programmable Tree Drawing Engine](tutorial_drawing.html)
  + [Phylogenetic Trees](tutorial_phylogeny.html)
  + [Clustering Trees](tutorial_clustering.html)
  + [Phylogenetic XML standards](tutorial_xml.html)
  + [Interactive web tree visualization](tutorial_webplugin.html)
  + [Testing Evolutionary Hypothesis](tutorial_adaptation.html)
  + [Dealing with the NCBI Taxonomy database](tutorial_ncbitaxonomy.html)
  + [SCRIPTS: orthoXML](tutorial_etree2orthoxml.html)
* [ETE’s Reference Guide](../reference/index.html)

[ETE Toolkit](../index.html)

* [Docs](../index.html) »
* [The ETE tutorial](index.html) »
* Working With Tree Data Structures
* [View page source](../_sources/tutorial/tutorial_trees.txt)

---

# [Working With Tree Data Structures](#id3)[¶](#working-with-tree-data-structures "Permalink to this headline")

Contents

* [Working With Tree Data Structures](#working-with-tree-data-structures)
  + [Trees](#trees)
  + [Reading and Writing Newick Trees](#reading-and-writing-newick-trees)
    - [Reading newick trees](#reading-newick-trees)
    - [Writing newick trees](#writing-newick-trees)
  + [Understanding ETE Trees](#understanding-ete-trees)
  + [Basic tree attributes](#basic-tree-attributes)
    - [Root node on unrooted trees?](#root-node-on-unrooted-trees)
  + [Browsing trees (traversing)](#browsing-trees-traversing)
    - [Getting Leaves, Descendants and Node’s Relatives](#getting-leaves-descendants-and-node-s-relatives)
    - [Traversing (browsing) trees](#traversing-browsing-trees)
    - [Advanced traversing (stopping criteria)](#advanced-traversing-stopping-criteria)
      * [Collapsing nodes while traversing (custom is\_leaf definition)](#collapsing-nodes-while-traversing-custom-is-leaf-definition)
    - [Iterating instead of Getting](#iterating-instead-of-getting)
    - [Finding nodes by their attributes](#finding-nodes-by-their-attributes)
      * [Search\_all nodes matching a given criteria](#search-all-nodes-matching-a-given-criteria)
      * [Search nodes matching a given criteria (iteration)](#search-nodes-matching-a-given-criteria-iteration)
      * [Find the first common ancestor](#find-the-first-common-ancestor)
      * [Custom searching functions](#custom-searching-functions)
      * [Shortcuts](#shortcuts)
  + [Checking the monophyly of attributes within a tree](#checking-the-monophyly-of-attributes-within-a-tree)
  + [Caching tree content for faster lookup operations](#caching-tree-content-for-faster-lookup-operations)
  + [Node annotation](#node-annotation)
  + [Comparing Trees](#comparing-trees)
    - [Calculate distances between trees](#calculate-distances-between-trees)
    - [Robinson-foulds distance](#robinson-foulds-distance)
  + [Modifying Tree Topology](#modifying-tree-topology)
    - [Creating Trees from Scratch](#creating-trees-from-scratch)
    - [Deleting (eliminating) and Removing (detaching) nodes](#deleting-eliminating-and-removing-detaching-nodes)
  + [Pruning trees](#pruning-trees)
  + [Concatenating trees](#concatenating-trees)
  + [Copying (duplicating) trees](#copying-duplicating-trees)
  + [Solving multifurcations](#solving-multifurcations)
  + [Tree Rooting](#tree-rooting)
  + [Working with branch distances](#working-with-branch-distances)
    - [Getting distances between nodes](#getting-distances-between-nodes)
    - [getting midpoint outgroup](#getting-midpoint-outgroup)

## [Trees](#id4)[¶](#trees "Permalink to this headline")

Trees are a widely-used type of data structure that emulates a tree
design with a set of linked nodes. Formally, a tree is considered an
acyclic and connected graph. Each node in a tree has zero or more
child nodes, which are below it in the tree (by convention, trees grow
down, not up as they do in nature). A node that has a child is called
the child’s parent node (or ancestor node, or superior). A node has at
most one parent.

The height of a node is the length of the longest downward path to a
leaf from that node. The height of the root is the height of the
tree. The depth of a node is the length of the path to its root (i.e.,
its root path).

* The topmost node in a tree is called the root node. Being the
  topmost node, the root node will not have parents. It is the node at
  which operations on the tree commonly begin (although some
  algorithms begin with the leaf nodes and work up ending at the
  root). All other nodes can be reached from it by following edges or
  links. Every node in a tree can be seen as the root node of the
  subtree rooted at that node.
* Nodes at the bottommost level of the tree are called leaf
  nodes. Since they are at the bottommost level, they do not have any
  children.
* An internal node or inner node is any node of a tree that has child
  nodes and is thus not a leaf node.
* A subtree is a portion of a tree data structure that can be viewed
  as a complete tree in itself. Any node in a tree T, together with
  all the nodes below it, comprise a subtree of T. The subtree
  corresponding to the root node is the entire tree; the subtree
  corresponding to any other node is called a proper subtree (in
  analogy to the term proper subset).

In bioinformatics, trees are the result of many analyses, such as
phylogenetics or clustering. Although each case entails specific
considerations, many properties remains constant among them. In this
respect, ETE is a python toolkit that assists in the automated
manipulation, analysis and visualization of any type of hierarchical
trees. It provides general methods to handle and visualize tree
topologies, as well as specific modules to deal with phylogenetic and
clustering trees.

## [Reading and Writing Newick Trees](#id5)[¶](#reading-and-writing-newick-trees "Permalink to this headline")

The Newick format is one of the most widely used standard
representation of trees in bioinformatics. It uses nested parentheses
to represent hierarchical data structures as text strings. The
original newick standard is able to encode information about the tree
topology, branch distances and node names. Nevertheless, it is not
uncommon to find slightly different formats using the newick standard.

ETE can read and write many of them:

| FORMAT | DESCRIPTION | SAMPLE |
| --- | --- | --- |
| 0 | flexible with support values | ((D:0.723274,F:0.567784)1.000000:0.067192,(B:0.279326,H:0.756049)1.000000:0.807788); |
| 1 | flexible with internal node names | ((D:0.723274,F:0.567784)E:0.067192,(B:0.279326,H:0.756049)B:0.807788); |
| 2 | all branches + leaf names + internal supports | ((D:0.723274,F:0.567784)1.000000:0.067192,(B:0.279326,H:0.756049)1.000000:0.807788); |
| 3 | all branches + all names | ((D:0.723274,F:0.567784)E:0.067192,(B:0.279326,H:0.756049)B:0.807788); |
| 4 | leaf branches + leaf names | ((D:0.723274,F:0.567784),(B:0.279326,H:0.756049)); |
| 5 | internal and leaf branches + leaf names | ((D:0.723274,F:0.567784):0.067192,(B:0.279326,H:0.756049):0.807788); |
| 6 | internal branches + leaf names | ((D,F):0.067192,(B,H):0.807788); |
| 7 | leaf branches + all names | ((D:0.723274,F:0.567784)E,(B:0.279326,H:0.756049)B); |
| 8 | all names | ((D,F)E,(B,H)B); |
| 9 | leaf names | ((D,F),(B,H)); |
| 100 | topology only | ((,),(,)); |

Formats labeled as *flexible* allow for missing information. For
instance, format 0 will be able to load a newick tree even if it does
not contain branch support information (it will be initialized with
the default value). However, format 2 would raise an exception. In
other words, if you want to control that your newick files strictly
follow a given pattern you should use **strict** format definitions.

### [Reading newick trees](#id6)[¶](#reading-newick-trees "Permalink to this headline")

In order to load a tree from a newick text string you can use the
constructor [`TreeNode`](../reference/reference_tree.html#ete3.TreeNode "ete3.TreeNode") or its [`Tree`](../reference/reference_tree.html#ete3.Tree "ete3.Tree") alias, provided by the main module
[`ete3`](#module-ete3 "ete3: provides main objects and modules"). You will only need to pass a text string containing
the newick structure and the format that should be used to parse it (0
by default). Alternatively, you can pass the path to a text file
containing the newick string.

```
from ete3 import Tree

# Loads a tree structure from a newick string. The returned variable ’t’ is the root node for the tree.
t = Tree("(A:1,(B:1,(E:1,D:1):0.5):0.5);" )

# Load a tree structure from a newick file.
t = Tree("genes_tree.nh")

# You can also specify the newick format. For instance, for named internal nodes we will use format 1.
t = Tree("(A:1,(B:1,(E:1,D:1)Internal_1:0.5)Internal_2:0.5)Root;", format=1)
```

### [Writing newick trees](#id7)[¶](#writing-newick-trees "Permalink to this headline")

Any ETE tree instance can be exported using newick notation using the
`Tree.write()` method, which is available in any tree node
instance. It also allows for format selection
([Reading and Writing Newick Trees](#sec-newick-formats)), so you can use the same function to
convert between newick formats.

```
from ete3 import Tree

# Loads a tree with internal node names
t = Tree("(A:1,(B:1,(E:1,D:1)Internal_1:0.5)Internal_2:0.5)Root;", format=1)

# And prints its newick using the default format

print t.write() # (A:1.000000,(B:1.000000,(E:1.000000,D:1.000000)1.000000:0.500000)1.000000:0.500000);

# To print the internal node names you need to change the format:

print t.write(format=1) # (A:1.000000,(B:1.000000,(E:1.000000,D:1.000000)Internal_1:0.500000)Internal_2:0.500000);

# We can also write into a file
t.write(format=1, outfile="new_tree.nw")
```

## [Understanding ETE Trees](#id8)[¶](#understanding-ete-trees "Permalink to this headline")

Any tree topology can be represented as a succession of **nodes**
connected in a hierarchical way. Thus, for practical reasons, ETE
makes no distinction between tree and node concepts, as any tree can
be represented by its root node. This allows to use any internal node
within a tree as another sub-tree instance.

Once trees are loaded, they can be manipulated as normal python
objects. Given that a tree is actually a collection of nodes connected
in a hierarchical way, what you usually see as a tree will be the root
node instance from which the tree structure is hanging. However, every
node within a ETE’s tree structure can be also considered a
subtree. This means, for example, that all the operational methods
that we will review in the following sections are available at any
possible level within a tree. Moreover, this feature will allow you to
separate large trees into smaller partitions, or concatenate several
trees into a single structure. For this reason, you will find that the
[`TreeNode`](../reference/reference_tree.html#ete3.TreeNode "ete3.TreeNode") and [`Tree`](../reference/reference_tree.html#ete3.Tree "ete3.Tree") classes are synonymous.

## [Basic tree attributes](#id9)[¶](#basic-tree-attributes "Permalink to this headline")

Each tree node has two basic attributes used to establish its position
in the tree: [`TreeNode.up`](../reference/reference_tree.html#ete3.TreeNode.up "ete3.TreeNode.up") and [`TreeNode.children`](../reference/reference_tree.html#ete3.TreeNode.children "ete3.TreeNode.children"). The first is
a pointer to parent’s node, while the later is a list of children
nodes. Although it is possible to modify the structure of a tree by
changing these attributes, it is strongly recommend not to do
it. Several methods are provided to manipulate each node’s connections
in a safe way (see [Comparing Trees](#sec-modifying-tree-topology)).

In addition, three other basic attributes are always present in any
tree node instance:

| Method | Description | Default value |
| --- | --- | --- |
| [`TreeNode.dist`](../reference/reference_tree.html#ete3.TreeNode.dist "ete3.TreeNode.dist") | stores the distance from the node to its parent (branch length). Default value = 1.0 | 1.0 |
| [`TreeNode.support`](../reference/reference_tree.html#ete3.TreeNode.support "ete3.TreeNode.support") | informs about the reliability of the partition defined by the node (i.e. bootstrap support) | 1.0 |
| `TreeNode.name` | Custom node’s name. | NoName |

In addition, several methods are provided to perform basic operations
on tree node instances:

| Method | Description |
| --- | --- |
| [`TreeNode.is_leaf()`](../reference/reference_tree.html#ete3.TreeNode.is_leaf "ete3.TreeNode.is_leaf") | returns True if *node* has no children |
| [`TreeNode.is_root()`](../reference/reference_tree.html#ete3.TreeNode.is_root "ete3.TreeNode.is_root") | returns True if *node* has no parent |
| [`TreeNode.get_tree_root()`](../reference/reference_tree.html#ete3.TreeNode.get_tree_root "ete3.TreeNode.get_tree_root") | returns the top-most node within the same tree structure as *node* |
| 