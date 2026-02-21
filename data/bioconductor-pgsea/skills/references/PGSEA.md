Parametric Gene Set Enrichement Analysis

Karl Dykema

April 24, 2017

Laboratory of Computational Biology, Van Andel Research Institute

1 PGSEA basics

PGSEA analyzes gene expression data to determine miss-regulation of deﬁned
gene signatures or ”molecular concepts”. To run PGSEA() all that you need is
a matrix of expression data and some lists of related genes. Your expression
data must either be in ratio form already or you must include reference samples
from which to generate ratios. The identiﬁers used in your gene lists must also
be in the same format as the gene names in your data matrix. All identiﬁers
in the example data and signatures included in this package are Entrez Gene
identiﬁers. The actual gene signatures themselves can come from a number of
diﬀerent sources but we have found the most informative ones to be experimen-
tally derived lists of genes. (As opposed to canonical pathways...) There are
many such lists that already exist in the literature as well as in publicly accessi-
ble repositories. To make use of these valuable resources, we have implemented a
class to hold these gene lists called ”smc”, for ”Simple Molecular Concepts.” The
class contains slots for holding many diﬀerent types of information about the
molecular concept, but all that is necessary is the ”ids” slot. This is where the
genes are stored. To begin we will show how to create your own basic concept:

>
>
>

library(PGSEA)
basic <- new("smc",ids=c("gene a","gene b"),reference="simple smc")
str(basic)

Formal class

’

’

smc

[package "PGSEA"] with 10 slots

..@ reference : chr "simple smc"
: chr(0)
..@ desc
: chr(0)
..@ source
..@ design
: chr(0)
..@ identifier: chr(0)
: chr(0)
..@ species
: chr(0)
..@ data
: chr(0)
..@ private
: chr(0)
..@ creator
: chr [1:2] "gene a" "gene b"
..@ ids

1

2 Concepts from ”.gmt” ﬁles

A previous published method of gene set analysis termed ”Gene Set Enrichment
Analysis” http://www.broad.mit.edu/gsea/ also used lists of related genes
and to hold their lists they use a ﬁle format called ”.gmt”. We have found it
to be a simple and useful way to store our lists as well. To facilitate using
this format in conjunction with our ”smc” class, we have included the functions
readGmt and writeGmt. An example of how to read in a ”.gmt” ﬁle is shown
below. The ﬁle provided contains some example molecular concepts. Genes
induced and inhibited by Ras and Myc, as well as all genes on chromosome
arms 5p and 5q have been included.

>
>
>

datadir <- system.file("extdata", package = "PGSEA")
sample <- readGmt(file.path(datadir, "sample.gmt"))
str(sample[1])

List of 1

$ ras UP - pmid: 16273092

NA :Formal class

’

’

smc

[package "PGSEA"] with 10 slots

.. ..@ reference : chr "ras UP - pmid: 16273092 "
: chr "NA "
.. ..@ desc
: chr(0)
.. ..@ source
: chr(0)
.. ..@ design
.. ..@ identifier: chr(0)
: chr(0)
.. ..@ species
: chr(0)
.. ..@ data
: chr(0)
.. ..@ private
: chr(0)
.. ..@ creator
: chr [1:181] "101" "154" "384" "490" ...
.. ..@ ids

Below some example gene expression data from primary neuroblastoma tu-
mors is analyzed by PGSEA using the provided example concepts. PGSEA is run
with an index given to the appropriate reference samples, and the data for the
[non-reference] samples is displayed with smcPlot.

>
>

>
>
>

data(nbEset)
pg <- PGSEA(nbEset,cl=sample,ref=1:5)

sub <- factor(c(rep(NA,5),rep("NeuroB",5),rep("NeuroB_MYC+",5)))
smcPlot(pg[,],sub,scale=c(-12,12),show.grid=T,margins=c(1,1,7,13),col=.rwb)

2

3 Using Gene Ontologies as concepts

Next, to create a list of concepts we will use the function go2smc. This function
will convert the entire GO datbase into ’smc’ objects. This is quite a large
number to work with, so we will just use a few of them for illustration.

>
>
>

>
>

mcs <- go2smc()[1:10]
pg <- PGSEA(nbEset,cl=mcs,ref=1:5)

smcPlot(pg[,],sub,scale=c(-12,12),show.grid=T,margins=c(1,1,7,20),col=.rwb)

3

NeuroBNeuroB_MYC+GS5q   NA 5p   NA myc DN − pmid: 16273092   NA myc UP − pmid: 16273092   NA ras DN − pmid: 16273092   NA ras UP − pmid: 16273092   NA 4 Concepts compiled at VAI

Lastly, we have included a list of concepts that we have manually compiled
from various sources. We have found these concepts to very informative in
our analysis. These concepts are included in the old ”smc” style object as was
used previously in PGSEA, and also in the newly created ”GeneSetCollection”
format. This new format allows much more ﬂexibility and should prove useful
as the format develops and matures.

#data(VAImcs)
data(VAIgsc)

pg <- PGSEA(nbEset,cl=VAIgsc,ref=1:5)

smcPlot(pg[,],sub,scale=c(-5,5),show.grid=T,margins=c(1,1,8,14),col=.rwb,r.cex=.7)

>
>
>
>

>
>

4

NeuroBNeuroB_MYC+GSGO:0000123 histone acetyltransferase complexGO:0000118 histone deacetylase complexGO:0000096 sulfur amino acid metabolic processGO:0000079 regulation of cyclin−dependent protein serine/threonine kinase activityGO:0000077 DNA damage checkpointGO:0000070 mitotic sister chromatid segregationGO:0000049 tRNA bindingGO:0000045 autophagosome assemblyGO:0000041 transition metal ion transportGO:0000018 regulation of DNA recombinationWe included this particular example dataset because the tumors were tested
for chromosomal aberrations which lead to ampliﬁcation of important genes.
The ampliﬁcation we are attempting to illustrate is that of MYC. We have
ﬁve samples that are conﬁrmed to have the ampliﬁcation and ﬁve samples that
have standard copy numbers. Our concept of interest is ”CMYC.1 up”, which
It was provided by Bild
is the second row from the top in the above plot.
et al. (PMID: 16273092). PGSEA reports four samples with conﬁrmed MYC
ampliﬁcation have a positive score, while only one of ﬁve samples without the
ampliﬁcation has a positive score. These results may not be overly impressive,
but in the interest of ﬁle size we could only include a portion of full the data
set. Originally there were 101 samples, 81 of which had the ampliﬁcation and 20
which did not. When PGSEA is run on the entire dataset, 18/20 (.90) of samples
with conﬁrmed ampliﬁcation have show increased activity, and only 5/81 (.06)
of samples conﬁrmed to have no ampliﬁcation also show increased activity.

These results are quite interesting and demonstrate the feasibility of using a
technique such as PGSEA to quickly analyze a wide variety of aspects about a
given data set. This type of analysis depends solely on informative concepts, so
that is where we believe the eﬀorts of the community should be directed.

5

NeuroBNeuroB_MYC+GSWND.1 DOWNWND.1 UPVEGF.1 downVEGF.1 upNFKB1.1 downNFKB1.1 upTNF.1 downTNF.1 upTNF.2 upTNF.2 downNFKB1.2 upNFKB1.2 downChromosomal InstabilityMET.3 upHYPOXIA.1 DOWNHYPOXIA.1 UP.smallHYPOXIA.1 UP.bigHYPEROXIA.2 DOWNHYPEROXIA.2 UPHYPEROXIA.1 DOWNHYPEROXIA.1 UPHGF.2 DOWNHGF.2 UPFH.1 DOWNFH.1 UPES.M.1 DOWNES.M.1 UPBRAF.1 downBRAF.1 upSRC.1 upSRC.1 downHRAS.1 upHRAS.1 downE2F3.1 upE2F3.1 downCMYC.1 upCMYC.1 down