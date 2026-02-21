Rtreemix: a package for estimating mutagenetic trees
mixture models and genetic progression scores

Jasmina Bogojeska, J¨org Rahnenf¨uhrer

April 24, 2017
http://www.mpi-sb.mpg.de/∼jasmina

1

Introduction

The mixture of mutagenetic trees introduced in [1] is an evolutionary model that provides
an interpretable probabilistic framework for modeling multiple paths of ordered accumula-
tion of permanent genetic changes that can be used for describing many disease processes.
Each path captures a possible route of disease development. These models are used to
model HIV progression characterized by accumulation of resistance mutations in the viral
genome under drug pressure [1] and cancer progression by accumulation of chromosomal
aberrations in tumor cells [2]. From the mixture model, a genetic progression score (GPS)
can be computed for each patient [2] that gives an estimate of the disease progression and
can be used for specifying therapies or estimating survival times of the patients. Both the
mixture model itself and the derived GPS values are shown to improve the interpretation of
disease progression and to have predictive power for estimating the drug resistance in HIV
in [3] introduced the Mtreemix
[1] or the survival time in cancer [2]. Beerenwinkel et al.
package implemented in C/C++ that provides an eﬃcient code for estimating the mutage-
netic trees mixture models from cross-sectional data and using them for various predictions.
Building up on the Mtreemix software and using the C/C++ API that R provides, we cre-
ated the Rtreemix package. By reusing already existing C functions our package provides
the users with R functions as eﬃcient as the programs available in the Mtreemix. Simi-
lar to Mtreemix, the Rtreemix package provides functions for learning the mixture model
from given data, simulation, likelihood computation and estimation of the GPS values.
Furthermore, it introduces new functionality for estimating genetic progression scores with
corresponding bootstrap conﬁdence intervals and for performing stability analysis of the
mixture models [4].

2 Structure and Functionality

The class structure of the Rtreemix package is given in Figure 1.
In this way, all data
structures and information connected to some entity, like the mixture model or the data
for the model estimation, are packed together, which makes the code compact and easy to
understand and work with. In what follows we will present a working scenario in which
we will use and brieﬂy discuss most of the functions available in Rtreemix. More detailed
information about the parameters of all the functions used in the text bellow and their
default values can be found in the help ﬁles of the package. First, we load the package.

> library(Rtreemix)

1

Figure 1: Class diagram of the package Rtreemix. The diagram illustrates the classes with
their attributes and the relationships among them.

2.1 The Dataset and the RtreemixData class

The datasets used for estimating the mixture models consist of binary patterns that describe
the occurrence of a set of genetic events in a set of patients. Each pattern corresponds
to a single patient. The set of genetic events comprises genetic changes relevant for the
disease taken into consideration. In Rtreemix the data used for estimating a mutagenetic
trees mixture model is represented as an object of the class RtreemixData. We consider
the dataset from the Stanford HIV Drug Resistance Database [5] that comprises genetic
measurements of 364 HIV patients treated only with the drug zidovudine. This dataset is
given as an RtreemixData object hiv.data.RData in the data folder of the package and can
be loaded and displayed as follows.

> data(hiv.data)
> show(hiv.data) ## show the RtreemixData object

It should be also pointed out that a text ﬁle with a speciﬁc format can be used for creating
an object of class RtreemixData. An example of such ﬁle is the ﬁle treemix.pat in the

examples directory of the package. The text ﬁles used to create an RtreemixData object
should follow the format of this ﬁle. Using treemix.pat the RtreemixData object is created
as follows.

> ex.data <- new("RtreemixData", File = paste(path.package(package = "Rtreemix"), "/examples/treemix.pat", sep = ""))
> show(ex.data) ## show the RtreemixData object

One can also create an RtreemixData object by specifying the set of patient proﬁles as a
binary matrix as shown in the code below.

> bin.mat <- cbind(c(1, 0, 0, 1, 1), c(0, 1, 0, 0, 1), c(1, 1, 0, 1, 0))
> toy.data <- new("RtreemixData", Sample = bin.mat)
> show(toy.data)

Additionally, there are functions for listing the set of proﬁles, the genetic events, the patient
IDs, the number of events and the number of patients in the dataset.

> Sample(hiv.data)
> Events(hiv.data)
> Patients(hiv.data)
> eventsNum(hiv.data)
> sampleSize(hiv.data)

2.2 Learning mutagenetic trees mixture models

Having a set of patterns that indicate the occurence of genetic events for a group of patients
we can learn a mutagenetic trees mixture model. The model is an object of the Rtreemix-
Model class that extends the RtreemixData class. We ﬁt a 2-trees mixture model for the
HIV data [5].

> mod <- fit(data = hiv.data, K = 2, equal.edgeweights = TRUE, noise = TRUE)
> show(mod)

The tree components of the ﬁtted model can be visualized as follows. When the mixture
model contains a large number of tree components it is convenient to be able to plot a
speciﬁc tree component. The following code plots the second tree component of the mixture
model learned from the HIV dataset.

> plot(mod, k=2, fontSize = 14)

It is assumed that mixture models with at least two components always have the noise (star)
component as a ﬁrst component. When only one tree component is ﬁtted to the given data
it can be either a star or a nontrivial tree component based on the choice of the parameter
noise. The mixture components comprising the model are represented as a list of directed
graphNEL objects, and their weights (the mixture parameters) are given as a numeric vector.
There are functions for getting the mixture parameters of the model, the number of tree
components, the dataset used for estimating the model, etc.

$T1
[1] "A graph with 7 nodes."

$T2
[1] "A graph with 7 nodes."

Figure 2: The mutagenetic trees mixture model for the HIV dataset.

> Weights(mod)
> Trees(mod)
> getTree(object = mod, k = 2) ## Get a specific tree component k
> edgeData(getTree(object = mod, k = 2), attr = "weight") ## Conditional probabilities assigned to edges of the 2nd tree component
> numTrees(mod)
> getData(mod)

This class can also contain other useful information connected with the mixture model: an
indicator for the presence of the star component, a matrix of the responsibilities of each
tree component for each pattern of the data used for learning the model, a matrix of the
complete dataset in case of missing data, etc.

> Star(mod)
> Resp(mod)
> CompleteMat(mod)

The mutagenetic trees mixture model encodes a probability distribution on the set of all
possible patterns [1].

> distr <- distribution(model = mod)
> distr$probability

One can also generate a random mutagenetic mixture model. In this case each tree compo-
nent from the model is drawn uniformly at random from the tree topology space by using
the Pr¨ufer encoding of trees. The number of tree components and the number of genetic
events have to be speciﬁed. Additionally, one can specify the range from which the edge
weights of the tree components are randomly drawn ([0.2, 0.8] in the example bellow).

wild type41 L67 N70 R210 W215 F,Y219 E,Q0.40.40.40.40.40.4wild type41 L67 N70 R210 W215 F,Y219 E,Q0.40.30.30.40.70.8> rand.mod <- generate(K = 3, no.events = 9, noise.tree = TRUE, prob = c(0.2, 0.8))
> show(rand.mod)

It is also possible to ﬁt a mixture model and analyze its variance by deriving conﬁdence
intervals for the mixture parameters and the edge weights (resulting from a bootstrap anal-
ysis). An example for this is given in the PDF ﬁle ExtendedVignette in the doc folder of the
package.

2.3 The likelihood method

The package Rtreemix implements the function likelihoods which calculates the (log,
weighted) likelihoods for the patterns in a given dataset (RtreemixData object) derived
with respect to a given RtreemixModel. The likelihoods are contained in an object of class
RtreemixStats which extends the RtreemixData class. The number of the genetic events
in the patterns from the given dataset has to be equal to the number of genetic events in
the branchings from the given mixture model. In the code that follows we calculate the
likelihoods of the HIV dataset with respect to the ﬁtted mixture model.

> mod.stat <- likelihoods(model = mod, data = hiv.data)
> Model(mod.stat)
> getData(mod.stat)
> LogLikelihoods(mod.stat)
> WLikelihoods(mod.stat)

When having the weighted likelihoods, one can easily derive the responsibilities of the model
components for generating the patterns in the speciﬁed dataset.

> getResp(mod.stat)

2.4 The sim method

The mutagenetic trees mixture model encodes a probability distribution on the set of all
possible patterns for a speciﬁed set of genetic events. The sim method provides the possibil-
ity of simulating (drawing) patterns from a given RtreemixModel. The simulated patterns
are then returned as an RtreemixData object. Let’s draw a speciﬁed number of patterns
from our randomly generated model.

> data <- sim(model = rand.mod, no.draws = 300)
> show(data)

When besides the mixture model also the sampling mode and its respective sampling param-
eter are speciﬁed, this function simulates patterns together with their waiting and sampling
times from the respective model. The waiting and sampling times result from a waiting
time simulation along the branchings of the mixture model. The sim method presents the
results in an RtreemixSim object. An example illustrating this is given in the PDF ﬁle
ExtendedVignette.

2.5 The genetic progression score (GPS)

When assuming independent Poisson processes for the occurrence of events on the edges
of each mixture component and for the sampling time of the disease, waiting times can
be mapped on the tree edges of the branchings. Consequently, a genetic progression score
(GPS) that incorporates correlations among events and time intervals among occurrences
of events can be associated to the mixture model as proposed in [2]. The GPS estimates
the stage of the disease and is important for estimating survival times and giving patients
proper therapies. In the Rtreemix package the method gps calculates the GPS of a given
set of patterns with respect to a speciﬁed mixture model (an RtreemixModel object). The
GPS values are derived in a waiting time simulation for a given large number of simulation
iterations, and for a speciﬁed sampling mode (”constant” or ”exponential”) and its corre-
sponding sampling parameter. The result of the GPS calculation is given as an object of
the class RtreemixGPS which extends the class RtreemixData. Moreover, with the function
confIntGPS the package gives the possibility to analyze the variance of the GPS values.
This function ﬁrst calculates the GPS for the patterns in a given dataset based on a ﬁtted
K-mutagenetic trees mixture model. Then, it derives a 95% conﬁdence intervals for the GPS
values with bootstrap analysis. The data and the number of tree components K have to
be speciﬁed. The conﬁdence intervals reﬂect the variability of the estimated GPS values.
The results are again given as an RtreemixGPS object. The usage of the functions gps and
confIntGPS is demonstrated in the PDF ﬁle ExtendedVignette.

3 Stability analysis with the Rtreemix package

The Rtreemix package implements functions that can be used for assessing the quality
and analyzing the stability of diﬀerent attributes of the mutagenetic trees mixture model
(the probability distributions induced by the model, the number of tree components, the
topologies of the tree components, the GPS values and so on). This is usually done by
ﬁrst choosing a model attribute of interest and its appropriate similarity measure, and then
inspecting its stability in a simulation setting. In the simulation study typically attributes
from simulated true mixture models are compared with the corresponding attributes from
models ﬁtted to observations drawn from these true models. The similarity between the true
and the ﬁtted model is then compared to the similarities between the true and a suﬃcient
number of random models sampled uniformly from the mixture model space. The quality of
a ﬁtted attribute is then assessed by estimating a p-value as the percentage of cases in which
the true model is closer to a random model than to the ﬁtted model with respect to the
chosen model attribute. More details about performing stability analysis of the mutagenetic
tree mixture modes and interpreting the results can be found in [4]. Simple code examples
for the stability analysis of a mutagenetic trees mixture models are given in the doc folder
of the package in the PDF ﬁle ExtendedVignette.

References

[1] N Beerenwinkel, J Rahnenf¨uhrer, M D¨aumer, D Hoﬀmann, R Kaiser, J Selbig, and
T Lengauer. Learning multiple evolutionary pathways from cross-sectional data. Journal
of Computational Biology, 12(6):584–598, 2005.

[2] J Rahnenf¨uhrer, N Beerenwinkel, W A Schulz, C Hartmann, A V Deimling, B Wullich,
and T Lengauer. Estimating cancer survival and clinical outcome based on genetic tumor
progression scores. Bioinformatics, 21(10):2438–2446, 2005.

[3] N Beerenwinkel, J Rahnenf¨uhrer, R Kaiser, D Hoﬀmann, J Selbig, and T Lengauer.
Mtreemix: a software package for learning and using mixture models of mutagenetic
trees. Bioinformatics, 21(9):2106–2107, May 2005.

[4] J Bogojeska, J Rahnenf¨uhrer, and T Lengauer. Stability analysis of mixtures of muta-

genetic trees. BMC Bioinformatics, 9(1), 2008.

[5] S Rhee, M J Gonzales, R Kantor, B J Betts, J Ravela, and R W Shafer. Human
immunodeﬁciency virus reverse transcriptase and protease sequence database. Nucleic
Acids Res, 31(1):298–303, 2003.

