[ETE Toolkit](../index.html)

3.0

* [Changelog history](../changelog/index.html)
* [The ETE tutorial](index.html)
  + [Working With Tree Data Structures](tutorial_trees.html)
  + The Programmable Tree Drawing Engine
    - [Overview](#overview)
    - [Interactive visualization of trees](#interactive-visualization-of-trees)
    - [Rendering trees as images](#rendering-trees-as-images)
    - [Customizing the aspect of trees](#customizing-the-aspect-of-trees)
      * [Tree style](#tree-style)
      * [Node style](#node-style)
      * [Node faces](#node-faces)
      * [layout functions](#layout-functions)
    - [Combining styles, faces and layouts](#combining-styles-faces-and-layouts)
      * [Fixed node styles](#fixed-node-styles)
      * [Node backgrounds](#node-backgrounds)
      * [Img Faces](#img-faces)
      * [Bubble tree maps](#bubble-tree-maps)
      * [Trees within trees](#trees-within-trees)
      * [Phylogenetic trees and sequence domains](#phylogenetic-trees-and-sequence-domains)
      * [Creating your custom interactive Item faces](#creating-your-custom-interactive-item-faces)
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
* The Programmable Tree Drawing Engine
* [View page source](../_sources/tutorial/tutorial_drawing.txt)

---

# [The Programmable Tree Drawing Engine](#id10)[¶](#the-programmable-tree-drawing-engine "Permalink to this headline")

Contents

* [The Programmable Tree Drawing Engine](#the-programmable-tree-drawing-engine)
  + [Overview](#overview)
  + [Interactive visualization of trees](#interactive-visualization-of-trees)
  + [Rendering trees as images](#rendering-trees-as-images)
  + [Customizing the aspect of trees](#customizing-the-aspect-of-trees)
    - [Tree style](#tree-style)
      * [Show leaf node names, branch length and branch support](#show-leaf-node-names-branch-length-and-branch-support)
      * [Change branch length scale (zoom in X)](#change-branch-length-scale-zoom-in-x)
      * [Change branch separation between nodes (zoom in Y)](#change-branch-separation-between-nodes-zoom-in-y)
      * [Rotate a tree](#rotate-a-tree)
      * [circular tree in 180 degrees](#circular-tree-in-180-degrees)
      * [Add legend and title](#add-legend-and-title)
    - [Node style](#node-style)
    - [Node faces](#node-faces)
      * [Faces position](#faces-position)
      * [Face properties](#face-properties)
    - [layout functions](#layout-functions)
  + [Combining styles, faces and layouts](#combining-styles-faces-and-layouts)
    - [Fixed node styles](#fixed-node-styles)
    - [Node backgrounds](#node-backgrounds)
    - [Img Faces](#img-faces)
    - [Bubble tree maps](#bubble-tree-maps)
    - [Trees within trees](#trees-within-trees)
    - [Phylogenetic trees and sequence domains](#phylogenetic-trees-and-sequence-domains)
    - [Creating your custom interactive Item faces](#creating-your-custom-interactive-item-faces)

## [Overview](#id11)[¶](#overview "Permalink to this headline")

ETE’s treeview extension provides a highly programmable drawing system
to render any hierarchical tree structure as PDF, SVG or PNG
images. Although several predefined visualization layouts are included
with the default installation, custom styles can be easily created
from scratch.

Image customization is performed through four elements: **a)**
[`TreeStyle`](../reference/reference_treeview.html#ete3.TreeStyle "ete3.TreeStyle"), setting general options about the image (shape,
rotation, etc.), **b)** [`NodeStyle`](../reference/reference_treeview.html#ete3.NodeStyle "ete3.NodeStyle"), which defines the
specific aspect of each node (size, color, background, line type,
etc.), **c)** node `faces.Face` which are small pieces of extra
graphical information that can be added to nodes (text labels, images,
graphs, etc.) **d)** a `layout` function, a normal python
function that controls how node styles and faces are dynamically added
to nodes.

Images can be rendered as **PNG**, **PDF** or **SVG** files using the
[`TreeNode.render()`](../reference/reference_tree.html#ete3.TreeNode.render "ete3.TreeNode.render") method or interactively visualized using a
built-in Graphical User Interface (GUI) invoked by the
[`TreeNode.show()`](../reference/reference_tree.html#ete3.TreeNode.show "ete3.TreeNode.show") method.

## [Interactive visualization of trees](#id12)[¶](#interactive-visualization-of-trees "Permalink to this headline")

ETE’s tree drawing engine is fully integrated with a built-in
graphical user interface (GUI). Thus, ETE allows to visualize trees
using an interactive interface that allows to explore and manipulate
node’s properties and tree topology. To start the visualization of a
node (tree or subtree), you can simply call the [`TreeNode.show()`](../reference/reference_tree.html#ete3.TreeNode.show "ete3.TreeNode.show")
method.

One of the advantages of this on-line GUI visualization is that you
can use it to interrupt a given program/analysis, explore the tree,
manipulate them, and continuing with the execution thread. Note that
**changes made using the GUI will be kept after quiting the
GUI**. This feature is specially useful for using during python
sessions, in which analyses are performed interactively.

The GUI allows many operations to be performed graphically, however it
does not implement all the possibilities of the programming toolkit.

```
from ete3 import Tree
t = Tree( "((a,b),c);" )
t.show()
```

## [Rendering trees as images](#id13)[¶](#rendering-trees-as-images "Permalink to this headline")

Tree images can be directly written as image files. SVG, PDF and PNG
formats are supported. Note that, while PNG images are raster images,
PDF and SVG pictures are rendered as [vector graphics](https://en.wikipedia.org/wiki/Vector_graphics), thus allowing its
later modification and scaling.

To generate an image, the [`TreeNode.render()`](../reference/reference_tree.html#ete3.TreeNode.render "ete3.TreeNode.render") method should be
used instead of [`TreeNode.show()`](../reference/reference_tree.html#ete3.TreeNode.show "ete3.TreeNode.show"). The only required argument is
the file name, whose extension will determine the image format (.PDF,
.SVG or .PNG). Several parameters regarding the image size and
resolution can be adjusted:

| Argument | Description |
| --- | --- |
| `units` | “**px**”: pixels, “**mm**”: millimeters, “**in**”: inches |
| `h` | height of the image in `units`. |
| `w` | width of the image in `units`. |
| `dpi` | dots per inches. |

Note

If `h` and `w` values are both provided, image size
will be adjusted even if it requires to break the original aspect
ratio of the image. If only one value (`h` or `w`) is
provided, the other will be estimated to maintain aspect ratio. If
no sizing values are provided, image will be adjusted to A4
dimensions.

```
from ete3 import Tree
t = Tree( "((a,b),c);" )
t.render("mytree.png", w=183, units="mm")
```

## [Customizing the aspect of trees](#id14)[¶](#customizing-the-aspect-of-trees "Permalink to this headline")

Image customization is performed through four main elements:

### [Tree style](#id15)[¶](#tree-style "Permalink to this headline")

The [`TreeStyle`](../reference/reference_treeview.html#ete3.TreeStyle "ete3.TreeStyle") class can be used to create a custom set of
options that control the general aspect of the tree image. Tree styles
can be passed to the [`TreeNode.show()`](../reference/reference_tree.html#ete3.TreeNode.show "ete3.TreeNode.show") and [`TreeNode.render()`](../reference/reference_tree.html#ete3.TreeNode.render "ete3.TreeNode.render")
methods. For instance, [`TreeStyle`](../reference/reference_treeview.html#ete3.TreeStyle "ete3.TreeStyle") allows to modify the scale
used to render tree branches or choose between circular or rectangular
tree drawing modes.

```
from ete3 import Tree, TreeStyle

t = Tree( "((a,b),c);" )
circular_style = TreeStyle()
circular_style.mode = "c" # draw tree in circular mode
circular_style.scale = 20
t.render("mytree.png", w=183, units="mm", tree_style=circular_style)
```

Warning

A number of parameters can be controlled through custom
tree style objects, check [`TreeStyle`](../reference/reference_treeview.html#ete3.TreeStyle "ete3.TreeStyle") documentation for a
complete list of accepted values.

Some common uses include:

#### [Show leaf node names, branch length and branch support](#id16)[¶](#show-leaf-node-names-branch-length-and-branch-support "Permalink to this headline")

![../_images/show_info.png](../_images/show_info.png)

Automatically adds node names and branch information to the tree image:

```
from ete3 import Tree, TreeStyle
t = Tree()
t.populate(10, random_dist=True)
ts = TreeStyle()
ts.show_leaf_name = True
ts.show_branch_length = True
ts.show_branch_support = True
t.show(tree_style=ts)
```

#### [Change branch length scale (zoom in X)](#id17)[¶](#change-branch-length-scale-zoom-in-x "Permalink to this headline")

![../_images/scale_x.png](../_images/scale_x.png)

Increases the length of the tree by changing the scale:

```
from ete3 import Tree, TreeStyle
t = Tree()
t.populate(10, random_dist=True)
ts = TreeStyle()
ts.show_leaf_name = True
ts.scale =  120 # 120 pixels per branch length unit
t.show(tree_style=ts)
```

#### [Change branch separation between nodes (zoom in Y)](#id18)[¶](#change-branch-separation-between-nodes-zoom-in-y "Permalink to this headline")

![../_images/scale_y.png](../_images/scale_y.png)

Increases the separation between leaf branches:

```
from ete3 import Tree, TreeStyle
t = Tree()
t.populate(10, random_dist=True)
ts = TreeStyle()
ts.show_leaf_name = True
ts.branch_vertical_margin = 10 # 10 pixels between adjacent branches
t.show(tree_style=ts)
```

#### [Rotate a tree](#id19)[¶](#rotate-a-tree "Permalink to this headline")

![../_images/rotated_tree.png](../_images/rotated_tree.png)

Draws a rectangular tree from top to bottom:

```
from ete3 import Tree, TreeStyle
t = Tree()
t.populate(10)
ts = TreeStyle()
ts.show_leaf_name = True
ts.rotation = 90
t.show(tree_style=ts)
```

#### [circular tree in 180 degrees](#id20)[¶](#circular-tree-in-180-degrees "Permalink to this headline")

![../_images/semi_circular_tree.png](../_images/semi_circular_tree.png)

Draws a circular tree using a semi-circumference:

```
from ete3 import Tree, TreeStyle
t = Tree()
t.populate(30)
ts = TreeStyle()
ts.show_leaf_name = True
ts.mode = "c"
ts.arc_start = -180 # 0 degrees = 3 o'clock
ts.arc_span = 180
t.show(tree_style=ts)
```

#### [Add legend and title](#id21)[¶](#add-legend-and-title "Permalink to this headline")

```
from ete3 import Tree, TreeStyle, TextFace
t = Tree( "((a,b),c);" )
ts = TreeStyle()
ts.show_leaf_name = True
ts.title.add_face(TextFace("Hello ETE", fsize=20), column=0)
t.show(tree_style=ts)
```

### [Node style](#id22)[¶](#node-style "Permalink to this headline")

Through the [`NodeStyle`](../reference/reference_treeview.html#ete3.NodeStyle "ete3.NodeStyle") class the aspect of each single node
can be controlled, including its size, color, background and branch type.

A node style can be defined statically and attached to several nodes:

![../_images/node_style_red_nodes.png](../_images/node_style_red_nodes.png)

Simple tree in which the same style is applied to all nodes:

```
from ete3 import Tree, NodeStyle, TreeStyle
t = Tree( "((a,b),c);" )

# Basic tree style
ts = TreeStyle()
ts.show_leaf_name = True

# Draws nodes as small red spheres of diameter equal to 10 pixels
nstyle = NodeStyle()
nstyle["shape"] = "sphere"
nstyle["size"] = 10
nstyle["fgcolor"] = "darkred"

# Gray dashed branch lines
nstyle["hz_line_type"] = 1
nstyle["hz_line_color"] = "#cccccc"

# Applies the same static style to all nodes in the tree. Note that,
# if "nstyle" is modified, changes will affect to all nodes
for n in t.traverse():
   n.set_style(nstyle)

t.show(tree_style=ts)
```

If you want to draw nodes with different styles, an independent
[`NodeStyle`](../reference/reference_treeview.html#ete3.NodeStyle "ete3.NodeStyle") instance must be created for each node. Note that
node styles can be modified at any moment by accessing the
[`TreeNode.img_style`](../reference/reference_tree.html#ete3.TreeNode.img_style "ete3.TreeNode.img_style") attribute.

![../_images/node_style_red_and_blue_nodes.png](../_images/node_style_red_and_blue_nodes.png)

Simple tree in which the different styles are applied to each node:

```
from ete3 import Tree, NodeStyle, TreeStyle
t = Tree( "((a,b),c);" )

# Basic tree style
ts = TreeStyle()
ts.show_leaf_name = True

# Creates an independent node style for each node, which is
# initialized with a red foreground color.
for n in t.traverse():
   nstyle = NodeStyle()
   nstyle["fgcolor"] = "red"
   nstyle["size"] = 15
   n.set_style(nstyle)

# Let's now modify the aspect of the root node
t.img_style["size"] = 30
t.img_style["fgcolor"] = "blue"

t.show(tree_style=ts)
```

Static node styles, set through the `set_style()` method, will be
attached to the nodes and exported as part of their information. For
instance, [`TreeNode.copy()`](../reference/reference_tree.html#ete3.TreeNode.copy "ete3.TreeNode.copy") will replicate all node styles in the
replicate tree. Note that node styles can be also modified on the fly
through a `layout` function (see [layout functions](#sec-layout-functions))

### [Node faces](#id23)[¶](#node-faces "Permalink to this headline")

Node faces are small pieces of graphical information that can be
linked to nodes. For instance, text labels or external images could be
linked to nodes and they will be plotted within the tree image.

Several types of node faces are provided by the main [`ete3`](tutorial_trees.html#module-ete3 "ete3: provides main objects and modules")
module, ranging from simple text (`TextFace`) and geometric
shapes (`CircleFace`), to molecular sequence representations
(`SequenceFace`), heatmaps and profile plots
(`ProfileFace`). A complete list of available faces can be
found at the [`ete3.treeview`](../reference/reference_treeview.html#module-ete3.treeview "ete3.treeview") reference page..

#### [Faces position](#id24)[¶](#faces-position "Permalink to this headline")

Faces can be added to different areas around the node, namely
**branch-right**, **branch-top**, **branch-bottom** or **aligned**.
Each area represents a table in which faces can be added through the
`TreeNode.add_face()` method. For instance, if two text labels
want to be drawn bellow the branch line of a given node, a pair of
`TextFace` faces can be created and adde