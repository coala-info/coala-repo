restfulSE – experiments with HDF5 server
content wrapped in SummarizedExperiment

Vincent J. Carey, stvjc at channing.harvard.edu, Shweta
Gopaulakrishnan, reshg at channing.harvard.edu, Samuela
Pollack, spollack at jimmy.harvard.edu

January 04, 2019

Contents

1

2

restfulSE .

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

1.1

HDF5 server backed SummarizedExperiment .

Some details .

.

Motivation .

Executive summary .

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

10xGenomics examples .

Background .

.

.

.

.

.

.

2.1

2.2

2.3

2.4

2.5

Hierarchy of server resources .

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

2

2

5

5

5

7

9

10

restfulSE – experiments with HDF5 server content wrapped in SummarizedExperiment

1

restfulSE

This R package includes proof-of-concept code illustrating several approaches to Summarized-
Experiment design with assays stored out-of-memory.

1.1

HDF5 server backed SummarizedExperiment

HDF Server “extends the HDF5 data model to eﬃciently store large data objects (e.g. up to
multi-TB data arrays) and access them over the web using a RESTful API.” In this restfulSE
package, several data structures are introduced

• to model the server data architecture and
• to perform targeted extraction of numerical data from HDF5 arrays stored on the server.

We work with HDF Object store (https://www.hdfgroup.org/solutions/hdf-cloud/).

1.1.1

Illustration with 10x genomics 1.3 million neurons

We used Martin Morgan’s TENxGenomics package to transform the sparse-formatted HDF5
supplied by 10x into a dense HDF5 matrix to support natural slicing. Thanks to native
compression in HDF5, the data volume expansion is modest.

A helper function in the restfulSE package creates a RESTfulSummarizedExperiment instance
that points to the full numerical dataset.

library(restfulSE)

my10x = se1.3M()

## snapshotDate(): 2018-10-30

## see ?restfulSEData and browseVignettes('restfulSEData') for documentation

## downloading 0 resources

## loading from cache

##

'/home/biocbuild//.ExperimentHub/1656'

my10x

## class: SummarizedExperiment

## dim: 27998 1306127

## metadata(0):

## assays(1): counts

## rownames(27998): ENSMUSG00000051951 ENSMUSG00000089699 ...

##

ENSMUSG00000096730 ENSMUSG00000095742

## rowData names(12): ensid seqnames ... symbol entrezid

## colnames(1306127): AAACCTGAGATAGGAG-1 AAACCTGAGCGGCTTC-1 ...

##

TTTGTCAGTTAAAGTG-133 TTTGTCATCTGAAAGA-133

## colData names(4): Barcode Sequence Library Mouse

As an exercise, we acquire the ENSEMBL identiﬁers for mouse genes annotated to hippocampus
development, which has GO ID GO:0021766, and check counts for 10 genes on 6 samples:

library(org.Mm.eg.db)

##

hippdev = select(org.Mm.eg.db,

keys="GO:0021766", keytype="GO", column="ENSEMBL")$ENSEMBL

2

restfulSE – experiments with HDF5 server content wrapped in SummarizedExperiment

## 'select()' returned 1:many mapping between keys and columns

hippdev = intersect(hippdev, rownames(my10x))

unname(assay(my10x[ hippdev[1:10], 10001:10006]))

## <10 x 6> DelayedMatrix object of type "double":

[,1] [,2] [,3] [,4] [,5] [,6]

0

0

0

0

0

1

0

0

0

3

0

0

0

1

0

2

0

0

0

0

0

0

0

2

0

4

0

0

0

3

0

0

1

6

0

8

0

0

0

0

0

0

0

5

0

7

0

0

0

1

0

0

0

0

0

3

0

2

0

9

##

##

##

##

##

##

##

##

##

##

[1,]

[2,]

[3,]

[4,]

[5,]

[6,]

[7,]

[8,]

[9,]

## [10,]

The result:

[,1] [,2] [,3] [,4] [,5] [,6]

[1,]

[2,]

[3,]

[4,]

[5,]

[6,]

[7,]

[8,]

[9,]

[10,]

0

0

0

0

0

1

0

0

0

3

0

0

0

1

0

2

0

0

0

0

0

0

0

2

0

4

0

0

0

3

0

0

1

6

0

8

0

0

0

0

0

0

0

5

0

7

0

0

0

1

0

0

0

0

0

3

0

2

0

9

1.1.2

Illustration with GTEx tissue expression

We exported the content of the recount2 GTEx gene-level quantiﬁcations to our HDF5 server.
A convenience function is available:

tiss = gtexTiss()

## snapshotDate(): 2018-10-30

## see ?restfulSEData and browseVignettes('restfulSEData') for documentation

## downloading 0 resources

## loading from cache

'/home/biocbuild//.ExperimentHub/556'

##

tiss

## class: RangedSummarizedExperiment

## dim: 58037 9662

## metadata(0):

## assays(1): recount

## rownames(58037): ENSG00000000003.14 ENSG00000000005.5 ...

##
ENSG00000283698.1 ENSG00000283699.1
## rowData names(3): gene_id bp_length symbol
## colnames(9662): SRR660824 SRR2166176 ... SRR612239 SRR615898

3

restfulSE – experiments with HDF5 server content wrapped in SummarizedExperiment

## colData names(82): project sample ... title characteristics

We’ll use this remote data as a tool for investigating transcriptional patterns in brain anatomy.
We can identify the samples from brain using the ‘smtsd’ colData element:

binds = grep("Brain", tiss$smtsd)

table(tiss$smtsd[binds][1:100]) # check diversity in 100 samples

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

Brain - Amygdala

4

Brain - Anterior cingulate cortex (BA24)

Brain - Caudate (basal ganglia)

Brain - Cerebellar Hemisphere

10

5

9

Brain - Cerebellum

13

Brain - Cortex

13

Brain - Frontal Cortex (BA9)

Brain - Hippocampus

10

8

Brain - Hypothalamus

5

## Brain - Nucleus accumbens (basal ganglia)

##

##

##

##

##

##

##

Brain - Putamen (basal ganglia)

4

Brain - Spinal cord (cervical c-1)

7

Brain - Substantia nigra

3

9

We’ll identify genes annotated to neurotrophic functions using another convenience function
in this package:

ntgenes = goPatt(termPattern="neurotroph")

## 'select()' returned 1:1 mapping between keys and columns

## 'select()' returned 1:many mapping between keys and columns

head(ntgenes)

##

GO EVIDENCE ONTOLOGY

ENSEMBL SYMBOL

## 1 GO:0004897

## 2 GO:0004897

## 3 GO:0004897

## 4 GO:0004897

## 5 GO:0004897

## 6 GO:0004897

IBA

IDA

IMP

IDA

IDA

IBA

MF ENSG00000122756

CNTFR

MF ENSG00000122756

CNTFR

MF ENSG00000160712

IL6R

MF ENSG00000134352

IL6ST

MF ENSG00000113594

MF ENSG00000105246

LIFR

EBI3

4

restfulSE – experiments with HDF5 server content wrapped in SummarizedExperiment

2

Some details

2.1 Motivation

Extensive human and computational eﬀort is expended on downloading and managing large
genomic data at site of analysis. Interoperable formats that are accessible via generic operations
like those in RESTful APIs may help to improve cost-eﬀectiveness of genome-scale analyses.

In this report we examine the use of HDF5 server as a back end for assay data, mediated
through the RangedSummarizedExperiment API for interactive use.

A modest server conﬁgured to deliver HDF5 content via a RESTful API has been prepared
and is used in this vignette.

2.2

Executive summary

We want to provide rapid access to array-like data. We’ll work with the Banovich 450k data
as there is a simple check against an in-memory representation.

library(restfulSE)
hsds = H5S_source(URL_hsds())
hsds

##

##

##

##

HSDS server url : http://hsdshdflab.hdfgroup.org

Use getReq() to get information on the server.

Use setPath() to specify path to a hdf5 file.

Use fetchDatasets() to get id of the dataset of interest.

To grab a dataset of interest from the HSDS server

hsdsCon = setPath(hsds,"/home/reshg/bano_meQTLex.h5")
fetchDatasets(hsdsCon) #grab the dataset id of interest

class

##
title
## 1 H5L_TYPE_HARD d-435d7ad4-9f13-11e8-92c2-0242ac120021 1534176573 assay001
##

collection

created

id

## 1

datasets

##
target
## 1 hsdshdflab.hdfgroup.org/datasets/d-435d7ad4-9f13-11e8-92c2-0242ac120021?domain=/home/reshg/bano_meQTLex.h5
##
## 1 hsdshdflab.hdfgroup.org/groups/g-43094888-9f13-11e8-8878-0242ac120020/links/assay001?domain=/home/reshg/bano_meQTLex.h5
##
domain
## 1 /home/reshg/bano_meQTLex.h5
banoh5 = H5S_dataset2(hsdsCon,"d-435d7ad4-9f13-11e8-92c2-0242ac120021")

href

We build a SummarizedExperiment by combining an assay-free RangedSummarizedExperiment
with this reference.

ehub = ExperimentHub::ExperimentHub()

## snapshotDate(): 2018-10-30

tag = names(AnnotationHub::query(ehub, "banoSEMeta"))

banoSE = ehub[[tag[1]]]

## see ?restfulSEData and browseVignettes('restfulSEData') for documentation

5

restfulSE – experiments with HDF5 server content wrapped in SummarizedExperiment

## downloading 0 resources

## loading from cache

'/home/biocbuild//.ExperimentHub/551'

##
ds = H5S_Array(URL_hsds(), "/home/reshg/bano_meQTLex.h5", "assay001")
assays(banoSE) = SimpleList(betas=ds)

banoSE

## class: RangedSummarizedExperiment

## dim: 329469 64

## metadata(0):

## assays(1): betas

## rownames(329469): cg00000029 cg00000165 ... ch.9.98989607R

##

ch.9.991104F

## rowData names(10): addressA addressB ... probeEnd probeTarget

## colnames(64): NA18498 NA18499 ... NA18489 NA18909
## colData names(35): title geo_accession ... data_row_count naid

We can update the SummarizedExperiment metadata through subsetting operations, and then
extract the relevant assay data. The data are retrieved from the remote server with the assay
method.

rbanoSub = banoSE[5:8, c(3:9, 40:50)]

## Loading required package: Biostrings

## Loading required package: XVector

##

## Attaching package: 'Biostrings'

## The following object is masked from 'package:DelayedArray':

##

##

type

## The following object is masked from 'package:base':

##

##

strsplit

assay(rbanoSub)

## <4 x 18> DelayedMatrix object of type "double":

##

NA18501

NA18502

NA18516 ...

NA19138

## cg00000363 0.325433263 1.377820005

0.596699897

## cg00000622 0.003436888 -0.668499289 -1.210634762

## cg00000714 -1.184443665 -1.654047967 -0.174729357

## cg00000734 0.153831565 -1.299289359

1.903976827

.

.

.

.

0.966695669

0.076062477

0.325742947

1.185320424

##

NA19140

## cg00000363 1.203765271

## cg00000622 0.958031578

## cg00000714 -0.008202908

## cg00000734 0.319937329

6

restfulSE – experiments with HDF5 server content wrapped in SummarizedExperiment

2.3

10xGenomics examples

2.3.1

t-SNE for a set of genes annotated to hippocampus

We have used Martin Morgan’s TENxGenomics package to create a dense HDF5 representation
of the assay data, and placed it on the bigec2 server. The metadata are available as se100k
in this package; we have used EnsDb.Mmusculus.v79 to supply gene ranges where available;
genes reported but without addresses are addressed at chr1:2 with width 0. The rows are
sorted by genomic address within chromosomes.

tenx100k = se100k()

## snapshotDate(): 2018-10-30

## see ?restfulSEData and browseVignettes('restfulSEData') for documentation

## downloading 0 resources

## loading from cache

##

'/home/biocbuild//.ExperimentHub/552'

tenx100k

## class: RangedSummarizedExperiment

## dim: 27998 100000

## metadata(1): source

## assays(1): counts

## rownames(27998): ENSMUSG00000109048 ENSMUSG00000109510 ...

ENSMUSG00000096768 ENSMUSG00000096850

##
## rowData names(6): gene_id gene_name ... seq_coord_system symbol
## colnames(100000): AAACCTGAGATAGGAG-1 AAACCTGAGCGGCTTC-1 ...

##

GACGTTAGTCATACTG-11 GACGTTAGTCCGTGAC-11

## colData names(4): Barcode Sequence Library Mouse

We will subset genes annotated to hippocampus development. Here are some related categories:

12092 GO:0021766

12096 GO:0021770

hippocampus development

parahippocampal gyrus development

34609 GO:0097410

hippocampal interneuron differentiation

34631 GO:0097432 hippocampal pyramidal neuron differentiation

34656 GO:0097457

hippocampal mossy fiber

35169 GO:0098686

hippocampal mossy fiber to CA3 synapse

42398 GO:1990026

hippocampal mossy fiber expansion

library(org.Mm.eg.db)

atab = select(org.Mm.eg.db, keys="GO:0021766", keytype="GO", columns="ENSEMBL")

## 'select()' returned 1:many mapping between keys and columns

hg = atab[,"ENSEMBL"]

length(hgok <- intersect(hg, rownames(tenx100k)))

## [1] 59

This is a very scattered collection of rows in the matrix. We acquire expression measures
for genes annotated to hippocampus on 4000 samples. t-SNE is then used to project the
log-transformed measures to the plane.

hipn = assay(tenx100k[hgok,1:4000])

# slow

d = dist(t(log(1+hipn)), method="manhattan")

proj = Rtsne(d)

7

restfulSE – experiments with HDF5 server content wrapped in SummarizedExperiment

plot(proj$Y)

2.3.2 A set of genes related to the visual cortex

Tasic et al. (Nature neuro 2016, DOI 10.1038/nn.4216) describe single cell analysis of
the adult murine brain, identify clusters of cells with distinct transcriptional proﬁles and
anatomic location, and enumerate lists of genes that discriminate these clusters. The tasicST6
DataFrame provides details.

#data("tasicST6", package = "restfulSEData")

ehub = ExperimentHub::ExperimentHub()

## snapshotDate(): 2018-10-30

tag = names(AnnotationHub::query(ehub, "tasicST6"))

tasicST6 = ehub[[tag[1]]]

## see ?restfulSEData and browseVignettes('restfulSEData') for documentation

## downloading 0 resources

## loading from cache

##

'/home/biocbuild//.ExperimentHub/557'

tasicST6

## DataFrame with 49 rows and 4 columns

clid

txtype1

txtype2

<character> <character>

<character>

f01

f02

f03

f04

f05

...

f45

f46

f47

f48

f49

Vip

Vip

Vip

Vip

Vip

...

Mybpc1

Parm1

Sncg

Chat

Gpc3

...

Oligo 9630013A20Rik

Oligo

Micro

Endo

SMC

Opalin

Ctss

Xdh

Myl9

##

##

## 1

## 2

## 3

## 4

## 5

## ...

## 45

## 46

## 47

## 48

## 49

##

8

genes

−8−6−4−2024−2−1012proj$Y[,1]proj$Y[,2]restfulSE – experiments with HDF5 server content wrapped in SummarizedExperiment

##

## 1

## 2

## 3

## 4

## 5

## ...

## 45

## 46

## 47

## 48

c("Brca1", "Rnf122", "Mbp", "Zcchc12", "Enpp6", "Kif19a", "Enpp6", "Dct", "Tmeff2", "Gpr17", "1700040N02Rik", "1810041L15Rik", "St18", "Vcan", "Bcan", "9530059O14Rik", "Cldn11", "1700047M11Rik")

c("Mbp", "Mog", "Aspa", "Mobp", "Gpr37", "Ppp1r14a", "Gjb1", "Tmeff2", "St18", "Cldn11", "1700047M11Rik", "Kctd13", "Cntn2", "Eml1", " A530088E08Rik")

c("Cx3cr1", "C1qb", "Cd53", "Csf1r", "Itgam", "Abi3", "C1qa", "Aif1", "Trem2", "P2ry13", "Tmem119", "C1qc", "Cd14", "Fcgr3", "Gpr34", "Inpp5d", "Nckap1l", "Mpeg1", "Siglech", "Susd3", "Hk2", "Ly86", "Sparc", "Fli1")

c("Tbc1d4", "AI467606", "Exosc7", "Eltd1", "Fas", "Hmgcs2", "Nostrin", "Paqr5", "Slc16a4", "Id1", "Ptprb", "Cd93", "Sparc", "Fli1", "Ly6a", "Ly6c1", "Ly6c2", "Flt1", "Pglyrp1", "Slco1a4", "Ifitm3", "Abcb1a", "Ahnak")

c("Reln", "Npy2r", "Tnfaip8l3", "Cadps2", "2310042E22Rik", "Egln3", "Tpd52l1", "Megf10")

c("Aebp1", "Slc18a3", "Pvrl4", "Nrp1", "Sema5b", "Pcdh15", "Phlda1")

c("Bcar3", "Mab21l1", "Pbx3", "Nrp1", "Crh")

c("Crispld2", "Cxcl14", "Tpm2", "Itih5", "Cox6a2")

c("Cxcl14", "Car4", "Tac2")

<List>

...

## 49 c("Bgn", "Nupr1", "Casq2", "Mylk", "Gprc5c", "Slc38a11", "Slc6a20a", "Pcolce", "Vtn", "Cnn2", "Nid1", "Gpr30", "Higd1b", "Ifitm1", "P2ry14", "Serping1", "Sparc", "Fli1", "Cald1", " Abcb1a", "Flt1", "Ly6a", "Ly6c1", "Ly6c2", "Pglyrp1", "Slco1a4", "Ahnak")

Key high-level discrimination concerns cells regarded as GABAergic vs. glutamatergic (inhibitory
vs excitatory neurotransmission).

2.4

Background

Banovich et al. published a subset of DNA methylation measures assembled on 64 samples of
immortalized B-cells from the YRI HapMap cohort.

library(restfulSE)

#data("banoSEMeta", package = "restfulSEData")

ehub = ExperimentHub::ExperimentHub()

## snapshotDate(): 2018-10-30

tag = names(AnnotationHub::query(ehub, "banoSEMeta"))

banoSEMeta = ehub[[tag[1]]]

## see ?restfulSEData and browseVignettes('restfulSEData') for documentation

## downloading 0 resources

## loading from cache

##

'/home/biocbuild//.ExperimentHub/551'

banoSEMeta

## class: RangedSummarizedExperiment

## dim: 329469 64

## metadata(0):

## assays(0):

## rownames(329469): cg00000029 cg00000165 ... ch.9.98989607R

##

ch.9.991104F

## rowData names(10): addressA addressB ... probeEnd probeTarget

## colnames(64): NA18498 NA18499 ... NA18489 NA18909
## colData names(35): title geo_accession ... data_row_count naid

The numerical data have been exported using H. Pages’ saveHDF5SummarizedExperiment
applied to the banovichSE SummarizedExperiment in the yriMulti package. The HDF5
component is simply copied into the server data space on the remote server.

9

restfulSE – experiments with HDF5 server content wrapped in SummarizedExperiment

2.5

Hierarchy of server resources

2.5.1 Server

Given the URL of a server running HSDS server, we create an instance of H5S_source:

mys = H5S_source(serverURL=URL_hsds())
mys

##

##

##

##

HSDS server url : http://hsdshdflab.hdfgroup.org

Use getReq() to get information on the server.

Use setPath() to specify path to a hdf5 file.

Use fetchDatasets() to get id of the dataset of interest.

10

