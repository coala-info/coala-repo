Using graphs to relate expression data and
protein-protein interaction data

R. Gentleman and D. Scholtens

November 4, 2025

Introduction

In Ge et al. (2001) the authors consider an interesting question. They assemble gene expression
data from a yeast cell-cycle experiment (Cho et al., 1998), literature protein-protein interaction
(PPI) data and yeast two-hybrid data. We have curated the data slightly to make it simpler to
carry out the analyses reported in Ge et al. (2001). In particular we reduced the data to the
2885 genes that were common to all experiments. We have also represented most of the data in
terms of graphs (nodes and edges) since that is the form we will use for most of our analyses.
The results reported in this document are based on version 0.56.0 of the yeastExpData data

package.

0.1 Graphs

The cell-cycle data is stored in ccyclered and from this it is easy to create a cluster-graph.
A cluster graph is simply a graph that is created from clustered data. In this graph all genes in
the same cluster have edges between them and there are no between cluster edges.

> clusts = split(ccyclered[["Y.name"]],
+
> cg1 = new("clusterGraph",
+
> ccClust = connComp(cg1)
>

clusters = lapply(clusts, as.character))

ccyclered[["Cluster"]])

Next we are interested in looking for associations between the clusters in this graph (genes
that show similar patterns of expression) and the literature curated set of protein-protein inter-
actions.

We note that these are not really literature purported protein complexes (readers might
want to use the output of a procedure like that in apComplex applied to TAP data to explore

1

protein complex data). We also note that the data used to create these graphs is already some-
what out of date and that there is new data available from MIPS. We have chosen to continue
with these data since they align closely with the report in Ge et al. (2001).

>
>
>
>

data(litG)
ccLit = connectedComp(litG)
cclens = sapply(ccLit, length)
table(cclens)

cclens
1
2587

2
29

3
10

4
7

5
1

6
1

7
2

8
1

12
1

13
1

36
1

88
1

ccL2 = ccLit[cclens>1]
ccl2 = cclens[cclens>1]

>
>
>

We see that there are most of the proteins do not have edges to others and that there are a few,
rather large sets of connected proteins.

We can plot a few of those.

sG1 = subGraph(ccL2[[5]], litG)
sG2 = subGraph(ccL2[[1]], litG)

>
>
>

It is worth noting that the structure in Figures 1 and 2 is suggestive of collections of pro-

teins that form cohesive subgroups that work to achieve particular objectives.

An open problem is the development of algorithms (and ultimately software and statistical
models) capable of reliably identifying the constituent components. Among the important
aspects of such a decomposition is the notion that some proteins will be involved in multiple
complexes.

1 Testing Associations

The hypothesis presented in ? was to investigate a potential correlation between expression
clusters and interaction clusters. The devised a strategy called the transcriptome-interactome
correlation mapping strategy to assess the level of dependence. Here we reformulate their
ideas (a more extensive discussion with some extensions is provided in Balasubraminian et al.
(2004)).

The basic idea is to represent the different sets of interactions (relationships) in terms of
graphs. Each graph is defined on the same set of nodes (the genes/proteins that are common

2

Figure 1: One of the larger PPI graphs

3

YDR382WYER009WYFL039CYLR229CYLR340WYDL127WYER111CYGR109CYGR152CYJL187CYKL042WYKL101WYLR212CYLR313CYMR199WYNL289WYPL256CYPR120CYOR160WYDR388WYJL157CYOR036WYPL031CYCL027WYLL024CYOR027WYOR185CYPL240CYMR294WYNL004WYNL243WYOL039WYOR098CYAL040CYBR200WYGR108WYPL242CYPR119WYCL040WYAL005CYLR216CYBR133CYER114CYDL179WYHR005CYJL194WYLR079WYLR319CYMR109WYDR432WYDR356WYEL003WYHR061CYHR172WYLL021WYNL126WYPL016WYDR085CYHR102WYOL016CYBR160WYMR308CYHL007CYKL068WYAL029CYBR109CYGL016WYLR293CYML065WYLR200WYML094WYMR092CYMR186WYDR309CYHR129CYAL041WYBL016WYBL079WYOR127WYPL174CYDR103WYDR323CYDR184CYHR069CYOL021CYOR181WYBR155WYPL140CFigure 2: Another of the larger PPI connected components.

4

YBR009CYBR010WYNL030WYNL031CYOL139CYAR007CYBR073WYER095WYJL173CYNL312WYBL084CYDR146CYLR127CYNL172WYLR134WYMR284WYER179WYIL144WYML104CYOR191WYDL008WYDL030WYDL042CYDR004WYGR162WYMR117CYDR386WYDR485CYDL043CYDR118WYMR106CYML032CYDR076WYDR180WYDL013WYDR227Wto all experiments) and the specific set of relationships are represented as edges in the appro-
priate graph. Above we created one graph where the edges represent known (literature based)
interactions, litG and the second is based on clustered gene expression data, cg1.

We can now determine how many edges are in common between the two graphs by simply

computing their intersection.

>
>

commonG = intersection(litG, cg1)
commonG

A graphNEL graph with undirected edges
Number of Nodes = 2885
Number of Edges = 42

>
>

And we can see that there are 42 edges in common. Since the literature graph has 315 and
the gene expression graph has 156205 we might wonder whether 42 is remarkably large or
remarkably small.

One way to test this assumption is to generate an appropriate null distribution and to com-
pare the observed value (42) to the values from this distribution. While there are some reasons
to consider a random edge model (as proposed by Erdos and Renyi) there are more compelling
reasons to condition on the structure in the graph and to use a node label permutation distri-
bution. This is demonstrated below. Note that this does take quite some time to run though.

nodes(g1) = sample(n1)
ans[i] = numEdges(intersection(g1, g2))

for(i in 1:B) {

ans = rep(NA, B)
n1 = nodes(g1)

> ePerm = function (g1, g2, B=500) {
+
+
+
+
+
+
+
+
+ }
> set.seed(123)
> ##takes a long time
> #nPdist = ePerm(litG, cg1)
> data(nPdist)
> max(nPdist)

}
return(ans)

[1] 23

5

2 Data Analysis

Now that we have satisfied our testing curiosity we might want to start to carry out a little
exploratory data analysis. There are clearly some questions that are of interest. They include
the following:

• Which of the expression clusters have intersections and with which of the literature

clusters?

• Are there expression clusters that have a number of literature cluster edges going be-
tween them (and hence suggesting that the expression clustering was too fine, or that
the genes involved in the literature cluster are not cell-cycle regulated).

• Are there known cell-cycle regulated protein complexes and do the genes involved tend

to cluster together?

• Is the expression behavior of genes that are involved in multiple literature clusters (or at
least that we suspect of being so involved) different from that of genes that are involved
in only one cluster?

Many of these questions require access to more information. For example, we need to
know more about the pattern of expression related to each of the gene expression clusters so
that we can try to interpret them better. We need to have more information about the likely
protein complexes from the literature data so that we can better identify reasonably complete
protein complexes (and given them, then identify those genes that are involved in more than
one complex). But, the most important fact to notice is that all of the substantial calculations
and computations (given the meta-data) are very simple to put in graph theoretic terms.

References

R. Balasubraminian, T. LaFramboise, D. Scholtens, and R. Gentleman. Integrating disparate

sources of protein–protein interaction data. Technical report, Bioconductor, 2004.

R.C. Cho et al. A genome-wide transcriptional analysis of the mitotic cell cycle. Mol. Cell, 2:

65–73, 1998.

H. Ge, Z. Liu, G. M. Church, and M. Vidal. Correlation between transcriptome and interac-
tome mapping data from saccharomyces cerevisiae. Nature Genetics, 29:482–486, 2001.

6

