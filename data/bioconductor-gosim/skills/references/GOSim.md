The GOSim package

Holger Fr¨ohlich

October 30, 2018

1

Introduction

The Gene Ontology (GO) has become one of the most widespread systems for systemat-
ically annotating gene products within the bioinformatics community and is developed
by the Gene Ontology Consortium (The Gene Ontology Consortium, 2004). It is speciﬁ-
cally intended for describing gene products with a controlled and structured vocabulary.
GO terms are part of a Directed Acyclic Graph (DAG), covering three orthogonal tax-
onomies or ”aspects”: molecular function, biological process and cellular component. Two
diﬀerent kinds of relationship between GO terms exist: the ”is-a” relationship and the
”part-of” relationship. Providing a standard vocabulary across any biological resources,
the GO enables researchers to use this information for automated data analysis.

The GOSim package (Fr¨ohlich et al., 2007) provides the researcher with various infor-
mation theoretic similarity concepts for GO terms (Resnik, 1995, 1999; Lin, 1998; Jiang
and Conrath, 1998; Lord et al., 2003; Couto et al., 2003, 2005). Moreover, since ver-
sion 1.1.5 GOSim contains several new similarity concepts, which are based on so-called
diﬀusion kernel techniques (Lerman and Shakhnovich, 2007). Additionally GOSim im-
plements diﬀerent methods for computing functional similarities between gene products
based on the similarties between the associated GO terms (Speer et al., 2005; Fr¨ohlich
et al., 2006; Schlicker et al., 2006; Lerman and Shakhnovich, 2007; del Pozo et al., 2008).
This can, for instances, be used for clustering genes according to their biological function
(Speer et al., 2005; Fr¨ohlich et al., 2006) and thus may help to get a better understanding
of the biological aspects covered by a set of genes.

Since version 1.1 GOSim additionally oﬀers the possibility of a GO enrichment analy-
sis using the topGO package (Alexa et al., 2006). Hence, GOSim acts now as an umbrella
for diﬀerent analysis methods employing the GO structure.

2 Usage of GOSim

To elucidate the usage of GOSim we show an example workﬂow and explain the employed
similarity concepts. We create a character vector of Entrez gene IDs, which we assume
to be from human:

1

> library(GOSim)
> genes=c("207","208","596","901","780","3169","9518","2852","26353","8614","7494")

Next we investigate the GO annotation within the current ontology (which is biological
process by default):

> getGOInfo(genes)

208

901

596

207
Character,142 Character,34 Character,112 Character,7 Character,23
go_id
Character,142 Character,34 Character,112 Character,7 Character,23
Term
Definition Character,142 Character,34 Character,112 Character,7 Character,23
IC

Numeric,142
3169
Character,31 Character,18 Character,54 Character,3 Character,15
go_id
Term
Character,31 Character,18 Character,54 Character,3 Character,15
Definition Character,31 Character,18 Character,54 Character,3 Character,15
IC

Numeric,112

Numeric,15

Numeric,34

Numeric,23

Numeric,18

Numeric,54

Numeric,7

Numeric,3

26353

8614

9518

2852

780

Numeric,31
7494
Character,55
go_id
Character,55
Term
Definition Character,55
IC

Numeric,55

2.1 Term Similarities

Let us examine the similarity of the GO terms for genes ”8614” and ”2852” in greater
detail:

> getTermSim(c("GO:0007166","GO:0007267","GO:0007584","GO:0007165","GO:0007186"),method="Resnik",verbose=FALSE)

GO:0007166 GO:0007267 GO:0007584 GO:0007165 GO:0007186
GO:0007166 0.2628131 0.1806383 0.1266641 0.1945233 0.1945233
GO:0007267 0.1806383 0.3551639 0.0000000 0.1806383 0.1806383
GO:0007584 0.1266641 0.0000000 0.5128961 0.1266641 0.1266641
GO:0007165 0.1945233 0.1806383 0.1266641 0.1945233 0.1945233
GO:0007186 0.1945233 0.1806383 0.1266641 0.1945233 0.4016432

This calculates Resnik’s pairwise similarity between GO terms (Resnik, 1995, 1999):

sim(t, t(cid:48)) = ICms(t, t(cid:48)) := max

ˆt∈P a(t,t(cid:48))

IC(ˆt)

(1)

Here P a(t, t(cid:48)) denotes the set of all common ancestors of GO terms t and t(cid:48), while IC(t)
denotes the information content of term t. It is deﬁned as (e.g. Lord et al. (2003))

IC(ˆt) = − log P (ˆt)

(2)

2

i.e. as the negative logarithm of the probability of observing ˆt. The information content
of each GO term is already precomputed for each ontology based on the empirical ob-
servation, how many times a speciﬁc GO term or any of its direct or indirect oﬀsprings
appear in the annotation of the GO with gene products. GOSim provides a normalized
version of Resnik’s similarity measure, which divides the information content of the min-
imum subsumber by the maximum information content of all GO terms, hence obtaining
a number between 0 and 1.

> data("ICsBPhumanall")
> IC[c("GO:0007166","GO:0007267","GO:0007584","GO:0007165","GO:0007186")]

GO:0007166 GO:0007267 GO:0007584 GO:0007165 GO:0007186
4.594539

2.225221

5.867200

3.006413

4.062846

This loads the information contents of all GO terms within ”biological process”. Likewise,
the data ﬁles ICsMFhumanall and ICsCChumanall contain the information contents of
all GO terms within ”molecular function” and ”cellular component” for human. Since
GOSim version 1.1.4.0 the information content of GO terms relies on the mapping of
primary gene IDs (mainly Entrez) to GO terms provided by the libraries org.Dm.eg.db
(ﬂy), org.Hs.eg.db (human), org.Mm.eg.db (mouse), etc. Additionally, it is possible to
pass a user provided mapping via the function setEvidenceLevel. Please refer to the
manual pages for details.
If only GO terms having certain evidence codes should be
considered, one must explicitely calculate the corresponding information contents in the
function calcICs. Again, more information on this function can be found in the manual
pages.

To continue our example from above, let us also calculate Jiang and Conrath’s pair-
wise similarity between GO terms, which is the default, for compairson reasons (Jiang
and Conrath, 1998):

> getTermSim(c("GO:0007166","GO:0007267","GO:0007584","GO:0007165","GO:0007186"),verbose=FALSE)

GO:0007166 GO:0007267 GO:0007584 GO:0007165 GO:0007186
GO:0007166 0.9505312 0.5105747 0.2498911 0.7587689 0.5222505
GO:0007267 0.5105747 0.9828000 0.0000000 0.5740054 0.4169139
GO:0007584 0.2498911 0.0000000 0.9971692 0.2740140 0.2119568
GO:0007165 0.7587689 0.5740054 0.2740140 0.8919565 0.5820734
GO:0007186 0.5222505 0.4169139 0.2119568 0.5820734 0.9898931

Jiang and Conrath’s similarity measure is deﬁned as

sim(t, t(cid:48)) = 1 − min(1, IC(t) − 2ICms(t, t(cid:48)) + IC(t(cid:48)))

(3)

i.e. the similarity between t and t(cid:48) is 0, if their normalized distance is at least 1.

Likewise, we can also compute Lin’s pairwise similarity between GO terms (Lin,

1998):

3

> getTermSim(c("GO:0007166","GO:0007267","GO:0007584","GO:0007165","GO:0007186"),method="Lin",verbose=FALSE)

GO:0007166 GO:0007267 GO:0007584 GO:0007165 GO:0007186
GO:0007166 1.0000000 0.5846115 0.3265762 0.8506792 0.5855112
GO:0007267 0.5846115 1.0000000 0.0000000 0.6572401 0.4773693
GO:0007584 0.3265762 0.0000000 1.0000000 0.3581018 0.2770009
GO:0007165 0.8506792 0.6572401 0.3581018 1.0000000 0.6525805
GO:0007186 0.5855112 0.4773693 0.2770009 0.6525805 1.0000000

It is deﬁned as:

sim(t, t(cid:48)) =

2ICms(t, t(cid:48))
IC(t) + IC(t(cid:48))

(4)

Resnik’s, Jiang-Conraths’s and Lin’s term similarities all refer to ICms(t, t(cid:48)), the
information content of the minimum subsumer of t and t(cid:48), i.e. of the lowest common an-
cestor in the hierarchy. For illustration let us plot the GO graph with leaves GO:0007166
and GO:0007267 and let us compute their minimum subsumer (see Fig. ??):

> library(igraph)
> G = getGOGraph(c("GO:0007166","GO:0007267"))
> G2 = igraph.from.graphNEL(G)
> plot(G2, vertex.label=V(G2)$name)

4

> getMinimumSubsumer("GO:0007166","GO:0007267")

[1] "GO:0023052"

In contrast to the above deﬁned similarity measures Couto et al. (Couto et al., 2005)
introduced a concept, which is not based on the minimum subsumer, but on the set
of all disjunctive common ancestors. Roughly speaking, the idea is not to consider the
common ancestor having the highest information content only, but also others, if they
are somehow ”separate” from each other, i.e. there exists a path to t or to t(cid:48) not passing
any other of the disjunctive common ancestors.

> getDisjCommAnc("GO:0007166","GO:0007267")

[1] "GO:0007154" "GO:0009987" "GO:0023052"

In this case the set of disjunctive common ancestors consists of the minimum subsumer,
GO:0007154, and its parent, GO:0009987, because from both there exists a path to
GO:0007166 not passing any other disjunctive common ancestor(see Fig. ??).

5

lllllllllllllGO:0007166GO:0007267GO:0007154GO:0007165GO:0023052GO:0008150GO:0009987GO:0050794GO:0051716GO:0050789GO:0050896allGO:0065007Based on the notion of disjunctive common ancestors Resnik’s similarity concept can

be extended by deﬁning:

sim(t, t(cid:48)) = ICshare(t, t(cid:48)) =

1
|DisjCommAnc|

(cid:88)

IC(t)

(5)

t∈DisjCommAnc

Likewise, Jiang-Conraths’s and Lin’s measures can be extended as well by replacing
ICms(t, t(cid:48)) by ICshare(t, t(cid:48)).

> getTermSim(c("GO:0007166","GO:0007267"),method="CoutoResnik",verbose=FALSE)

GO:0007166
GO:0007267

GO:0007166 GO:0007267
1.507568
4.062846

3.006413
1.507568

Finally, it should be mentioned that also the depth and density enriched term simi-

larity by Couto et al. (Couto et al., 2003) has been integrated into GOSim:

> setEnrichmentFactors(alpha=0.5,beta=0.3)
> getTermSim(c("GO:0007166","GO:0007267"),method="CoutoEnriched",verbose=FALSE)

GO:0007166
GO:0007267

GO:0007166 GO:0007267
0.00000
16.50672

9.038517
0.000000

Since version 1.1.5 GOSim contains several new similarity concepts, which are based
on so-called diﬀusion kernel techniques (Lerman and Shakhnovich, 2007) rather than
on the information theoretic ideas presented before. For using these similarity mea-
sures it is necessary to pre-compute a diﬀusion kernel on the Gene Ontology graph via
calc.diffusion.kernel. This will take some time and result in a kernel/similarity ma-
trix that is stored in a ﬁle called e.g. ’diﬀKernelpowerBPhumanall.rda’ (meaning matrix
power diﬀusion kernel for ontology BP in human using all evidence codes) in the current
working directory. Once the kernel is created, it has to be loaded into the environment
ﬁrst load.diffusion.kernel. Afterwards GO term similarities can be computed via
function getTermSim. Please check the manual pages for details.

Since version 1.2 GOSim also contains Schlicker et al.’s GO term similarity measure
(Schlicker et al., 2006), which is an adaption of Lin’s similarity measure. Moreover, the
graph information content similarity by Pesquita et al. has been implemented (Pesquita
et al., 2007).

> getTermSim(c("GO:0007166","GO:0007267","GO:0007584","GO:0007165","GO:0007186"),method="relevance",verbose=FALSE)

GO:0007166 GO:0007267 GO:0007584 GO:0007165 GO:0007186
GO:0007166 0.9505312 0.5105747 0.2498911 0.7587689 0.5222505
GO:0007267 0.5105747 0.9828000 0.0000000 0.5740054 0.4169139
GO:0007584 0.2498911 0.0000000 0.9971692 0.2740140 0.2119568
GO:0007165 0.7587689 0.5740054 0.2740140 0.8919565 0.5820734
GO:0007186 0.5222505 0.4169139 0.2119568 0.5820734 0.9898931

6

2.2 Functional Gene Similarities

The special strength of GOSim lies in the possibility not only to calculate similarities for
individual GO terms, but also for genes based on their complete GO anntation. Since
GOSim version 1.1.5 for this purpose the following ideas have been implemented:

1. Maximum (Couto et al., 2003) and average pairwise GO term similarity

2. Average of best matching GO term similarities (Schlicker et al., 2006).

3. Computation of a so-called optimal assignment of terms from one gene to those of

another one (Fr¨ohlich et al., 2006).

4. Similarity derived from Hausdorﬀ distances between sets (del Pozo et al., 2008).

5. Embedding of each gene into a feature space: (Speer et al., 2005; Fr¨ohlich et al.,
2006) proposed to deﬁne feature vectors by a gene’s maximum GO term similar-
ity to certain prototype genes. More simple (but probably also less accurate),
(Mistry and Pavlidis, 2008) recently proposed to represent each gene by a feature
vector describing the presence/absence of all GO terms. The absence of each GO
term is additionally weighted by its information content. Within a feature space
gene functional similarities naturally arise as dot products between feature vectors.
These dot products can be understood as so-called kernel functions (Sch¨olkopf and
Smola, 2002), as used in e.g. Support Vector Machines (Cortes and Vapnik, 1995).
Depending on the choice of later normalization (see below) one can arrive at the co-
sine similarity (Eq. 6), at the Tanimoto coeﬃcient (Eq. 7) or at a measure similiar
to Lin’s one (Eq. 8, Eq. 4).

2.2.1 Normalization of Similarities

Often, people want to normalize similarities, e.g. on the interval [0, 1], for better inter-
pretation. To do so, we can perform the transformation

simgene(g, g(cid:48)) ←

simgene(g, g(cid:48))
(cid:112)simgene(g, g)simgene(g(cid:48), g(cid:48))

(6)

Provided simgene ≥ 0, the consequence will be a similarity of 1 for g with itself and
between 0 and 1 for g with any other gene.
In case of a feature space embedding
this transformation is equivalent to computing the cosine similarity between two feature
vectors.

Another possibility is to use Lin’s normalization (see Eq. 4):

simgene(g, g(cid:48)) ←

2simgene(g, g(cid:48))
simgene(g, g) + simgene(g(cid:48), g(cid:48))

(7)

7

Furthermore, one can use a normalization in the spirit of the Tanimoto coeﬃcient:

simgene(g, g(cid:48)) ←

simgene(g, g(cid:48))
simgene(g, g) + simgene(g(cid:48), g(cid:48)) − simgene(g, g(cid:48))

(8)

In case of a feature space embedding the transformation corresponds exactly to the
Tanimoto coeﬃcient betweem two feature vectors.

We now give a more detailed overview over the diﬀerent similarity concepts mentioned

above.

2.2.2 Maximum and Average Pairwise GO Term Similarity

The idea of the maximum pairwise GO term similarity is straight forward. Given two
genes g and g(cid:48) annotated with GO terms t1, ..., tn and t(cid:48)
m we deﬁne the functional
similarity between between g and g(cid:48) as

1, ..., t(cid:48)

simgene(g, g(cid:48)) =

sim(ti, t(cid:48)
j)

max
i = 1, , ..., n
j = 1, ..., m

(9)

where sim is some similarity measure to compare GO terms ti and t(cid:48)
j. This idea is, for
instance, realized in FuSSiMeg (Couto et al., 2003). Instead of computing the maximum
pairwise GO term similarity one may also take the average here.

2.2.3 Average of Best Matching GO Term Similarities

The idea of this approach (Schlicker et al., 2006) is to assign each GO term ti occuring in
πi in gene g(cid:48). Hence multiple GO terms from gene g
gene g to its best matching partner t(cid:48)
can be assigned to one GO term from gene g(cid:48). A similarity score is computed by taking
the average similarity of assigned GO terms. Since, however, genes can have an unequal
number of GO terms the result depends on whether GO terms of gene g are assigned
to those of gene g(cid:48) or vice versa. Hence, in Schlicker et al. (2006) it was proposed to
either take the maximum or the average of both similarity scores. Both strategies are
implemented in GOSim.

2.2.4 Optimal Assignment Gene Similarities

To elucidate the idea of the optimal assignment (Fr¨ohlich et al., 2006), consider the GO
terms associated with gene ”8614” on one hand and gene ”2852” on the other hand:

> getGOInfo(c("8614","2852"))

2852

8614
Character,15 Character,54
go_id
Character,15 Character,54
Term
Definition Character,15 Character,54
IC

Numeric,54

Numeric,15

8

Given a similarity concept sim to compare individual GO terms, the idea is now to assign
each term of the gene having fewer annotation to exactly one term of the other gene such
that the overall similarity is maximized. More formally the optimal assignment problem
can be stated as follows: Let π be some permutation of either an n-subset of natural
numbers {1, ..., m} or an m-subset of natural numbers {1, ..., n} (this will be clear from
context). Then we are looking for the quantity

simgene(g, g(cid:48)) =

(cid:26) maxπ
maxπ

(cid:80)n
(cid:80)m

i=1 sim(ti, t(cid:48)
π(i))
j=1 sim(tπ(j), t(cid:48)
j)

if m > n
otherwise

(10)

The computation of (10) corresponds to the solution of the classical maximum weighted
bipartite matching (optimal assignment) problem in graph theory and can be carried
out in O(max(n, m)3) time (Mehlhorn and N¨aher, 1999). To prevent that larger lists
of terms automatically achieve a higher similarity we may further simgene divide 10 by
max(m, n).

In our example, using Lin’s GO term similarity measure the following assignments

yielding a corresponding similarity matrix are found:

> getGeneSim(c("8614","2852"),similarity="OA",similarityTerm="Lin",avg=FALSE, verbose=FALSE)

filtering out genes not mapping to the currently set GO category ... ===> list of 2 genes reduced to 2

2852
8614
8614 1.0000000 0.3750396
2852 0.3750396 1.0000000

Note the diﬀerence to a gene similarity that is just based on the maximum GO term
similarity and to a gene similarity that is based on the average of best matching GO
terms:

> getGeneSim(c("8614","2852"),similarity="max",similarityTerm="Lin",verbose=FALSE)

filtering out genes not mapping to the currently set GO category ... ===> list of 2 genes reduced to 2

2852
8614
8614 1.0000000 0.9827528
2852 0.9827528 1.0000000

> getGeneSim(c("8614","2852"),similarity="funSimMax",similarityTerm="Lin",verbose=FALSE)

filtering out genes not mapping to the currently set GO category ... ===> list of 2 genes reduced to 2

2852
8614
8614 1.0000000 0.6900632
2852 0.6900632 1.0000000

9

2.2.5 Gene Similarities In the Spirit of Hausdorﬀ Metrics

Hausdorﬀ metrics are a general concept for measuring distances between compact subsets
of a metric space. Let X and Y be the two sets of GO terms associated to genes g and
g(cid:48), and let d(t, t(cid:48)) denote the distanc between GO terms t and t(cid:48). Then the Hausdorﬀ
distance X and Y is deﬁned as

dHausdorf f (X, Y ) = max{sup
t∈X

inf
t(cid:48)∈Y

d(t, t(cid:48)), sup
t(cid:48)∈Y

inf
t∈X

d(t, t(cid:48))}

(11)

Using Hausdorﬀ metrics for measuring gene functional distances was proposed in del
Pozo et al. (2008). We translate the idea to deﬁne a similarity measure between g and
g(cid:48) (see the diﬀerence to previous GOSim versions):

simgene(g, g(cid:48)) = exp(−dHausdorf f (g, g(cid:48)))

(12)

> getGeneSim(c("8614","2852"),similarity="hausdorff",similarityTerm="Lin",verbose=FALSE)

filtering out genes not mapping to the currently set GO category ... ===> list of 2 genes reduced to 2

2852
8614
8614 1.0000000 0.9873622
2852 0.9873622 1.0000000

2.2.6 Feature Space Embedding of Gene Products

The Simple Approach Mistry and Pavlidis (2008) proposed to represent each gene
by a feature vector describing the presence/absence of all GO terms. The absence of
each GO term is additionally weighted by its information content. In the feature space
similarities arise as dot products. Hence, the similarity between two GO terms t and
t(cid:48) is implicitly deﬁned as the product of their information content values, hence igoring
the exact DAG structure of the Gene Ontology as employed by the GO term similarity
measures explained in the beginning of this document.

> getGeneSim(c("8614","2852"),similarity="dot",method="Tanimoto", verbose=FALSE)

filtering out genes not mapping to the currently set GO category ... ===> list of 2 genes reduced to 2

2852
8614
8614 1.00000000 0.06764684
2852 0.06764684 1.00000000

This will calculate the Tanimoto coeﬃcient between feature vectors as a similarity mea-
sure. It is possible to retrieve the feature vectors via:

> features = getGeneFeatures(c("8614","2852"))

filtering out genes not mapping to the currently set GO category ... ===> list of 2 genes reduced to 2

10

Embeddings via GO Term Similarities to Prototype Genes This approach is
due to Speer et al. (2005); Fr¨ohlich et al. (2006). The idea is to deﬁne a feature vector
for each gene by its pairwise GO term similarity to certain prototype genes, i.e. the
prototype genes form a (nonorthogonal) basis, and each gene is deﬁned relative to this
basis. The prototype genes can eithed be deﬁned a priori or one can use one of the
heuristics implemented in the function selectPrototypes. The default behavior is to
select the 250 best annotated genes, i.e. which have been annotated with GO terms
most often, but here we just use 3 for computational reasons:

> proto = selectPrototypes(n=3,verbose=FALSE)

We now calculate for each gene g feature vectors φ(g) by using their similarity to all

prototypes p1, ..., pn:

φ(g) = (sim(cid:48)(g, p1), ..., sim(cid:48)(g, pn))T
(13)
Here sim(cid:48) by default is the maximum pairwise GO term similarity. Alternatively, one
can use other similarity measures for sim(cid:48) as well. These similarity measures can by
itself again be combined with arbitrary GO term similarity concepts. The default is the
Jiang-Conrath term similarity.

Because the feature vectors are very high-dimensional we usually perform a principal
component analysis (PCA) to project the data into a lower dimensional subspace. The
results are not shown here due to long computation time.

> PHI = getGeneFeaturesPrototypes(genes,prototypes=proto, verbose=FALSE)

This uses the above deﬁne prototypes to calculate feature vectors and performs a
PCA afterwards. The number of principal components is chosen such that at least 95%
of the total variance in feature space can be explained (this is a relatively conservatve
criterion).

We can now plot our genes in the space spanned by the ﬁrst 2 principal components
to get an impression of the relative ”position” of the genes to each other in the feature
space (see Fig. ??). The feature vectors are normalized to Euclidian norm 1 by default:

> x=seq(min(PHI$features[,1]),max(PHI$features[,1]),length.out=100)
> y=seq(min(PHI$features[,2]),max(PHI$features[,2]),length.out=100)
> plot(x,y,xlab="principal component 1",ylab="principal component 2",type="n")
> text(PHI$features[,1],PHI$features[,2],labels=genes)

Finally, we can directly calculate the similarities of the genes to each other, this time
using the Resnik’s GO term similarity concept. These similarities may then be used to
cluster genes with respect to their function:

> sim = getGeneSimPrototypes(genes[1:3],prototypes=proto,similarityTerm="Resnik",verbose=FALSE)
> h=hclust(as.dist(1-sim$similarity),"average")
> plot(h,xlab="")

This produces a hierarchical clustering of all genes using average linkage clustering

(see Fig. 2).

11

Figure 1: Embedding of genes into feature space spanned by the ﬁrst 2 principal com-
ponents

Figure 2: Possible functional clustering of the genes using Ward’s method.

12

−0.85−0.80−0.75−0.70−0.50−0.45−0.40−0.35principal component 1principal component 2207208596901780316995182852263538614749486149518780285290120826353596316920774940.000.020.040.06Cluster Dendrogramhclust (*, "ward")HeightFigure 3: Silhouette plot of a possible given grouping of genes.

2.2.7 Combination of Similarities from Diﬀerent Ontologies

It should be mentioned that up to now all similarity computations were performed within
the ontology ”biological process”. One could imagine to combine functional similarities
between gene products with regard to diﬀerent taxonomies. An obvious way for doing
so would be to consider the sum of the respective similarities:

simtotal(g, g(cid:48)) = simOntology1(g, g(cid:48)) + simOntology2(g, g(cid:48))

(14)

Of course, one could also use a weighted averaging scheme here, if desired.

2.3 Cluster Evaluations

GOSim has the possibility to evaluate a given clustering of genes or terms by means of
their GO similarities. Supposed, based on other experiments (e.g. microarry), we have
decided to put genes ”8614”, ”9518”, ”780”, ”2852” in one group, genes ”3169”, ”207”,
”7494”, ”596” in a second and the rest in a third group. Then we can ask ourselves, how
similar these groups are with respect to their GO annotations:

> ev = evaluateClustering(c(2,3,2,3,1,2,1,1,3,1,2), sim$similarity)
> plot(ev$clustersil,main="")

A good indiciation of the clustering qualitiy can be obtained by looking at the cluster
silhouettes (Rousseeuw, 1987) (see Fig. 3). This shows that clusters 1 and 2 are relatively
homogenous with respect to the functional similarity of the genes contained in it, while
the genes in cluster 3 are more dissimilar.

13

1110987654321Silhouette width si−0.50.00.51.0Average silhouette width :  0.33n = 113    clusters    Cjj :  nj | avei˛˛Cj    si1 :   4  |  0.422 :   4  |  0.833 :   3  |  −0.462.4 GO Enrichment Analysis

Since version 1.1 GOSim also oﬀers the possibility of a GO enrichment analysis. Suppose,
we may now want to get a clearer picture of the genes involved in cluster 1. For this
purpose we use the topGO tool (Alexa et al., 2006).

> library(org.Hs.eg.db)
> library(topGO)
> allgenes = union(c("8614", "9518", "780", "2852"), sample(keys(org.Hs.egGO), 1000)) # suppose these are all genes
> GOenrichment(c("8614", "9518", "780", "2852"), allgenes) # print out what cluster 1 is about

$GOTerms

go_id
13108 GO:0007169
16740 GO:0006874
17949 GO:0007566
23521 GO:0009968
24787 GO:0010817
27729 GO:0042981
33709 GO:0022411
48275 GO:0040015
65425 GO:0048468
69993 GO:0051149
72176 GO:0051896
72261 GO:0051924
78370 GO:0070374
80291 GO:0071375

Term
13108 transmembrane receptor protein tyrosine kinase signaling pathway
cellular calcium ion homeostasis
16740
embryo implantation
17949
negative regulation of signal transduction
23521
regulation of hormone levels
24787
regulation of apoptotic process
27729
cellular component disassembly
33709
negative regulation of multicellular organism growth
48275
65425
cell development
positive regulation of muscle cell differentiation
69993
regulation of protein kinase B signaling
72176
72261
regulation of calcium ion transport
positive regulation of ERK1 and ERK2 cascade
78370
cellular response to peptide hormone stimulus
80291

14

Definition

A series of molecular signals initiated by the binding of an extracellular ligand to a receptor on the surface of the target cell where the receptor possesses tyrosine kinase activity, and ending with regulation of a downstream cellular process, e.g. transcription.

13108
16740
17949
23521
24787 Any process that modulates the levels of hormone within an organism or a tissue. A hormone is any substance formed in very small amounts in one specialized organ or group of cells and carried (sometimes in the bloodstream) to another organ or group of cells in the same organism, upon which it has a specific regulatory action.
27729
33709
48275
65425
69993
72176
72261
78370
80291

The process whose specific outcome is the progression of the cell over time, from its formation to the mature structure. Cell development does not include the steps involved in committing a cell to a specific fate.

Any process that modulates the frequency, rate or extent of the directed movement of calcium ions into, out of or within a cell, or between cells, by means of some agent such as a transporter or pore.

Any process that modulates the frequency, rate or extent of protein kinase B signaling, a series of reactions mediated by the intracellular serine/threonine kinase protein kinase B.

Any process that activates or increases the frequency, rate or extent of signal transduction mediated by the ERK1 and ERK2 cascade.

Any process that activates or increases the frequency, rate or extent of muscle cell differentiation.

Any process involved in the maintenance of an internal steady state of calcium ions at the level of a cell.

Any process that stops, prevents, or reduces the frequency, rate or extent of signal transduction.

Attachment of the blastocyst to the uterine lining.

Any process that stops, prevents, or reduces the frequency, rate or extent of growth of an organism to reach its usual body size.

Any process that modulates the occurrence or rate of cell death by apoptotic process.

A cellular process that results in the breakdown of a cellular component.

Any process that results in a change in state or activity of a cell (in terms of movement, secretion, enzyme production, gene expression, etc.) as a result of a peptide hormone stimulus. A peptide hormone is any of a class of peptides that are secreted into the blood stream and have endocrine functions in living animals.

$p.values

GO:0048468

GO:0040015

GO:0070374
0.0001285760 0.0042724894 0.0042724894 0.0095510660 0.0081179693 0.0026411769
GO:0071375
0.0026411769 0.0044876817 0.0007646973 0.0003840363 0.0067952996 0.0026411769

GO:0051924

GO:0051896

GO:0009968

GO:0010817

GO:0006874

GO:0007566

GO:0051149

GO:0022411

GO:0007169

GO:0042981
0.0002359377 0.0050978566

‘

$genes
$genes$
[1] "8614" "9518"

GO:0040015

‘

$genes$

GO:0048468
[1] "100533183" "11344"
[7] "1956"
[13] "2889"
[19] "4908"
[25] "6794"
[31] "84816"

"2066"
"30819"
"51361"
"6845"
"885"

‘

‘

‘

‘

"1399"
"23136"
"375387"
"55124"
"706"
"9518"

"1482"
"2624"
"388939"
"5518"
"780"

"1522"
"26508"
"4193"
"5597"
"79048"

"166614"
"2852"
"4825"
"6198"
"80336"

"147495" "1482"

$genes$

GO:0009968

[1] "100"
[9] "245928" "2624"
"4193"

[17] "4087"
[25] "64081" "64388" "64411" "65997" "6609"
[33] "9518"

"26508" "2852"
"5054"
"4534"

"154043" "163126" "1956"
"2889"
"54894" "5518"
"6794"

"2060"

"2066"

"375387" "406888" "406895"

"55612" "6198"
"9516"
"780"

15

‘

‘

‘

‘

‘

‘

‘

‘

‘

‘

‘

‘

‘

‘

‘

‘

‘

‘

‘

‘

‘

‘

[1] "1522" "1956" "25874" "2852" "4087" "4825" "54795" "6845" "706"

[10] "8614" "8694" "91942" "9607"

[1] "1901" "2149" "23075" "2624" "2852" "5145" "5336" "53373" "54795"

[10] "5816" "6543" "8614"

$genes$
[1] "1399" "1956" "2066" "2149" "2852" "2889" "780"

GO:0070374

"2852"

"5336"

"6769"

"706"

"8614"

"2066"

"2252"

"2852"

"2889"

"406888" "4534"

"6794"

$genes$

GO:0010817

$genes$

GO:0006874

$genes$
[1] "196996" "2149"

GO:0051924

GO:0051896

$genes$
[1] "1956"
[9] "9518"

$genes$
[1] "780"

GO:0007566

"81671" "85360" "8614"

$genes$
[1] "2852" "9518" "9643"

GO:0051149

$genes$

GO:0022411

[1] "11344" "130271" "1471"
[9] "706"

"780"

"81930"

"23075" "23274" "2852"

"440738" "65005"

$genes$
[1] "2852"

GO:0071375

$genes$

GO:0007169

"406895" "4193"

"4825"

"6198"

"9518"

"990"

[1] "1173"
"1956"
[9] "406895" "4908"

"2060"
"6198"

"2066"
"780"

"2252"
"9518"

"2852"

"2889"

"3185"

$genes$

GO:0042981

[1] "100"
[7] "1956"
[13] "3665"
[19] "5054"
[25] "65122"
[31] "84524"

"100287441" "10181"
"2066"
"3778"
"5055"
"6609"
"885"

"2149"
"406948"
"5518"
"706"
"9518"

"1482"
"23097"
"4193"
"55679"
"728386"
"9521"

"1522"
"2624"
"4869"
"5611"
"780"
"9870"

"1612"
"2852"
"4908"
"6198"
"79228"

16

References

Alexa, A., Rahnenf¨uhrer, J., and Lengauer, T. (2006). Improved scoring of functional
groups from gene expression data by decorrelating GO graph structure. Bioinformat-
ics, 22(13):1600 – 1607.

Cortes, C. and Vapnik, V. (1995). Support vector networks. Machine Learning, 20:273

– 297.

Couto, F., Silva, M., and Coutinho, P. (2003). Implementation of a Functional Semantic
Similarity Measure between Gene-Products. Technical Report DI/FCUL TR 03–29,
Department of Informatics, University of Lisbon.

Couto, F., Silva, M., and Coutinho, P. (2005). Semantic Similarity over the Gene On-
In Conference in

tology: Family Correlation and Selecting Disjunctive Ancestors.
Information and Knowledge Management.

del Pozo, A., Pazos, F., and Valencia, A. (2008). Deﬁning functional distances over gene

ontology. BMC Bioinformatics, 9:50.

Fr¨ohlich, H., Speer, N., Poustka, A., and Beissbarth, T. (2007). GOSim - An R-Package
for Computation of Information Theoretic GO Similarities Between Terms and Gene
Products. BMC Bioinformatics, 8:166.

Fr¨ohlich, H., Speer, N., and Zell, A. (2006). Kernel based functional gene grouping. In

Proc. Int. Joint Conf. Neural Networks, pages 6886 – 6891.

Jiang, J. and Conrath, D. (1998). Semantic similarity based on corpus statistics and
lexical taxonomy. In Proceedings of the International Conference on Research in Com-
putational Linguistics, Taiwan.

Lerman, G. and Shakhnovich, B. E. (2007). Deﬁning functional distance using manifold
embeddings of gene ontology annotations. Proc Natl Acad Sci U S A, 104(27):11334–
11339.

Lin, D. (1998). An information-theoretic deﬁnition of similarity. In Kaufmann, M., edi-
tor, Proceedings of the 15th International Conference on Machine Learning, volume 1,
pages 296–304, San Francisco, CA.

Lord, P., Stevens, R., Brass, A., and Goble, C. (2003). Semantic similarity measures
as tools for exploring the gene ontology. In Proceedings of the Paciﬁc Symposium on
Biocomputing, pages 601–612.

Mehlhorn, K. and N¨aher, S. (1999). The LEDA Platform of Combinatorial and Geo-

metric Computing. Cambridge University Press.

17

Mistry, M. and Pavlidis, P. (2008). Gene ontology term overlap as a measure of gene

functional similarity. BMC Bioinformatics, 9:327.

Pesquita, C., Faria, D., Bastos, H., Falcao, A., and Couto, F. (2007). Evaluating go-
In Proc. 10th Annual Bio-Ontologies Meeting

based semantic similarity measures.
2007, volume 2007, pages 37 – 40.

Resnik, P. (1995). Using information content to evaluate semantic similarity in a tax-
onomy. In Proceedings of the 14th International Joint Conference on Artiﬁcial Intel-
ligence, volume 1, pages 448–453, Montreal.

Resnik, P. (1999). Semantic similarity in a taxonomy: An information-based measure and
its application to problems of ambigiguity in natural language. Journal of Artiﬁcial
Intelligence Research, 11:95–130.

Rousseeuw, P. (1987). Silhouettes: a graphical aid to the interpretation and validation

of cluster analysis. J. Comp. and Applied Mathematics, 20:53–65.

Schlicker, A., Domingues, F. S., Rahnenf¨uhrer, J., and Lengauer, T. (2006). A new
measure for functional similarity of gene products based on Gene Ontology. BMC
Bioinformatics, 7:302.

Sch¨olkopf, B. and Smola, A. J. (2002). Learning with Kernels. MIT Press, Cambridge,

MA.

Speer, N., Fr¨ohlich, H., Spieth, C., and Zell, A. (2005). Functional grouping of genes
using spectral clustering and gene ontology. In Proc. Int. Joint Conf. Neural Networks,
pages 298 – 303.

The Gene Ontology Consortium (2004). The gene ontology (GO) database and infor-

matics resource. Nucleic Acids Research, 32:D258–D261.

18

