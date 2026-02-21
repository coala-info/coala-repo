— Nested Eﬀects Models —
An example in Drosophila immune response

Holger Fr¨ohlich*

Florian Markowetz(cid:132)

April 24, 2017

Abstract

Cellular signaling pathways, which are not modulated on a tran-
scriptional level, cannot be directly deduced from expression proﬁling
experiments. The situation changes, when external interventions like
RNA interference or gene knock-outs come into play.

In [11, 12, 3, 4, 15, 6] algorithms were introduced to infer non-
transcriptional pathway features based on diﬀerential gene expression
in silencing assays. These methods are implemented in the Bioconduc-
tor package nem. Here we demonstrate its practical use in the context
of an RNAi data set investigating the response to microbial challenge
in Drosophila melanogaster.

We show in detail how the data is pre-processed and discretized,
how the pathway can be reconstructed by diﬀerent approaches, and
how the ﬁnal result can be post-processed to increase interpretability.

1 Drosophila RNAi data

We applied our method to data from a study on innate immune response in
Drosophila [2]. Selectively removing signaling components blocked induction
of all, or only parts, of the transcriptional response to LPS.

Dataset summary The dataset consists of 16 Aﬀymetrix-microarrays: 4
replicates of control experiments without LPS and without RNAi (negative
controls), 4 replicates of expression proﬁling after stimulation with LPS
but without RNAi (positive controls), and 2 replicates each of expression

*University of Bonn, Bonn-Aachen International Center for Information Technology,

frohlich@bit.uni-bonn.de

(cid:132)Cancer Research UK, Florian.Markowetz@cancer.org.uk

1

proﬁling after applying LPS and silencing one of the four candidate genes
tak, key, rel, and mkk4/hep.

Preprocessing and E-gene selection For preprocessing, we perform
normalization on probe level using a variance stabilizing transformation (Hu-
ber et al., 2002), and probe set summarization using a median polish ﬁt of
an additive model (Irizarry et al., 2003). The result is included as a dataset
in the package nem.

> library(nem)
> data("BoutrosRNAi2002")

The function nem.discretize implements the following two preprocessing
steps: First, we select the genes as eﬀect reporters (E-genes), which are
more then two-fold upregulated by LPS treatment. Next, we transform the
continuous expression data to binary values. We set an E-genes state in an
RNAi experiment to 1 if its expression value is suﬃciently far from the mean
of the positive controls, i.e. if the intervention interrupted the information
ﬂow. If the E-genes expression is close to the mean of positive controls, we
set its state to 0.
Let Cik be the continuous expression level of Ei in experiment k. Let µ+
i be
the mean of positive controls for Ei, and µ−
i the mean of negative controls.
To derive binary data Eik, we deﬁned individual cutoﬀs for every gene Ei
by:

(cid:40)

Eik =

1 if Cik < κ · µ+
0 else.

i + (1 − κ) · µ−
i ,

(1)

> res.disc <- nem.discretize(BoutrosRNAiExpression,neg.control=1:4,pos.control=5:8,cutoff=.7)

discretizing with respect to POS and NEG controls

Estimating error probabilities From the positive and negative controls,
we can estimate the error probabilities α and β. The type I error α is the
number of positive controls discretized to state 1, and the type II error β is
the number of negative controls in state 0. To guard against unrealistically
low estimates we add pseudo counts. The error estimates are included into
the discretization results:

> res.disc$para

2

Figure 1: Continuous and discretized data

a

b
0.19 0.07

3

Original dataExperimentsE−genescontrolcontrolcontrolcontrolLPSLPSLPSLPSrelrelkeykeytaktakmkk4hepmkk4hepCG11141CG5346CG3348CG7956KrT95DCG18214CG4057JraCG17723AnnIXFimRac2CG13503CG6449CG9208CG13893CG4859CG3884CG8805CG15900CG11066CG13117CG13780Nhe3EG:95B7.1GliCG5835wunRhoLpucCG7816CecA1CecA2CG14704RelCG10794CG4437LD32282Su(dx)CG12703locoshnlamaCG6725CG5775CG10076CG7629CG12505AttACG8046CG8177CG15678CG18372CG6701CG11709MtkDroCecCCecBCG1225CG8008HL1913.CG11798CG1141CG7778GH13327CG14567CG7142Discretized dataExperimentscontrolcontrolcontrolcontrolLPSLPSLPSLPSrelrelkeykeytaktakmkk4hepmkk4hep2 Applying Nested Eﬀects Models

Which model explains the data best? With only four S-genes, we can ex-
haustively enumerate all pathway models and search the whole space for the
best-ﬁtting model. To score these models use either the marginal likelihood
depending on α and β (details found in Markowetz et al. (2005)) or the full
marginal likelihood depending on hyperparameters (details in [10]).

In cases, where exhaustive search over model space is infeasible (i.e. when
we have more than 4 or 5 perturbed genes) several heuristics have been
developed and integrated into the nem package:

(cid:136) edge-wise and triplets learning [12]

(cid:136) greedy hillclimbing

(cid:136) module networks [3, 4]

(cid:136) alternating MAP optimization [15]

An interface to all inference techniques is provided by the function nem.

2.1 Exhaustive search by marginal likelihood

Scoring models by marginal log-likelihood is implemented in function score.
Input consists of models, data and the type of the score ("mLL", "FULLmLL",
"CONTmLL", "CONTmLLBayes", "CONTmLLMAP"). Furthermore, there are sev-
eral additional options, which allow you to specify parameters, priors for
the network structure and for the position of E-genes, and so on. The score
types "mLL" and "FULLmLL" refer to discretized data, which we use in this
example. The score types "CONTmLL", "CONTmLLBayes", "CONTmLLMAP" are
discussed in Section 2.9. With type "mLL" we need to pass error probabilities
alpha and beta in the argument para. Since version 1.5.4 all parameters are
summarized in one hyperparameter, which is passed to the main function
nem. For convenience a function set.default.parameters has been intro-
duced, which allows to change speciﬁc parameters, while all others are set
to default values.

> hyper = set.default.parameters(unique(colnames(res.disc$dat)), para=res.disc$para)
> result <- nem(res.disc$dat,inference="search",control=hyper, verbose=FALSE)
> result

scores for 355 models
--> best model is number 334

4

(default: 1): 1

Information on this model:
Object of class score

$graph: phenotypic hierarchy (graphNEL object) with genes
Inference scheme: mLL
log posterior (marginal) likelihood $mLL: -240.8066
Error probabilities alpha and beta: 0.19 0.07
network structure regularization parameter $lambda (default: 0): 0
’
Prior weight $delta for assigning E-genes to virtual S-gene
67 selected E-genes:
--> rel : 30 attached E-genes
--> key : 30 attached E-genes
--> tak : 9 attached E-genes
--> mkk4hep : 28 attached E-genes
--> null : 1 attached E-genes

null

’

NOTE: One E-gene can be attached to multiple S-genes

The output contains the highest scoring model (result$graph), a vector of
scores (result$mLL) and a list of E-gene position posteriors (result$pos),
and a MAP estimate of E-gene positions (result$mappos). We can plot the
results using the commands:

> plot.nem(result,what="graph")
> plot.nem(result,what="mLL")
> plot.nem(result,what="pos")

Figure 2: The ﬁve silencing schemes getting high scores in Fig. 3. It takes
a second to see it, but Nr.2 to 5 are not that diﬀerent from Nr.1. The main
feature, ie. the branching downstream of tak is conserved in all of them.

5

− 1 −relkeytakmkk4hep− 2 −relkeytakmkk4hep− 3 −relkeytakmkk4hep− 4 −relkeytakmkk4hep− 5 −relkeytakmkk4hepFigure 3: The best 30 scores

6

llllllllllllllllllllllllllllll051015202530−320−280−240Score distribution30 top ranked modelsMarginal log−likelihoodlFigure 4: Posterior distributions of E-gene positions given the highest scor-
ing silencing scheme (Nr. 1 in Fig. 2). The MAP estimate corresponds to
the row-wise maximum.

7

Posterior effect positionsPerturbationsEffect reportersrelkeytakmkk4hepnullAttACG8177KrT95DCG6725RhoLCG1141pucCG5775wunCG10076CG5835CG1225CG5346Su(dx)CG8008CecA1CecA2CecBCecCGliDroMtkEG:95B7.1Nhe3CG11709CG12703CG13780CG13117CG11066CG15900CG8046CG8805CG3884CG6701CG12505CG18372CG10794CG15678CG4859CG13893CG18214CG9208CG4437CG6449CG14567CG7629CG7142CG7956CG3348GH13327HL1913.LD32282RellocoCG7816CG7778CG14704shnCG13503Rac2FimAnnIXlamaCG17723CG11798JraCG4057CG111412.2 Exhaustive search Full marginal likelihood

Additionally to what we did in the paper [11] the PhD thesis [10] contains
equations for a “full marginal likelihood” in which error probabilities α and
β are integrated out. This section shows that using this score we learn the
same pathways as before.

> hyper$type="FULLmLL"
> hyper$hyperpara=c(1,9,9,1)
> result2 <- nem(res.disc$dat,inference="search",control=hyper,verbose=FALSE)
> result2

scores for 355 models
--> best model is number 334
Information on this model:
Object of class score

$graph: phenotypic hierarchy (graphNEL object) with genes
Inference scheme: FULLmLL
log posterior (marginal) likelihood $mLL: -242.925
Hyperparameters for error probability distributions: 1 9 9 1
network structure regularization parameter $lambda (default: 0): 0
’
Prior weight $delta for assigning E-genes to virtual S-gene
67 selected E-genes:
--> rel : 30 attached E-genes
--> key : 30 attached E-genes
--> tak : 9 attached E-genes
--> mkk4hep : 28 attached E-genes
--> null : 1 attached E-genes

null

’

(default: 1): 1

NOTE: One E-gene can be attached to multiple S-genes

Figure 5: Same topologies as before.

8

− 1 −relkeytakmkk4hep− 2 −relkeytakmkk4hep− 3 −relkeytakmkk4hep− 4 −relkeytakmkk4hep− 5 −relkeytakmkk4hepFigure 6: The best 30 scores by full marginal likelihood

9

llllllllllllllllllllllllllllll051015202530−340−300−260Score distribution30 top ranked modelsMarginal log−likelihoodlFigure 7: Posterior distributions of E-gene positions given the highest scor-
ing silencing scheme (Nr. 1 in Fig. 5). The MAP estimate corresponds to
the row-wise maximum.

10

Posterior effect positionsPerturbationsEffect reportersrelkeytakmkk4hepnullAttACG8177KrT95DCG6725RhoLCG1141pucCG5775wunCG10076CG5835CG1225CG5346Su(dx)CG8008CecA1CecA2CecBCecCGliDroMtkEG:95B7.1Nhe3CG11709CG12703CG13780CG13117CG11066CG15900CG8046CG8805CG3884CG6701CG12505CG18372CG10794CG15678CG4859CG13893CG18214CG9208CG4437CG6449CG14567CG7629CG7142CG7956CG3348GH13327HL1913.LD32282RellocoCG7816CG7778CG14704shnCG13503Rac2FimAnnIXlamaCG17723CG11798JraCG4057CG111412.3 Edge-wise learning

Instead of scoring whole pathways, we can learn the model edge by edge [12].
For each pair of genes A and B we infer the best of four possible models:
A · ·B (unconnected), A → B (eﬀects of A are superset of eﬀects of B),
A ← B (subset), and A ↔ B (undistinguishable eﬀects).

> resultPairs <- nem(res.disc$dat,inference="pairwise",control=hyper, verbose=FALSE)
> resultPairs

Object of class pairwise

$graph: phenotypic hierarchy (graphNEL object) with genes
Inference scheme: FULLmLL
log posterior (marginal) likelihood $mLL: -260.3361
Hyperparameters for error probability distributions: 1 9 9 1
network structure regularization parameter $lambda (default: 0): 0
’
Prior weight $delta for assigning E-genes to virtual S-gene
67 selected E-genes:
--> rel : 30 attached E-genes
--> key : 30 attached E-genes
--> tak : 9 attached E-genes
--> mkk4hep : 28 attached E-genes
--> null : 1 attached E-genes

null

’

NOTE: One E-gene can be attached to multiple S-genes

$scores: posterior distributions of local models

(default: 1): 1

Summary of MAP estimates:
all .. -> <->
1

6

3

2

11

Figure 8: Result of edge-wise learning. Compare this to the result from
global search. It looks exactely the same.

12

relkeytakmkk4hep2.4 Inference from triples

Edge-wise learning assumes independence of edges. But this is not true in
transitively closed graphs, where a direct edge must exist whenever there is
a longer path between two nodes. Natural extension of edge-wise learning
is inference from triples of nodes [12]. In the package nem we do it by

> resultTriples <- nem(res.disc$dat,inference="triples",control=hyper, verbose=FALSE)

4 perturbed genes -> 4 triples to check (lambda = 0 )

> resultTriples

Object of class triples

$graph: phenotypic hierarchy (graphNEL object) with genes
Inference scheme: FULLmLL
log posterior (marginal) likelihood $mLL: -242.925
Hyperparameters for error probability distributions: 1 9 9 1
network structure regularization parameter $lambda (default: 0): 0
’
Prior weight $delta for assigning E-genes to virtual S-gene
67 selected E-genes:
--> rel : 30 attached E-genes
--> key : 30 attached E-genes
--> tak : 9 attached E-genes
--> mkk4hep : 28 attached E-genes
--> null : 1 attached E-genes

null

’

(default: 1): 1

NOTE: One E-gene can be attached to multiple S-genes

13

Figure 9: Result of triple learning. Compare this to the result from global
search and pairwise learning

14

relkeytakmkk4hep2.5 Inference with greedy hillclimbing

Greedy hillclimbing is a general search and optimization strategy known
from the literature [14]. Given an initial network hypothesis (usually an
empty graph) we want to arrive at a local maximum of the likelihood function
by successively adding that edge, which adds the most beneﬁt to the current
network’s likelihood. This procedure is continued until no improving edge
can be found any more.

> resultGreedy <- nem(res.disc$dat,inference="nem.greedy",control=hyper, verbose=FALSE)

Greedy hillclimber for 4 S-genes (lambda = 0 )...

> resultGreedy

Object of class nem.greedy

$graph: phenotypic hierarchy (graphNEL object) with genes
Inference scheme: FULLmLL
log posterior (marginal) likelihood $mLL: -242.925
Hyperparameters for error probability distributions: 1 9 9 1
network structure regularization parameter $lambda (default: 0): 0
’
Prior weight $delta for assigning E-genes to virtual S-gene
67 selected E-genes:
--> rel : 30 attached E-genes
--> key : 30 attached E-genes
--> tak : 9 attached E-genes
--> mkk4hep : 28 attached E-genes
--> null : 1 attached E-genes

null

’

(default: 1): 1

NOTE: One E-gene can be attached to multiple S-genes

15

Figure 10: Result of greedy hillclimbing. It is exactly the same as for the
exhaustive search.

16

relkeytakmkk4hepFigure 11: Basic idea of module networks: By successively moving down the
cluster hierarchy we identify the clusters (modules) of S-genes, which are
marked in red. They contain 4 S-genes at most and can be estimated via
exhaustive search.

2.6 Inference with module networks

Rather than looking for a complete network hypothesis at once the idea of
the module network is to build up a graph from smaller subgraphs, called
modules in the following [3, 4]. The module network is thus a divide and
conquer approach: We ﬁrst perform a hierarchical clustering of the prepro-
cessed expression proﬁles of all S-genes, e.g. via average linkage. The idea
is that S-genes with a similar E-gene response proﬁle should be close in the
signaling path. We now successively move down the cluster tree hierarchy
until we ﬁnd a cluster with only 4 S-genes at most. Figure 11 illustrates
the idea with an assumed network of 10 S-genes. At the beginning we ﬁnd
S8 as a cluster singleton. Then by successively moving down the hierarchy
we identify clusters S6, S7, S1, S10, S3, S2, S5 and S4, S9. All these clusters
(modules) contain 4 S-genes at most and can thus be estimated by taking
the highest scoring of all possible network hypotheses.

Once all modules have been estimated their connections are constructed.

17

For this purpose two diﬀerent approaches have been proposed:

(cid:136) In the original publication [3] pairs of modules are connected ignoring
the rest of the network. That means between a pair of modules all
(at most 4096) connection possibilities going from nodes in the ﬁrst
to nodes in the second module are tested. The connection model with
highest likelihood is kept. This approach does not guarantee to reach
a local maximum of the complete network, but only needs O(|S −
genes|2) likelihood evaluations.

(cid:136) In [4] a constraint greedy hill-climber is proposed: We successively
add that edge between any pair of S-genes being contained in diﬀerent
modules, which increases the likelihood of the complete network most.
This procedure is continued until no improvement can be gained any
more, i.e. we have reached a local maximum of the likelihood function
for the complete network.

In the package nem we call the module network by

> resultMN <- nem(res.disc$dat,inference="ModuleNetwork",control=hyper, verbose=FALSE) # this will do exactly the same as the exhaustive search
> resultMN.orig <- nem(res.disc$dat,inference="ModuleNetwork.orig",control=hyper, verbose=FALSE) # this will do exactly the same as the exhaustive search

18

2.7 Alternating optimization

The alternating optimization scheme was proposed in [15]. In contrast to
the original approach by Markowetz et al. [11] there is a MAP estimate of
the linking positions of E-genes to S-genes. The algorithm works as follows:
Starting with an initial estimate of the linking of E-genes to S-genes from
the data, we perform an alternating MAP optimization of the S-genes graph
and the linking graph until convergence. As a ﬁnal step we ﬁnd a transi-
tively closed graph most similar to the one resulting from the alternating
optimization.

> resGreedyMAP <- nem(BoutrosRNAiLods, inference="nem.greedyMAP", control=hyper, verbose=FALSE)

Alternating optimization for 4 S-genes (lambda = 0 )...

> resGreedyMAP

Object of class nem.greedyMAP

$graph: phenotypic hierarchy (graphNEL object) with genes
Inference scheme: CONTmLLMAP
log posterior (marginal) likelihood $mLL: 254.5843
network structure regularization parameter $lambda (default: 0): 0
’
Prior weight $delta for assigning E-genes to virtual S-gene
37 selected E-genes:
--> rel : 17 attached E-genes
--> key : 17 attached E-genes
--> tak : 20 attached E-genes
--> mkk4hep : 0 attached E-genes
--> null : 31 attached E-genes

null

’

(default: 1): 1

NOTE: One E-gene can be attached to multiple S-genes

19

Figure 12: Result of the alternating MAP optimization.

20

relkeytakmkk4hep2.8 Incorporating prior Assumptions

2.8.1 Regularization

The nem package allows to specify a prior on the network structure itself.
This can be thought of biasing the score of possible network hypotheses
towards prior knowledge. It is crucial to understand that in principle in any
inference scheme there exist two competing goals: Belief in prior assumptions
/ prior knowledge versus belief in data. Only trusting the data itself may
lead to overﬁtting, whereas only trusting in prior assumptions does not give
any new information and prevents learning. Therefore, we need a trade-oﬀ
between both goals via a regularization constant λ > 0, which speciﬁes the
belief in our prior assumptions. In the simplest case our assumption could
be that the true network structure is sparse, i.e. there are only very few
edges. More complex priors could involve separate prior edge probabilities
(c.f. [3, 4]).

> hyper$Pm = diag(4)
> hyper$lambda = 10
> resultRegularization <- nem(res.disc$dat, inference="search", control=hyper, verbose=FALSE)
> resultRegularization

scores for 355 models
--> best model is number 125
Information on this model:
Object of class score

$graph: phenotypic hierarchy (graphNEL object) with genes
Inference scheme: FULLmLL
log posterior (marginal) likelihood $mLL: -265.664
Hyperparameters for error probability distributions: 1 9 9 1
network structure regularization parameter $lambda (default: 0): 10
Prior weight $delta for assigning E-genes to virtual S-gene
67 selected E-genes:
--> rel : 3 attached E-genes
--> key : 30 attached E-genes
--> tak : 9 attached E-genes
--> mkk4hep : 28 attached E-genes
--> null : 1 attached E-genes

null

’

’

(default: 1): 1

NOTE: One E-gene can be attached to multiple S-genes

In practice we would like to choose a λ in an automated fashion. This leads
to an instance of the classical model selection problem (e.g. [8]) in statistical

21

Figure 13: Result of module network learning with regularization towards
sparse graph structures (λ = 10).

learning. One way of dealing with it is to tune λ such that the Bayesian
information criterion (BIC)

BIC(λ, Φopt) = −2 log P (D|Φopt) + log(n)d(λ, Φopt)

(2)

becomes minimal [8]. Here d(λ, Φopt) denotes the number of parameters
in the highest scoring network structure Φopt haven n S-genes. Here the
number of parameters is estimated as:

d(λ, Φ) =

(cid:88)

i,j

1|Φij − ˆΦij |>0

(3)

where ˆΦ is the prior network.

> resultModsel <- nemModelSelection(c(0.01,1,100),res.disc$dat, control=hyper,verbose=FALSE)

Greedy hillclimber for 4 S-genes (lambda = 0.01 )...

Greedy hillclimber for 4 S-genes (lambda = 1 )...

Greedy hillclimber for 4 S-genes (lambda = 100 )...

2.8.2 Bayesian Model Selection

Searching for an optimal regularization constant relates to a frequentistic
point of view to incorporate prior knowledge.
Instead, from a Bayesian
perspective one should deﬁne a prior on the regularization parameter and
integrate it out. Here, this is done by assuming an inverse gamma distribu-
tion prior on ν = 1
2λ with hyperparameters 1, 0.5, which leads to a simple

22

relkeytakmkk4hepFigure 14: Result of module network learning with regularization towards
sparse graph structures and automatic model selection.

closed form of the full prior [4]. An advantage of the Bayesian perspective
is that no explicit model selection step is needed. Furthermore, there is
evidence, that compared to the frequentistic method the Bayesian approach
using the same amount of prior knowledge yields a higher increase of the
reconstructed network’s sensitivity

> hyper$lambda=0
> hyper$Pm

# set regularization parameter to 0

# this is our prior graph structure

[,1] [,2] [,3] [,4]
0
0
0
1

1
0
0
0

0
0
1
0

0
1
0
0

[1,]
[2,]
[3,]
[4,]

> resultBayes <- nem(res.disc$dat, control=hyper, verbose=FALSE) # now we use Bayesian model selection to incorporate the prior information

Greedy hillclimber for 4 S-genes (lambda = 0 )...

> resultBayes

Object of class nem.greedy

$graph: phenotypic hierarchy (graphNEL object) with genes
Inference scheme: FULLmLL
log posterior (marginal) likelihood $mLL: -260.3361
Hyperparameters for error probability distributions: 1 9 9 1
network structure regularization parameter $lambda (default: 0): 0
’
Prior weight $delta for assigning E-genes to virtual S-gene

null

’

(default: 1): 1

23

relkeytakmkk4hep67 selected E-genes:
--> rel : 30 attached E-genes
--> key : 30 attached E-genes
--> tak : 9 attached E-genes
--> mkk4hep : 28 attached E-genes
--> null : 1 attached E-genes

NOTE: One E-gene can be attached to multiple S-genes

Figure 15: Result of module network learning with a Bayesian network prior
favoring sparse graphs.

24

relkeytakmkk4hep2.9 Omitting the Data Discretization Step

In general, performing a data discretization on the expression proﬁles as
described in Sec. 1 can be critical, especially, if not both, positive and
negative controls are available. An alternative is given by taking the raw
p-value proﬁles obtained from testing for diﬀerential gene expression.
In
this situation we assume the individual p-values in the data matrix to be
drawn from a mixture of a uniform, a Beta(1, β) and a Beta(α, 1) distri-
bution. The parameters of the distribution are ﬁtted via an EM algorithm
[4]. The nem package supports such a data format using the options type =
"CONTmLLBayes" and type = "CONTmLLMAP" in the call of the function nem.
Moreover there is a function getDensityMatrix, which conveniently does
all the ﬁtting of the p-value densities and produces diagnostic plots into a
user speciﬁed directory. We always recommend to use the full microarray
without any ﬁltering for ﬁtting the p-value densities, since ﬁltering could
destroy the supposed form of the p-value distributions.

An alternative to the p-value density (which we do not recommend here from
our practical experience), is to use log-odds (B-values), which compare the
likelihood of diﬀerential expression with the likelihood of non-diﬀerential ex-
pression of a gene. B-values can be used in the nem package in the same way
as (log) p-value densities. The inference scheme type = "CONTmLLBayes"
corresponds to the original one in [11], where linkage positions of E-genes
to S-genes are integrated out. The inference scheme type = "CONTmLLMAP"
was proposed in [15], where we have a MAP estimate of linkage positions.

A further possibility to omit the data discretization step is to calculate the
eﬀect probability for each gene based on given the empirical distributions of
the controls. Note that for this purpose both, positive and negative controls
should be available.

> logdensities = getDensityMatrix(myPValueMatrix,dirname="DiagnosticPlots")
> nem(logdensities[res.disc$sel,],type="CONTmLLBayes",inference="search")
> nem(logdensities[res.disc$sel,],type="CONTmLLMAP",inference="search")
> preprocessed <- nem.cont.preprocess(BoutrosRNAiExpression,neg.control=1:4,pos.control=5:8)
> nem(preprocessed$prob.influenced,type="CONTmLL",inference="search")

25

2.10 Selection of E-Genes

There exists two mechanisms to select E-genes implemented in nem, which
can be used complementary to each other [6]:

(cid:136) A-priori ﬁltering of E-genes, which show a pattern of diﬀerential ex-

pression, which can be expected to be non-random

(cid:136) Automated subset selection of most relevant E-genes within the net-

work estimation procedure.

Automated subset selection of most relevant E-genes works as follows: A
virtual ”null” S-gene is used, to which E-genes are assigned, that are irrel-
evant. The prior probability for assigning an E-gene to the ”null” S-genes
is δ
n , where δ > 0 and n is the number of S-genes + 1. Since version >
2.18.0 E-gene selection is done per default. The parameter δ can optionally
be tuned via the BIC model selection criterion.

For a given network hypothesis we can also check, which E-Genes had the
highest positive contribution to the network hypothesis.

> mydat = filterEGenes(Porig, logdensities) # a-priori filtering of E-genes
> hyper$selEGenes = TRUE
> hyper$type = "CONTmLLBayes"
> resAuto = nem(mydat,control=hyper) # use filtered data to estimate a network; perform automated subset selection of E-genes with tuning of the parameter delta
> most.relevant = getRelevantEGenes(as(resAuto$graph, "matrix"), mydat)$selected # returns all E-genes with partial log-likelihood > 0.

26

2.11 Statistical Stability and Signiﬁcance

An important step after network inference is some kind of validation. In ab-
scence of the true network this step is rather diﬃcult. We have implemented
several possible tests, which may also be used in addition to each other [6]:

(cid:136) Statistical signiﬁcance: Possibly the least demand we have for our in-
ferred network is, that it should be signiﬁcantly superior to a random
one. We sample N (default 1000) random networks from a null dis-
tribution and compare their marginal posterior likelihood to that of
the estimated network. The fraction of how often a random network
is better than the inferred one yields an exact p-value. An alternative
to draw completely random networks, is to permute the node labels
of the inferred network. This yields a degree distribution, which is
always the same as in the inferred network.

(cid:136) Bootstrapping: We wish our network to be stable against small changes
in our set of E-genes. Therefore, we use bootstrapping: We sample m
E-genes with replacement for N times (default 1000) and run the net-
work inference on each bootstrap sample. At the end we count for each
edge how often it was inferred in all N bootstrap runs. This yields
a probability for each edge. We then may only consider edges with a
probability above some threshold (e.g. 50

(cid:136) Jackknife: We also wish the rest of our network to be stable against
removal of S-genes. Therefore, we use the jackknife: Each S-gene is
left out once and the network inference run on the other S-genes. At
the end we count for each edge, how often it was inferred. This yields
a jackknife probability for each edge, which then may be used to ﬁlter
edges.

(cid:136) Consensus models: We perform both, bootstrapping and jackknife. At
the end we then only keep edges appearing more frequently than some
threshold in BOTH procedures.

> significance=nem.calcSignificance(disc$dat,res) # assess statistical significance
> bootres=nem.bootstrap(res.disc$dat) # bootstrapping on E-genes
> jackres=nem.jackknife(res.disc$dat) # jackknife on S-genes
> consens=nem.consensus(res.disc$dat) # bootstrap & jackknife on S-genes

27

2.12 Nested Eﬀects Models as Bayesian Networks

Recently it has been shown that under certain assumptions (e.g. acyclicity
of the network graph) NEMs can be interpreted in the context of Bayesian
networks [16]. This interpretation gives rise to a diﬀerent formulation of
NEMs, which is also accessible within the nem package.

> hyper$mode="binary_Bayesian"
> resultBN = nem(res.disc$dat, inference="BN.greedy", control=hyper)

Figure 16: Result of Bayesian network learning

28

relkeytakmkk4hep2.13 MC EMiNEM - Learning NEMs via Expectation Max-

imization and MCMC

In [13] an Expectation Maximization (EM) coupled with a Markov Chain
Monte Carlo (MCMC) sampling strategy is proposed. More speciﬁcally, a
MCMC algorithm (called MCEMiNEM) is used to sample from the distri-
bution of all EM solutions, hence avoiding local optima. MCEMiNEM can
be used via:

> hyper$mcmc.nburnin = 10 # much to few in practice
> hyper$mcmc.nsamples = 100
> hyper$type = "CONTmLLDens"
> hyper$Pm = NULL
> resulteminem = nem(BoutrosRNAiLods, inference="mc.eminem", control=hyper)

mc.eminem algorithm

Figure 17: Result of Bayesian network learning

29

relkeytakmkk4hep2.14 Dynamic Nested Eﬀects Models

In [1] the authors describe a ﬁrst extension of NEMs to time series perturba-
tion data. That means after each perturbation gene expression is measured
at several time points. The model, called D-NEMs was successfully applied
to reverse engineer parts of a transcriptional network steering murine stem
cell development [9]. A second model for the same purpose was proposed in
[?]. Due to the employed likelihood model a highly eﬃcient computation is
possible here. It is thus particularly well suited for real world applications
and included in to the nem package. In addition to the original greedy algo-
rithm used in [7], we here provide a Markov Chain Monte Carlo (MCMC)
It includes a Bayesian way of including
algorithm for structure learning.
prior knowledge by drawing the weight of the structure prior (parameter
lambda) itself from an exponential distribution.

> data("Ivanova2006RNAiTimeSeries")
> dim(dat)
> control = set.default.parameters(dimnames(dat)[[3]], para=c(0.1,0.1))
> net = nem(dat, inference="dynoNEM", control=control)
> plot.nem(net, SCC=FALSE, plot.probs=TRUE)

30

2.15 Deterministic Eﬀects Propagation Networks

Deterministic Eﬀects Propagation Networks (DEPNs) [5] go in another di-
rection than NEMs and they are designed for a diﬀerent scenario: The basic
assumption is that we measure an unknown signaling network of proteins
by performing multiple interventions. These perturbations may aﬀect sin-
gle proteins at a time or may also be combinatorial, i.e. they aﬀect several
proteins at one time. For each protein in the network we monitor the ef-
fect of all interventions, typically via Reverse Phase Protein Arrays. Note
that each speciﬁc intervention not only inﬂuences direct targets, but may
also cause eﬀects on downstream proteins. We explicitly assume that in one
experiment all proteins are unperturbed (e.g. the cells are transfected only
with transfection reagent) .

DEPNs infer the most likely protein signaling network given measurements
In principle, the model
from multiple interventions along a time course.
works also with only one or a few time points, although accuracy gets higher
with more time points. Moreover, DEPNs can deal with latent network
nodes (proteins without measurements) and with missing data. Brieﬂy, the
idea is that we have an unknown network graph, where each node can have
two states: perturbed or unperturbed. Furthermore, attached to each node
we have experimental measurements, which are assumed to come from a
Gaussian distribution. The exact form of this distribution depends on the
perturbation state of the node (i.e. whether the protein is perturbed or not)
and on the time point of measurement.

Given a network hypothesis we can calculate the expected direct and indirect
eﬀects of a perturbation experiment. We should repeat at this point that
we assume to have one control experiment, where all nodes are known to be
unperturbed. Hence, we observe measurements for each node in the network
in the perturbed and the unperturbed state for each time point. With this
information we can estimate the conditional Gaussian distributions attached
to each node and ﬁnally the probability of observing the data under the given
network hypothesis.

DEPNs are accessible within the nem package since version 1.5.4:

> data(SahinRNAi2008)
> control = set.default.parameters(setdiff(colnames(dat.normalized),"time"), map=map.int2node, type="depn",debug=FALSE) # set mapping of interventions to perturbed nodes
> net = nem(dat.normalized, control=control) # greedy hillclimber to find most probable network structure

31

2.16

Infering Edge Directions

It may be interesting to infer edge types (up-regulation, down-regulation)
for a given nem model. For an edge a->b we look, whether b goes up or
down, if a is perturbed. If it goes up, an inhibition is assumed, otherwise an
activation.

> resEdgeInf = infer.edge.type(result, BoutrosRNAiLogFC)
> plot.nem(resEdgeInf, SCC=FALSE)

Figure 18: Inferred edge types: blue = inhibition, red = activation

32

relkeytakmkk4hep3 Visualization

> plotEffects(res.disc$dat,result)

Figure 19: plotting data according to inferred hierarchy

33

takmkk4heprelkeyrel:keymkk4heptaknull−1−0.8−0.6−0.3−0.10.10.30.60.814 Post-processing of results

Combining strongly connected components First, we identify all
nodes/genes which are not distinguishable given the data. This amounts
to ﬁnding the strongly connected components in the graph. Relish and Key
are now combined into one node.

> result.scc <- SCCgraph(result$graph,name=TRUE)
> plot(result.scc$graph)

Figure 20: The undistinguishable proﬁles of key and rel are summarized into
a single node.

Transitive reduction Additionally, in bigger graphs transitive.reduction
helps to see the structure of the network better. In this simple example there
are no shortcuts to remove.

34

rel:keymkk4heptakReferences

[1] B. Anchang, M. J. Sadeh, J. Jacob, A. Tresch, M. O. Vlad, P. J. Oefner,
and R. Spang. Modeling the temporal interplay of molecular signaling
and gene expression by using dynamic nested eﬀects models. Proc Natl
Acad Sci U S A, 106(16):6447–6452, Apr 2009.

[2] M. Boutros, H. Agaisse, and N. Perrimon. Sequential activation of
signaling pathways during innate immune responses in Drosophila. De-
velopmental Cell, 3(5):711 – 722, 2002.

[3] H. Fr¨ohlich, M. Fellmann, H. S¨ultmann, A. Poustka, and T. Beißbarth.
Large Scale Statistical Inference of Signaling Pathways from RNAi and
Microarray Data. BMC Bioinformatics, 8:386, 2007.

[4] H. Fr¨ohlich, M. Fellmann, H. S¨ultmann, A. Poustka, and T. Beißbarth.
Estimating Large Scale Signaling Networks through Nested Eﬀect Mod-
els with Intervention Eﬀects from Microarray Data. Bioinformatics,
24:2650–2656, 2008. doi: 10.1093/bioinformatics/btm634.

[5] H. Fr¨ohlich, O. Sahin, D. Arlt, C. Bender, and T. Beissbarth. De-
terministic Eﬀects Propagation Networks for Reconstructing Protein
Signaling Networks from Multiple Interventions. BMC Bioinformatics,
10:322, 2009.

[6] H. Fr¨ohlich, A. Tresch, and T. Beissbarth. Nested eﬀects models for
learning signaling networks from perturbation data. Biometrical Jour-
nal, 2(51):304 – 323, 2009.

[7] H. Fr¨ı¿‰hlich, P. Praveen, and A. Tresch. Fast and eﬃcient dynamic

nested eﬀects models. Bioinformatics, 27(2):238–244, Jan 2011.

[8] T. Hastie, R. Tibshirani, and J. Friedman. The Elements of Statistical

Learning. Springer, New York, NY, USA, 2001.

[9] N. Ivanova, R. Dobrin, R. Lu, I. Kotenko, J. Levorse, C. DeCoste,
X. Schafer, Y. Lun, and I. R. Lemischka. Dissecting self-renewal in
stem cells with rna interference. Nature, 442(7102):533–538, Aug 2006.

[10] F. Markowetz. Probabilistic Models for Gene Silencing Data. PhD

thesis, Free University Berlin, 2006.

[11] F. Markowetz, J. Bloch, and R. Spang. Non-transcriptional pathway
features reconstructed from secondary eﬀects of rna interference. Bioin-
formatics, 21(21):4026 – 4032, 2005.

35

[12] F. Markowetz, D. Kostka, O. Troyanskaya, and R. Spang. Nested ef-
fects models for high-dimensional phenotyping screens. Bioinformatics,
23:i305 – i312, 2007.

[13] T. Niederberger, S. Etzold, M. Lidschreiber, K. C. Maier, D. E. Martin,
H. Fr ˜A¶hlich, P. Cramer, and A. Tresch. Mc eminem maps the inter-
action landscape of the mediator. PLoS Comput Biol, 8(6):e1002568,
06 2012.

[14] S. Russel and P. Norvig. Artiﬁcial Intelligence - A Modern Approach.

Prentice Hall Inc., New Jersey, 1995.

[15] A. Tresch and F. Markowetz. Structure Learning in Nested Eﬀects
Models. Statistical Applications in Genetics and Molecular Biology,
7(1), 2008. in Press.

[16] C. Zeller, H. Fr¨ohlich, and A. Tresch. A bayesian network view on
nested eﬀects models. EURASIP Journal on Bioinformatics and Sys-
tems Biology, 195272, 2009. In Press.

Session Information

The version number of R and packages loaded for generating the vignette
were:

(cid:136) R version 3.4.0 (2017-04-21), x86_64-pc-linux-gnu

(cid:136) Locale: LC_CTYPE=en_US.UTF-8, LC_NUMERIC=C,

LC_TIME=en_US.UTF-8, LC_COLLATE=C, LC_MONETARY=en_US.UTF-8,
LC_MESSAGES=en_US.UTF-8, LC_PAPER=en_US.UTF-8, LC_NAME=C,
LC_ADDRESS=C, LC_TELEPHONE=C, LC_MEASUREMENT=en_US.UTF-8,
LC_IDENTIFICATION=C

(cid:136) Running under: Ubuntu 16.04.2 LTS

(cid:136) Matrix products: default

(cid:136) BLAS: /home/biocbuild/bbs-3.5-bioc/R/lib/libRblas.so

(cid:136) LAPACK: /home/biocbuild/bbs-3.5-bioc/R/lib/libRlapack.so

(cid:136) Base packages: base, datasets, grDevices, graphics, grid, methods,

parallel, stats, utils

(cid:136) Other packages: BiocGenerics 0.22.0, Rgraphviz 2.20.0, e1071 1.6-8,

graph 1.54.0, nem 2.50.0

36

(cid:136) Loaded via a namespace (and not attached): RBGL 1.52.0,

RColorBrewer 1.1-2, boot 1.3-19, class 7.3-14, compiler 3.4.0,
limma 3.32.0, plotrix 3.6-4, statmod 1.4.29, stats4 3.4.0, tools 3.4.0

37

