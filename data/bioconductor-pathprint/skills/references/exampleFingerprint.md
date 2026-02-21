Pathway Fingerprinting: a working example

Gabriel Altschuler

October 30, 2017

This document demonstrates how to use the pathprint package to analyze
a dataset using Pathway Fingerprints. The pathprint package takes gene ex-
pression data and processes this into discrete expression scores (+1,0,-1) for a
set of 633 pathways. For more information, see the pathprint website.

Contents

1 Summary

2 Background

3 Method

4 Pathway sources

5 Initial data processing

6 Pathway ﬁngerprinting

6.1 Fingerprinting from new expression data . . . . . . . . . . . . . .
6.2 Using existing data . . . . . . . . . . . . . . . . . . . . . . . . . .

7 Fingerprint Analysis

Intra-sample comparisons

7.1
. . . . . . . . . . . . . . . . . . . . . .
7.2 Using consensusFingerprint and ﬁngerprinDistance, comparison
to pluripotent arrays . . . . . . . . . . . . . . . . . . . . . . . . .
. . . . . . . . . . . . . . . . . . . . . .
Identifying similar arrays

7.3

1

2

2

2

3

3
3
4

5
5

5
7

1 Summary

Systems-level descriptions of pathway activity across gene expression reposito-
ries are confounded by platform, species and batch eﬀects. Pathprinting inte-
grates pathway curation, proﬁling methods, and public repositories, to represent
any expression proﬁle as a ternary score (-1, 0, +1) in a standardized pathway
panel. It provides annotation and a robust framework for global comparison of
gene expression data.

1

2 Background

New strategies to combat complex human disease require systems approaches
to biology that integrate experiments from cell lines, primary tissues and model
organisms. We have developed Pathprint, a functional approach that compares
gene expression proﬁles in a set of pathways, networks and transcriptionally
regulated targets. It can be applied universally to gene expression proﬁles across
species. Integration of large-scale proﬁling methods and curation of the public
repository overcomes platform, species and batch eﬀects to yield a standard
measure of functional distance between experiments. A score of 0 in the ﬁnal
pathprint vector represents pathway expression at a similar level to the majority
of arrays of the same platform in the GEO database, while scores of 1 and -1
reﬂect signiﬁcantly high and low expression respectively.

3 Method

Below we describe the individual steps used to construct the pathway ﬁngerprint.

Rank-normalized gene expression is mapped to pathway expression. A distribu-
tion of expression scores across the Gene Expression Omnibus (GEO is used to
produce a probability of expression (POE) for each pathway. A pathprint vec-
tor is derived by transformation of the signed POE distribution into a ternary
score, representing pathway activity as signiﬁcantly underexpressed (-1), inter-
mediately expressed (0), or overexpressed (+1).

4 Pathway sources

Canonical pathway gene sets were compiled from Reactome, Wikipathways, and
KEGG (Kyoto Encyclopedia of Genes and Genomes), which were chosen because
they include pathways relating to metabolism, signaling, cellular processes, and
disease. For the major signaling pathways, experimentally derived transcrip-
tionally upregulated and downregulated gene sets were obtained from Netpath.
We have supplemented the curated pathways with non-curated sources of in-
teractions by including highly connected modules from a functional-interaction
network, termed ’static modules.’ The modules cover 6,458 genes, 1,542 of which

2

are not represented in any of the pathway databases. These static modules oﬀer
the opportunity to examine the activity of less studied or annotated biological
processes, and also to compare their activity with that of the canonical path-
ways.

Pathprinting: An integrative approach to understand the functional basis
of disease Gabriel M Altschuler, Oliver Hofmann, Irina Kalatskaya, Rebecca
Payne, Shannan J Ho Sui, Uma Saxena, Andrei V Krivtsov, Scott A Armstrong,
Tianxi Cai, Lincoln Stein and Winston A Hide Genome Medicine (2013) 5:68
DOI: 10.1186/gm472

5

Initial data processing

An existing GEO sample on the Human Aﬀy ST 1.0 chip will be used as en
example. The dataset GSE26946 proﬁles expression data from iPS and human
ES cells. The R package GEOquery can be used to retrieve the data. An ’exprs’
object, i.e. a dataframe with row names corresponding to probe or feature IDs
and column names corresponding to sample IDs is required by pathprint. In
addition, we need to know the GEO reference for the platform, in this case
GPL6244, and the species, which is ’human’ or ”Homo sapiens’ (both styles of
name work).

> library(GEOquery)
> GSE26946 <- getGEO("GSE26946")
> GSE26946.exprs <- exprs(GSE26946[[1]])
> GSE26946.exprs[1:5, 1:3]

GSM663450 GSM663451 GSM663452
7892501 8.904383 9.328561 8.760057
7892502 7.217361 9.118137 6.242542
7892503 6.091620 5.620844 5.726464
7892504 11.072690 10.883280 10.714790
7892505 5.777377 4.814570 4.463360

> GSE26946.platform <- annotation(GSE26946[[1]])
> GSE26946.species <- as.character(unique(phenoData(GSE26946[[1]])$organism_ch1))
> GSE26946.names <- as.character(phenoData(GSE26946[[1]])$title)

6 Pathway ﬁngerprinting

6.1 Fingerprinting from new expression data

Now the data has been prepared, the pathprint function exprs2fingerprint
can be used to produce a pathway ﬁngerprint from this expression table.

> library(pathprint)
> library(SummarizedExperiment)
> library(pathprintGEOData)
> # load the data

3

> data(compressed_result)
> # load("chipframe.rda")
> ds = c("chipframe", "genesets","pathprint.Hs.gs","platform.thresholds", "pluripotents.frame")
> data(list = ds)
> # extract GEO.fingerprint.matrix and GEO.metadata.matrix
> GEO.fingerprint.matrix = assays(result)$fingerprint
> GEO.metadata.matrix = colData(result)
> GSE26946.fingerprint <- exprs2fingerprint(exprs = GSE26946.exprs,

platform = GSE26946.platform,
species = GSE26946.species,
progressBar = FALSE
)

[1] "Running fingerprint"

> GSE26946.fingerprint[1:5, 1:3]

Glycolysis / Gluconeogenesis (KEGG)
Citrate cycle (TCA cycle) (KEGG)
Pentose phosphate pathway (KEGG)
Pentose and glucuronate interconversions (KEGG)
Fructose and mannose metabolism (KEGG)

Glycolysis / Gluconeogenesis (KEGG)
Citrate cycle (TCA cycle) (KEGG)
Pentose phosphate pathway (KEGG)
Pentose and glucuronate interconversions (KEGG)
Fructose and mannose metabolism (KEGG)

Glycolysis / Gluconeogenesis (KEGG)
Citrate cycle (TCA cycle) (KEGG)
Pentose phosphate pathway (KEGG)
Pentose and glucuronate interconversions (KEGG)
Fructose and mannose metabolism (KEGG)

GSM663450
1
1
1
1
1
GSM663451
1
1
1
1
1
GSM663452
1
1
1
1
1

6.2 Using existing data

The pathprint package uses the object compressed_result, drawn from the
data-package pathprintGEOData, which was constructed in 2012 and does not
contain all the GEO data. When uncompressed yields GEO.fingerprint.matrix
and GEO.metadata.matrix. GEO.fingerprint.matrix contains 188390 sam-
ples that have already been ﬁngerprinted, along with their associated metadata,
in the object GEO.metadata.matrix. As the above data record is publically
available from GEO it is actually already in the matrix and we can compare
this to the ﬁngerprint processed above.
It should be noted that occasionally
there may be discrepancies in one or two pathways due to the way in which the
threshold is applied.

> colnames(GSE26946.exprs) %in% colnames(GEO.fingerprint.matrix)

4

[1] TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE

> GSE26946.existing <- GEO.fingerprint.matrix[,colnames(GSE26946.exprs)]
> all.equal(GSE26946.existing, GSE26946.fingerprint)

[1] TRUE

7 Fingerprint Analysis

7.1 Intra-sample comparisons

The ﬁngerprint vectors can be used to compare the diﬀerntially expressed func-
tions within the sample set. The most straight forward method to represent this
is using a heatmap, removing rows for which there is no change in functional
expression.

> heatmap(GSE26946.fingerprint[apply(GSE26946.fingerprint, 1, sd) > 0, ],

labCol = GSE26946.names,
mar = c(10,10),
col = c("blue", "white", "red"))

7.2 Using consensusFingerprint and ﬁngerprinDistance, com-

parison to pluripotent arrays

We can also investigate how far in functional distance, these arrays are from
other pluripotent ﬁngerprints. This can be achieved using the set of pluripo-
tent arrays included in the package, from which a consensus ﬁngerprint can be
created.

> # construct pluripotent consensus
> pluripotent.consensus<-consensusFingerprint(

GEO.fingerprint.matrix[,pluripotents.frame$GSM], threshold=0.9)
> # calculate distance from the pluripotent consensus for all arrays
> geo.pluripotentDistance<-consensusDistance(

pluripotent.consensus, GEO.fingerprint.matrix)

[1] "Scaling against max length, 180"

> # calculate distance from pluripotent consensus for GSE26946 arrays
> GSE26946.pluripotentDistance<-consensusDistance(
pluripotent.consensus, GSE26946.fingerprint)

[1] "Scaling against max length, 180"

>

> par(mfcol = c(2,1), mar = c(0, 4, 4, 2))
> geo.pluripotentDistance.hist<-hist(geo.pluripotentDistance[,"distance"],

nclass = 50, xlim = c(0,1), main = "Distance from pluripotent consensus")

> par(mar = c(7, 4, 4, 2))

5

Figure 1: Heatmap of GSE26946 pathway ﬁngerprints, blue = -1, white = 0,
red = +1

6

H1_p47_rep1FLiPSC_p12_rep1FLiPSC_p23_rep1iPSC_p19_rep1iPSA_p24_rep1iPSB_p23_rep1iPSC_KM_rep1iPSB_KM_rep1H1_KM_rep1iPSA_KM_rep1Porphyrin and chlorophyll metabolism (KEGG)Alzheimer's disease (KEGG)Vibrio cholerae infection (KEGG)Retinol metabolism (KEGG)Metabolism of porphyrins (Reactome)Nicotine metabolism (Wikipathways)Maturity onset diabetes of the young (KEGG){CREB1,40} (Static Module)Energy Metabolism (Wikipathways)IL−6 Signaling Pathway (Wikipathways)Serotonin Receptor 4/6/7 and NR3C Signaling (Wikipathways){GAPDH,13} (Static Module){ATP5D,19} (Static Module)Sphingolipid metabolism (KEGG){RB1,11} (Static Module)Glycosaminoglycan biosynthesis − chondroitin sulfate (KEGG)cytochrome P450 (Wikipathways)Kit Receptor up reg. targets (Netpath)Caffeine metabolism (KEGG)Nucleotide GPCRs (Wikipathways)Glycosylphosphatidylinositol(GPI)−anchor biosynthesis (KEGG)Dorso−ventral axis formation (KEGG)N−Glycan biosynthesis (KEGG){MMP9,11} (Static Module)Blood Clotting Cascade (Wikipathways)Inositol phosphate metabolism (KEGG){PRKACA,33} (Static Module)Systemic lupus erythematosus (KEGG)TNF−alpha/NF−kB Signaling Pathway (Wikipathways){CBX4,10} (Static Module)MAPK Cascade (Wikipathways)MicroRNAs in cardiomyocyte hypertrophy (Wikipathways)NLR proteins (Wikipathways){MAPK14,123} (Static Module){CD4,14} (Static Module)Transmembrane transport of small molecules (Reactome)Nicotinate and nicotinamide metabolism (KEGG)Osteoclast Signaling (Wikipathways)Physiological and Pathological Hypertrophy  of the Heart (Wikipathways)DNA damage response (only ATM dependent) (Wikipathways){NFKB1,33} (Static Module)Protein processing in endoplasmic reticulum (KEGG)Complement Activation, Classical Pathway (Wikipathways)Metabolism of xenobiotics by cytochrome P450 (KEGG)Benzo(a)pyrene metabolism (Wikipathways){ACY1,11} (Static Module)TNF alpha/NF−kB up reg. targets (Netpath)IL−1 up reg. targets (Netpath)Vascular smooth muscle contraction (KEGG)Amoebiasis (KEGG)p38 MAPK Signaling Pathway (Wikipathways)Glycosphingolipid biosynthesis − globo series (KEGG)Antigen processing and presentation (KEGG)Serotonin Receptor 2 and ELK−SRF/GATA4 signaling (Wikipathways)Monoamine GPCRs (Wikipathways){SDC1,30} (Static Module){VAMP2,63} (Static Module)Circadian rhythm − mammal (KEGG){ESR1,24} (Static Module)Tryptophan metabolism (Wikipathways)Fat digestion and absorption (KEGG)Oxidative phosphorylation (KEGG)Glutathione metabolism (Wikipathways)Electron Transport Chain (Wikipathways)Oxidative phosphorylation (Wikipathways)Arachidonate Epoxygenase / Epoxide Hydrolase (Wikipathways)Serotonin HTR1 Group and FOS Pathway (Wikipathways)TCA Cycle (Wikipathways)Respiratory electron transport, ATP synthesis by chemiosmotic coupling, and heat production by uncoupling proteins. (Reactome)Pyruvate metabolism and Citric Acid (TCA) cycle (Reactome)Histidine metabolism (KEGG)beta−Alanine metabolism (KEGG)Parkinson's disease (KEGG)Heme Biosynthesis (Wikipathways)Opioid Signalling (Reactome)Signalling by NGF (Reactome){POR,15} (Static Module)Tyrosine metabolism (KEGG)Phototransduction (KEGG)TOR signaling (Wikipathways)Hypothetical Network for Drug Addiction (Wikipathways)Vitamin A and carotenoid metabolism (Wikipathways)B Cell Receptor down reg. targets (Netpath){CYCS,35} (Static Module){NDUFS8,49} (Static Module)Proteasome (KEGG)Proteasome Degradation (Wikipathways)Diurnally regulated genes with circadian orthologs (Wikipathways){SP1,88} (Static Module)IL−5 down reg. targets (Netpath)Regulation of autophagy (KEGG)Phenylalanine metabolism (KEGG)Galactose metabolism (KEGG)Riboflavin metabolism (KEGG)Ether lipid metabolism (KEGG){AP1G1,16} (Static Module){POU2F1,21} (Static Module)Amino sugar and nucleotide sugar metabolism (KEGG)Glycerolipid metabolism (KEGG)Insulin Signaling (Wikipathways)Steroid Biosynthesis (Wikipathways)Botulinum neurotoxicity (Reactome){PRKG1,21} (Static Module)Bile secretion (KEGG)AMPK signaling (Wikipathways)Fatty Acid Biosynthesis (Wikipathways)Starch and sucrose metabolism (KEGG){SREBF1,11} (Static Module)mTOR signaling pathway (KEGG){BCL2,27} (Static Module)EPO Receptor Signaling (Wikipathways)Mineral absorption (KEGG)Epithelial cell signaling in Helicobacter pylori infection (KEGG)Shigellosis (KEGG)Osteopontin Signaling (Wikipathways)Keap1−Nrf2 Pathway (Wikipathways)Vasopressin−regulated water reabsorption (KEGG)Metabolism of nitric oxide (Reactome)T Cell Receptor up reg. targets (Netpath)Androgen Receptor Signaling Pathway (Wikipathways){MEIS1,22} (Static Module){SMAD4,27} (Static Module)Th1/Th2 (Wikipathways)Ovarian Infertility Genes (Wikipathways)Prostaglandin Synthesis and Regulation (Wikipathways)Glioma (KEGG)Signaling by TGF beta (Reactome)Delta−Notch Signaling Pathway (Wikipathways){SEPT2,21} (Static Module)TGF Beta Signaling Pathway (Wikipathways)Small cell lung cancer (KEGG)MAPK signaling pathway (KEGG)Signaling of Hepatocyte Growth Factor Receptor (Wikipathways)TNF alpha/NF−kB down reg. targets (Netpath)ID up reg. targets (Netpath)Hemostasis (Reactome)Integrin−mediated cell adhesion (Wikipathways)Notch down reg. targets (Netpath){CNGB1,17} (Static Module){SEC24B,18} (Static Module){STX5,12} (Static Module)Integrin cell surface interactions (Reactome){GNAT3,28} (Static Module)Inflammatory Response Pathway (Wikipathways){PLG,10} (Static Module)IL−6 down reg. targets (Netpath){TGFBR1,98} (Static Module)Hedgehog signaling pathway (KEGG){TCF3,20} (Static Module)Axon guidance (KEGG){CHRNA1,13} (Static Module)Other types of O−glycan biosynthesis (KEGG){OTX2,18} (Static Module){FYN,30} (Static Module){NOTCH1,44} (Static Module)Signaling by Notch (Reactome)Signaling by EGFR (Reactome)Notch Signaling Pathway (Wikipathways)Notch signaling pathway (KEGG)Signal Transduction of S1P Receptor (Wikipathways)Prostate cancer (KEGG){VHL,12} (Static Module){PLXNB1,15} (Static Module)EGFR1 down reg. targets (Netpath)Taurine and hypotaurine metabolism (KEGG)Matrix Metalloproteinases (Wikipathways)Regulation of actin cytoskeleton (KEGG)TGF beta receptor down reg. targets (Netpath)TGF−beta Receptor Signaling Pathway (Wikipathways)Colorectal cancer (KEGG)Pathogenic Escherichia coli infection (KEGG)EGFR1 up reg. targets (Netpath)G1 to S cell cycle control (Wikipathways)Id Signaling Pathway (Wikipathways){HIST3H3,14} (Static Module)Bacterial invasion of epithelial cells (KEGG){RAC1,133} (Static Module)AR down reg. targets (Netpath)TGF−beta signaling pathway (KEGG)Pathways in cancer (KEGG)Triacylglyceride Synthesis (Wikipathways)Ubiquinone and other terpenoid−quinone biosynthesis (KEGG){HMGB1,14} (Static Module){NAP1L1,23} (Static Module)Apoptosis (Reactome)Acetylcholine Synthesis (Wikipathways){RARA,17} (Static Module)Folate biosynthesis (KEGG)Metabolic pathways (KEGG)Globo Sphingolipid Metabolism (Wikipathways)Pentose Phosphate Pathway (Wikipathways)Glycosaminoglycan biosynthesis − keratan sulfate (KEGG)Glycosaminoglycan biosynthesis − heparan sulfate (KEGG)Fatty acid metabolism (KEGG)Signaling by Wnt (Reactome)Synthesis and degradation of ketone bodies (KEGG)Long−term depression (KEGG){PAX6,19} (Static Module){CDK5,14} (Static Module)Endometrial cancer (KEGG){HDAC1,108} (Static Module){EP300,115} (Static Module)Butanoate metabolism (KEGG){RAB5A,41} (Static Module){PRKCA,14} (Static Module)GPCRs, Class B Secretin−like (Wikipathways)Glucocorticoid &amp; Mineralcorticoid Metabolism (Wikipathways)Insulin signaling pathway (KEGG)Endocrine and other factor−regulated calcium reabsorption (KEGG)Taste transduction (KEGG)SREBP signalling (Wikipathways)Pantothenate and CoA biosynthesis (KEGG)Diabetes pathways (Reactome){ARF1,36} (Static Module)AR up reg. targets (Netpath)Hedgehog up reg. targets (Netpath)Protein export (KEGG)ErbB signaling pathway (Wikipathways)Alpha6−Beta4 Integrin Signaling Pathway (Wikipathways)TGF beta receptor up reg. targets (Netpath)TP53 network (Wikipathways)Hypertrophic cardiomyopathy (HCM) (KEGG)Dilated cardiomyopathy (KEGG){HSPA8,34} (Static Module)Fructose and mannose metabolism (KEGG)Huntington's disease (KEGG){NGF,31} (Static Module){AKT1,48} (Static Module)Metabolism of nucleotides (Reactome)Citrate cycle (TCA cycle) (KEGG)Pentose and glucuronate interconversions (KEGG){DLD,16} (Static Module)Integration of energy metabolism (Reactome)Signaling by Insulin receptor (Reactome)Nicotine Activity on Dopaminergic Neurons (Wikipathways)Glutamatergic synapse (KEGG)Pyruvate metabolism (KEGG)Glycolysis / Gluconeogenesis (KEGG)Pentose phosphate pathway (KEGG)Asthma (KEGG){TIA1,10} (Static Module){SIX3,11} (Static Module)Protein digestion and absorption (KEGG)Bladder cancer (KEGG)Statin Pathway (Wikipathways)Mucin type O−Glycan biosynthesis (KEGG)Glycosphingolipid biosynthesis − lacto and neolacto series (KEGG){KCNB1,10} (Static Module)Homologous recombination (Wikipathways)Non−homologous end−joining (KEGG)Tryptophan metabolism (KEGG)Metabolism of vitamins and cofactors (Reactome){USF1,13} (Static Module)Ubiquitin mediated proteolysis (KEGG){HTATIP,20} (Static Module)DNA replication (KEGG){RAD21,11} (Static Module)Base excision repair (KEGG){DHX15,14} (Static Module)Pyrimidine metabolism (KEGG)Alanine and aspartate metabolism (Wikipathways){TLE1,10} (Static Module){RPS27A,138} (Static Module)HIV Infection (Reactome)Transcription (Reactome)Regulation of beta−cell development (Reactome)Metabolism of proteins (Reactome)Urea cycle and metabolism of amino groups (Wikipathways)Cytoplasmic Ribosomal Proteins (Wikipathways)Cholesterol Biosynthesis (Wikipathways)miRNAs involved in DDR (Wikipathways)Ribosome (KEGG)Purine metabolism (KEGG)Glyoxylate and dicarboxylate metabolism (KEGG)> hist(geo.pluripotentDistance[pluripotents.frame$GSM, "distance"],

breaks = geo.pluripotentDistance.hist$breaks, xlim = c(0,1),
main = "", xlab = "")

> hist(GSE26946.pluripotentDistance[, "distance"],

breaks = geo.pluripotentDistance.hist$breaks, xlim = c(0,1),

main = "", col = "red", add = TRUE)

7.3

Identifying similar arrays

We can use the data contained within the GEO ﬁngerprint matrix to order
all of the GEO records according to distance from an experiment (or set of
experiments, see below). This can be used, in conjunction with the metadata,
to annotate a ﬁngerprint with data from the GEO corpus. Here, we will identify
experiments closely matched to the H1, embyonic stem cells within GSE26946

> GSE26946.H1<-consensusFingerprint(

GSE26946.fingerprint[,grep("H1", GSE26946.names)], threshold=0.9)

> geo.H1Distance<-consensusDistance(

GSE26946.H1, GEO.fingerprint.matrix)

[1] "Scaling against max length, 700"
> # look at top 20
> GEO.metadata.matrix[match(head(rownames(geo.H1Distance),20), rownames(GEO.metadata.matrix)),c("GSE", "GPL", "Source")]
DataFrame with 20 rows and 3 columns

GSE

GPL
<character> <character>
GPL6244
GPL6244
GPL6244
GPL6244
GPL6244
...
GPL6244
GPL6244
GPL6244
GPL6244
GPL6244

GSE26946
GSE26946
GSE26946
GSE26946
GSE26946
...
GSE21037
GSE21655
GSE21037
GSE21037
GSE21037

GSM663458
GSM663459
GSM663455
GSM663453
GSM663451
...
GSM525414
GSM697682
GSM525413
GSM525421
GSM525420

Source
<character>
Human Embryonic Stem Cells
GSM663458
Human Embryonic Stem Cells
GSM663459
induced pluripotent stem cells
GSM663455
induced pluripotent stem cells
GSM663453
induced pluripotent stem cells
GSM663451
...
...
GSM525414
iPSC-RTT clone 18
GSM697682 iPSC maintained under feeder conditions
iPSC-RTT clone 18
GSM525413
iPSC-WT clone 2
GSM525421
iPSC-WT clone 1
GSM525420

7

Figure 2: Histogram representing the distance from the pluripotent consen-
sus ﬁngerprint for all GEO (above), curated pluripotent samples (below), and
GSE26946 samples (below, red)

8

Distance from pluripotent consensusgeo.pluripotentDistance[, "distance"]Frequency0.00.20.40.60.81.002000400060008000Frequency0.00.20.40.60.81.00100