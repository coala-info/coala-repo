A fatty liver study on Mus musculus

Sergio Picart-Armada ∗1 and Alexandre Perera-Lluna †1

1B2SLab at Polytechnic University of Catalonia

∗sergi.picart@upc.edu †alexandre.perera@upc.edu

September 17, 2018

Package

FELLA 1.30.0

Contents

1

Introduction .

.

.

.

.

.

.

.

Building the database.

Note on reproducibility .

2

Enrichment analysis .

.

.

.

1.1

1.2

2.1

2.2

2.3

3

4

Conclusions .

.

.

Reproducibility .

References .

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

Defining the input and running the enrichment .

Examining the metabolites .

Examining the genes .

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

3

4

4

6

8

12

12

14

A fatty liver study on Mus musculus

1

Introduction

This vignette shows the utility of the FELLA package, which is based in a statistically normalised
diffusion process (Picart-Armada et al. 2017), on non-human organisms. In particular, we
will work on a multi-omic Mus musculus study. The original study (Gogiashvili et al. 2017)
presents a mouse model of the non-alcoholic fatty liver disease (NAFLD). Metabolites in
liver tissue from leptin-deficient ob/ob mice and wild type mice were compared using Nuclear
Magnetic Resonance (NMR). Afterwards, quantitative real-time polymerase chain reaction
(qRT-PCR) helped identify changes at the gene expression level. Finally, biological mechanisms
behind NAFLD were elucidated by leveraging the data from both omics.

1.1

Building the database

The first step is to build the FELLA.DATA object for the mmu organism from the KEGG database
(Kanehisa et al. 2016).

library(FELLA)

library(org.Mm.eg.db)

library(KEGGREST)

library(igraph)

library(magrittr)

set.seed(1)

# Filter overview pathways

graph <- buildGraphFromKEGGREST(

organism = "mmu",

filter.path = c("01100", "01200", "01210", "01212", "01230"))

tmpdir <- paste0(tempdir(), "/my_database")
# Mke sure the database does not exist from a former vignette build

# Otherwise the vignette will rise an error

# because FELLA will not overwrite an existing database

unlink(tmpdir, recursive = TRUE)

buildDataFromGraph(

keggdata.graph = graph,

databaseDir = tmpdir,

internalDir = FALSE,

matrices = "none",

normality = "diffusion",

niter = 100)

We load the FELLA.DATA object and two mappings (from gene symbol to entrez identifiers,
and from enzyme EC numbers to their annotated entrez genes).

alias2entrez <- as.list(org.Mm.eg.db::org.Mm.egSYMBOL2EG)

entrez2ec <- KEGGREST::keggLink("enzyme", "mmu")

entrez2path <- KEGGREST::keggLink("pathway", "mmu")

fella.data <- loadKEGGdata(

databaseDir = tmpdir,

2

A fatty liver study on Mus musculus

internalDir = FALSE,

loadMatrix = "none"

)

Summary of the database:

fella.data

## General data:

## - KEGG graph:

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

* Nodes: 12152
* Edges: 38401
* Density: 0.0002600655
* Categories:

+ pathway [351]

+ module [130]

+ enzyme [1203]

+ reaction [6044]

+ compound [4424]

* Size: 6 Mb

## - KEGG names are ready.

## -----------------------------

## Hypergeometric test:

## - Matrix not loaded.

## -----------------------------

## Heat diffusion:

## - Matrix not loaded.

## - RowSums are ready.

## -----------------------------

## PageRank:

## - Matrix not loaded.

## - RowSums not loaded.

In addition, we will store the ids of all the metabolites, reactions and enzymes in the database:

id.cpd <- getCom(fella.data, level = 5, format = "id") %>% names

id.rx <- getCom(fella.data, level = 4, format = "id") %>% names

id.ec <- getCom(fella.data, level = 3, format = "id") %>% names

1.2

Note on reproducibility

We want to emphasise that FELLA builds its FELLA.DATA object using the most recent version
of the KEGG database. KEGG is frequently updated and therefore small changes can take
place in the knowledge graph between different releases. The discussion on our findings
was written at the date specified in the vignette header and using the KEGG release in the
Reproducibility section.

3

A fatty liver study on Mus musculus

2

Enrichment analysis

2.1

Defining the input and running the enrichment

Table 2 from the main body in (Gogiashvili et al. 2017) contains six metabolites that show
significant changes between the experimental classes by a univariate test followed by multiple
test correction. These are the start of our enrichment analysis:

cpd.nafld <- c(

"C00020", # AMP

"C00719", # Betaine

"C00114", # Choline

"C00037", # Glycine

"C00160", # Glycolate

"C01104" # Trimethylamine-N-oxide

)

analysis.nafld <- enrich(

compounds = cpd.nafld,

data = fella.data,

method = "diffusion",

approx = "normality")

## No background compounds specified. Default background will be used.

## Running diffusion...

## Computing p-scores through the specified distribution.

## Done.

Five compounds are successfully mapped to the graph object:

analysis.nafld %>%

getInput %>%

getName(data = fella.data)

## $C00020

## [1] "AMP"

"Adenosine 5'-monophosphate"

## [3] "Adenylic acid"

"Adenylate"

## [5] "5'-AMP"

"5'-Adenylic acid"

## [7] "5'-Adenosine monophosphate" "Adenosine 5'-phosphate"

##

## $C00719

## [1] "Betaine"

"Trimethylaminoacetate"

## [3] "Glycine betaine"

"N,N,N-Trimethylglycine"

## [5] "Trimethylammonioacetate"

##

## $C00114

## [1] "Choline"

"Bilineurine"

##

## $C00037

## [1] "Glycine"

"Aminoacetic acid" "Gly"

##

## $C00160

## [1] "Glycolate"

"Glycolic acid"

"Hydroxyacetic acid"

##

4

A fatty liver study on Mus musculus

## $C01104

## [1] "Trimethylamine N-oxide" "(CH3)3NO"

Likewise, one compound does not map:

getExcluded(analysis.nafld)

## character(0)

The highlighted subgraph with the default parameters has the following appeareance, with
large connected components that involve the metabolites in the input:

plot(

analysis.nafld,

method = "diffusion",

data = fella.data,

nlimit = 250,

plotLegend = FALSE)

We will also extract all the p-scores and the suggested sub-network for further analysis:

g.nafld <- generateResultsGraph(

object = analysis.nafld,

data = fella.data,

method = "diffusion")

pscores.nafld <- getPscores(

object = analysis.nafld,

method = "diffusion")

5

Glycine, serine and th...Glyoxylate and dicarbo...One carbon pool by fol...Neuroactive ligand sig...Synaptic vesicle cycle...Cholinergic synapse − ...Folate transport and m...Choline metabolism in ...C1−unit interconversio...Betaine biosynthesis, ...Glycine cleavage syste...Betaine metabolism, an...glyoxylate reductase (...hydroxypyruvate reduct...(S)−2−hydroxy−acid oxi...choline dehydrogenasebetaine−aldehyde dehyd...methylenetetrahydrofol...methylenetetrahydrofol...sarcosine oxidase (for...sarcosine dehydrogenas...dimethylglycine dehydr...glycine N−methyltransf...betaine−−−homocysteine...glycine hydroxymethylt...glycine C−acetyltransf...5−aminolevulinate synt...choline O−acetyltransf...alanine−−−glyoxylate t...serine−−−glyoxylate tr...serine−−−pyruvate tran...choline kinaseacetylcholinesterasephosphoglycolate phosp...phosphoethanolamine/ph...glycerophosphocholine ...phospholipase Dvesicle−fusing ATPaselow−specificity L−thre...formate−−−tetrahydrofo...ABC−type glutathione−S...glycine:ferricytochrom...glycine:oxygen oxidore...S−adenosyl−L−methionin...L−alanine:glyoxylate a...acetyl−CoA:glycine C−a...glycine:2−oxoglutarate...glycine:oxaloacetate a...glycolate:NADP+ oxidor...acetyl−CoA:glyoxylate ...glycolate:oxygen 2−oxi...glycolate:acceptor 2−o...gamma−L−glutamyl−L−cys...L−serine:glyoxylate am...sarcosine:oxygen oxido...sarcosine:electron−tra...glycolate:NAD+ oxidore...L−threonine acetaldehy...succinyl−CoA:glycine C...L−cysteinylglycine dip...5,10−methylenetetrahyd...ATP:choline phosphotra...choline:oxygen 1−oxido...acetyl−CoA:choline O−a...choline:acceptor 1−oxi...acetylcholine aectylhy...sn−glycero−3−phosphoch...glycine:NAD+ 2−oxidore...phosphatidylcholine ph...glycolaldehyde:NAD+ ox...2−phosphoglycolate pho...N,N−dimethylglycine,5,...N,N−dimethylglycine,5,...dimethylamine:electron...trimethylamine:electro...trimethylamine−N−oxide...sphingomyelin ceramide...trimethylamine:cytochr...p−cumic alcohol:NAD+ o...p−cumic alcohol:NADP+ ...trimethylaminoacetate:...chloroacetic acid hali...N,N,N−trimethylamine,N...glycine:acceptor oxido...CDP−diacylglycerol:cho...phosphocholine phospho...S−adenosyl−L−methionin...Phosphatidylcholine + ...O−1−Alk−1−enyl−2−acyl−...choline,reduced−ferred...glycine:oxygen oxidore...betaine aldehyde:oxyge...Choline + NAD+ <=> Bet...Choline + NADP+ <=> Be...5,10−methylenetetrahyd...trimethylamine:coenzym...dimethylamine:coenzyme...S−adenosyl−L−methionin...S−adenosyl−L−methionin...(S)−ureidoglycine:glyo...NAD+:glycine ADP−D−rib...glycine betaine:[Co(I)...sarcosine,5,6,7,8−tetr...glycine betaine,NADH:o...N,N−dimethylglycine:fe...sarcosine:ferredoxin o...GlycineGlyoxylateFormaldehydeCholineFerricytochrome cFerrocytochrome cGlycolateSarcosineDimethylamineTrimethylamineBetaine aldehydeBetaineN,N−DimethylglycineTrimethylamine N−oxideA fatty liver study on Mus musculus

2.2

Examining the metabolites

2.2.1

From Table 2

The authors find 5 extra metabolites in Table 2 that are significant at p < 0.05 but do not
appear after thresholding the false discovery rate at 5%. Such metabolites, highlighted in
italics but without an asterisk, are also relevant and play a role in their discussion. We will
examine how FELLA prioritises such metabolites:

cpd.nafld.suggestive <- c(

"C00008", # ADP

"C00791", # Creatinine

"C00025", # Glutamate

"C01026", # N,N-dimethylglycine

"C00079", # Phenylalanine

"C00299" # Uridine

)

getName(cpd.nafld.suggestive, data = fella.data)

## $C00008

## [1] "ADP"

##

## $C00791

"Adenosine 5'-diphosphate"

## [1] "Creatinine"

"1-Methylglycocyamidine"

##

## $C00025

## [1] "L-Glutamate"

"L-Glutamic acid"

"L-Glutaminic acid"

## [4] "Glutamate"

##

## $C01026

## [1] "N,N-Dimethylglycine" "Dimethylglycine"

##

## $C00079

## [1] "L-Phenylalanine"

## [2] "(S)-alpha-Amino-beta-phenylpropionic acid"

##

## $C00299

## [1] "Uridine"

When checking if any of these metabolites are found in the reported sub-network, we find
that C01026 is already reported:

V(g.nafld)$name %>%

intersect(cpd.nafld.suggestive) %>%

getName(data = fella.data)

## $C01026

## [1] "N,N-Dimethylglycine" "Dimethylglycine"

Abbreviated as DMG in their study, N,N-Dimethylglycine is a cornerstone of their findings.
It is reported in Figure 6a as part of the folate-independent remethylation to explain the
metabolic changes observed in the ob/ob mice. DMG is also mentioned in the conclusions as
part of one of the most prominent alterations found in the study: a reduced conversion of
betaine to DMG.

6

A fatty liver study on Mus musculus

2.2.2

From Figure 6a

Figure 6a contains the metabolic context of the observed alterations, with processes such
as transsulfuration and folate-dependent remethylation. These were identified with the help
of gene expression analysis. We will now check for coincidences between the metabolites in
Figure 6a, excluding choline and betaine for being in the input and DMG since it was already
discussed.

cpd.new.fig6 <- c(

"C00101", # THF

"C00440", # 5-CH3-THF

"C00143", # 5,10-CH3-THF

"C00073", # Methionine

"C00019", # SAM

"C00021", # SAH

"C00155", # Homocysteine

"C02291", # Cystathione

"C00097" # Cysteine

)

getName(cpd.new.fig6, data = fella.data)

## $C00101

## [1] "Tetrahydrofolate"

"5,6,7,8-Tetrahydrofolate"

## [3] "Tetrahydrofolic acid"

"THF"

## [5] "(6S)-Tetrahydrofolate"

"(6S)-Tetrahydrofolic acid"

## [7] "(6S)-THFA"

##

## $C00440

## [1] "5-Methyltetrahydrofolate"

##

## $C00143

## [1] "5,10-Methylenetetrahydrofolate"

"(6R)-5,10-Methylenetetrahydrofolate"

## [3] "5,10-Methylene-THF"

##

## $C00073

## [1] "L-Methionine"

"Methionine"

## [3] "L-2-Amino-4methylthiobutyric acid"

##

## $C00019

## [1] "S-Adenosyl-L-methionine" "S-Adenosylmethionine"

## [3] "AdoMet"

"SAM"

##

## $C00021

## [1] "S-Adenosyl-L-homocysteine" "S-Adenosylhomocysteine"

##

## $C00155

## [1] "L-Homocysteine"

## [3] "Homocysteine"

##

## $C02291

## [1] "L-Cystathionine"

##

## $C00097

"L-2-Amino-4-mercaptobutyric acid"

7

A fatty liver study on Mus musculus

## [1] "L-Cysteine"

"L-2-Amino-3-mercaptopropionic acid"

This time, there are no coincidences with the reported sub-network:

cpd.new.fig6 %in% V(g.nafld)$name

## [1] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE

However, we can further inquire whether the p-scores of such metabolites tend to be low
among all the metabolites in the whole network from the fella.data object.

wilcox.test(

x = pscores.nafld[cpd.new.fig6], # metabolites from fig6

y = pscores.nafld[setdiff(id.cpd, cpd.new.fig6)], # rest of metabolites

alternative = "less")

##

##

##

Wilcoxon rank sum test with continuity correction

## data: pscores.nafld[cpd.new.fig6] and pscores.nafld[setdiff(id.cpd, cpd.new.fig6)]

## W = 9220, p-value = 0.002706

## alternative hypothesis: true location shift is less than 0

The test is indeed significant – despite FELLA does not directly report such metabolites, its
metabolite ranking supports the claims by the authors.

2.3

Examining the genes

2.3.1 Cbs

The authors complement the metabolomic profilings with a differential gene expression study.
One of the main findings is a change of Cbs expression levels. To link Cbs to the enrichment
from FELLA, we will first map it to its EC number, 4.2.1.22 at the time of writing:

ec.cbs <- entrez2ec[[paste0("mmu:", alias2entrez[["Cbs"]])]] %>%

gsub(pattern = "ec:", replacement = "")

getName(fella.data, ec.cbs)
## $`4.2.1.22`
## [1] "cystathionine beta-synthase"

## [2] "serine sulfhydrase"

## [3] "beta-thionase"

## [4] "methylcysteine synthase"

## [5] "cysteine synthase (incorrect)"

## [6] "serine sulfhydrylase"

## [7] "L-serine hydro-lyase (adding homocysteine)"

In Figure 6a, the reaction linked to Cbs and catalysed by the enzyme 4.2.1.22 has the KEGG
identifier R01290.

rx.cbs <- "R01290"

getName(fella.data, rx.cbs)

## $R01290

8

A fatty liver study on Mus musculus

## [1] "L-serine hydro-lyase (adding homocysteine"

## [2] "L-cystathionine-forming)"

## [3] "L-Serine + L-Homocysteine <=> L-Cystathionine + H2O"

As shown in Figure 6a, Cbs is not directly linked to the metabolites found through NMR, and
nor the reaction neither the enzyme are suggested by FELLA:

c(rx.cbs, ec.cbs) %in% V(g.nafld)$name

## [1] FALSE FALSE

However, both of them have a relatively low p-score in their respective categories. This can
be seen through the proportion of enzymes (resp. reactions) that show a p-score as low or
lower than 4.2.1.22 (resp. R01290 )

# enzyme

pscores.nafld[ec.cbs]

##

4.2.1.22

## 0.3942142

mean(pscores.nafld[id.ec] <= pscores.nafld[ec.cbs])

## [1] 0.1637573

# reaction

pscores.nafld[rx.cbs]

##

R01290

## 0.2730613

mean(pscores.nafld[id.rx] <= pscores.nafld[rx.cbs])

## [1] 0.03242886

It’s not surprising that none of them is directly reported, because none of the metabolites
participating in the reaction is found in the input. The main evidence for finding Cbs is gene
expression, and our approach gives indirect hints of this connection.

2.3.2 Bhmt

The alteration of Bhmt activity is related to the downregulation of Cbs. Despite not finding
evidence of change in Bhmt expression, the authors argue that its inhibition would explain the
increased betaine-to-DMG ratio in ob/ob mice. Such claim is also backed up by prior studies.
To find out the role of Cbs in our analysis, we will again map it to its EC number, 2.1.1.5 :

ec.bhmt <- entrez2ec[[paste0("mmu:", alias2entrez[["Bhmt"]])]] %>%

gsub(pattern = "ec:", replacement = "")

getName(fella.data, ec.bhmt)
## $`2.1.1.5`
## [1] "betaine---homocysteine S-methyltransferase"

## [2] "betaine-homocysteine methyltransferase"

## [3] "betaine-homocysteine transmethylase"

This time, FELLA not only reports it, but also its associated reaction R02821 (represented
by an arrow in Figure 6a) and both of its metabolites. While betaine was already an input
metabolite, DMG was a novel finding as discussed earlier

9

A fatty liver study on Mus musculus

ec.bhmt %in% V(g.nafld)$name

## [1] TRUE

"R02821" %in% V(g.nafld)$name

## [1] TRUE

This illustrates how FELLA can translate knowledge from dysregulated metabolites to other
molecular levels, such as reactions and enzymes.

2.3.3 Slc22a5

The decrease of Bhmt activity is later connected to the upregulation of Slc22a5, also proved
within the original study. However, Slc22a5 does not map to any EC number and therefore it
cannot be found through FELLA:

entrez.slc22a5 <- alias2entrez[["Slc22a5"]]

entrez.slc22a5 %in% names(entrez2ec)

## [1] FALSE

As a matter of fact, the only connection that can be found from KEGG is the role of Slc22a5
in the Choline metabolism in cancer pathway.

path.slc22a5 <- entrez2path[paste0("mmu:", entrez.slc22a5)] %>%

gsub(pattern = "path:", replacement = "")

getName(fella.data, path.slc22a5)

## $mmu05231

## [1] "Choline metabolism in cancer - Mus musculus (house mouse)"

Coincidentally, this pathway is reported in the sub-graph:

path.slc22a5 %in% V(g.nafld)$name

## [1] TRUE

2.3.4 Genes from Figure 3

We also examined if genes from Table 3 were reachable in our analysis. These five literature-
derived genes were experimentally confirmed to show gene expression changes, in order to prove
that RNA extracted after the metabolomic profiling was still reliable for further transcriptomic
analyses. However, only Scd2 maps to an enzymatic family:

symbol.fig3 <- c(

"Cd36",

"Scd2",

"Apoa4",

"Lcn2",

"Apom")

entrez.fig3 <- alias2entrez[symbol.fig3] %>% unlist %>% unique

ec.fig3 <- entrez2ec[paste0("mmu:", entrez.fig3)] %T>%

print %>%

unlist %>%

unique %>%

10

A fatty liver study on Mus musculus

na.omit %>%

gsub(pattern = "ec:", replacement = "")

##

##

<NA>

mmu:20250

NA "ec:1.14.19.1"

<NA>

NA

<NA>

NA

<NA>

NA

getName(fella.data, ec.fig3)
## $`1.14.19.1`
## [1] "stearoyl-CoA 9-desaturase"

## [2] "Delta9-desaturase"

## [3] "acyl-CoA desaturase"

## [4] "fatty acid desaturase"

## [5] "stearoyl-CoA, hydrogen-donor:oxygen oxidoreductase"

Such family is not reported in our sub-graph

ec.fig3 %in% V(g.nafld)$name

## [1] FALSE

In addition, its p-score is high compared to other enzymes

pscores.nafld[ec.fig3]

## 1.14.19.1

##

0.570238

mean(pscores.nafld[id.ec] <= pscores.nafld[ec.fig3])

## [1] 0.7248545

The fact that only one gene mapped to an EC number hinders the potential findings using
FELLA, and is probably the main reason why FELLA missed Scd2. In addition, FELLA defines
a knowledge model that offers simplicity and interpretability, at the cost of introducing
limitations on how sophisticated its findings can be.

2.3.5 Genes from Table S2

In parallel with the original study, and cited within its main body, gene array expression data
was collected (Godoy et al. 2016) and its hits are included in the supplementary Table S2
from (Gogiashvili et al. 2017). These genes include the already discussed Cbs. We will
attempt to link the genes marked as significantly changed to our reported sub-network. In
contrast with Figure 3, all the genes map to an EC number:

symbol.tableS2 <- c(

"Mat1a",

"Ahcyl2",

"Cbs",

"Mat2b",

"Mtr")

entrez.tableS2 <- alias2entrez[symbol.tableS2] %>% unlist %>% unique

ec.tableS2 <- entrez2ec[paste0("mmu:", entrez.tableS2)] %T>%

print %>%

unlist %>%

unique %>%

na.omit %>%

gsub(pattern = "ec:", replacement = "")

11

A fatty liver study on Mus musculus

##

##

mmu:11720

mmu:74340

mmu:12411

mmu:108645

mmu:238505

"ec:2.5.1.6" "ec:3.13.2.1" "ec:4.2.1.22"

"ec:2.5.1.6" "ec:2.1.1.13"

None of these EC families are reported in the sub-graph:

ec.tableS2 %in% V(g.nafld)$name

## [1] FALSE FALSE FALSE FALSE

But in this case, their scores tend to be lower than the rest of enzymes:

wilcox.test(

x = pscores.nafld[ec.tableS2], # enzymes from table S2

y = pscores.nafld[setdiff(id.ec, ec.tableS2)], # rest of enzymes

alternative = "less")

##

##

##

Wilcoxon rank sum test with continuity correction

## data: pscores.nafld[ec.tableS2] and pscores.nafld[setdiff(id.ec, ec.tableS2)]

## W = 714, p-value = 0.007614

## alternative hypothesis: true location shift is less than 0

These findings suggest that if the annotation database is complete enough, FELLA can provide
a meaningful priorisisation of the enzymes surrounding the affected metabolites.

3

Conclusions

FELLA has been used to give a biological meaning to a list of 6 metabolites extracted from a
multi-omic study of a mouse model of NAFLD. It has been able to reproduce some findings
at the metabolite and gene expression levels, whereas most of the times missed entities would
still present a low ranking compared to their background in the database.
The bottom line from our analysis in the present vignette is that FELLA not only works on
human studies, but also generalises to animal models.

4

Reproducibility

This is the result of running sessionInfo()

sessionInfo()

## R version 4.5.1 Patched (2025-08-23 r88802)
## Platform: x86_64-pc-linux-gnu
## Running under: Ubuntu 24.04.3 LTS

##

## Matrix products: default

/home/biocbuild/bbs-3.22-bioc/R/lib/libRblas.so

## BLAS:
## LAPACK: /usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.12.0
##

## locale:

##

##

##

[1] LC_CTYPE=en_US.UTF-8
[3] LC_TIME=en_GB
[5] LC_MONETARY=en_US.UTF-8

LC_NUMERIC=C
LC_COLLATE=C
LC_MESSAGES=en_US.UTF-8

LAPACK version 3.12.0

12

A fatty liver study on Mus musculus

##

[7] LC_PAPER=en_US.UTF-8
[9] LC_ADDRESS=C

##
## [11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C
##
## time zone: America/New_York
## tzcode source: system (glibc)

LC_NAME=C
LC_TELEPHONE=C

##

## attached base packages:

## [1] stats4

stats

graphics

grDevices utils

datasets

methods

## [8] base

##

##

## other attached packages:
[1] magrittr_2.0.4
KEGGREST_1.50.0
igraph_2.2.1
[4] org.Mm.eg.db_3.22.0 AnnotationDbi_1.72.0 IRanges_2.44.0
[7] S4Vectors_0.48.0

##

Biobase_2.70.0
FELLA_1.30.0

BiocGenerics_0.56.0
BiocStyle_2.38.0

##
## [10] generics_0.1.4
##

## loaded via a namespace (and not attached):

##

##

[1] bit_4.6.0
Matrix_1.7-4
[4] BiocManager_1.30.26 crayon_1.5.3
[7] Rcpp_1.1.0
##
## [10] Seqinfo_1.0.0
## [13] fastmap_1.2.0
## [16] XVector_0.50.0
## [19] knitr_1.50
## [22] rlang_1.1.6
## [25] bit64_4.6.0-1
## [28] cli_3.6.5
## [31] lifecycle_1.0.4
## [34] evaluate_1.0.5
## [37] tools_4.5.1

blob_1.2.4
png_0.1-8
lattice_0.22-7
plyr_1.8.9
bookdown_0.45
cachem_1.1.0
memoise_2.0.1
digest_0.6.37
vctrs_0.6.5
rmarkdown_2.30
pkgconfig_2.0.3

compiler_4.5.1
tinytex_0.57
Biostrings_2.78.0
yaml_2.3.10
R6_2.6.1
curl_7.0.0
DBI_1.2.3
xfun_0.53
RSQLite_2.4.3
grid_4.5.1
glue_1.8.0
httr_1.4.7
htmltools_0.5.8.1

KEGG version:

cat(getInfo(fella.data))

## T01002

## mmu

##

##

##

## linked db

##

##

##

##

##

##

##

##

##

Mus musculus (house mouse) KEGG Genes Database

Release 116.0+/10-26, Oct 25

Kanehisa Laboratories

26,125 entries

pathway

brite

module

ko

mgi

genome

enzyme

ncbi-geneid

ncbi-proteinid

uniprot

13

A fatty liver study on Mus musculus

Date of generation:

date()

## [1] "Thu Oct 30 00:06:06 2025"

Image of the workspace (for submission):

tempfile(pattern = "vignette_mmu_", fileext = ".RData") %T>%

message("Saving workspace to ", .) %>%

save.image(compress = "xz")

## Saving workspace to /tmp/RtmpxweDtV/vignette_mmu_5aa0435c52a96.RData

References

Godoy, Patricio, Agata Widera, Wolfgang Schmidt-Heck, Gisela Campos, Christoph Meyer,
Cristina Cadenas, Raymond Reif, et al. 2016. “Gene Network Activity in Cultivated Primary
Hepatocytes Is Highly Similar to Diseased Mammalian Liver Tissue.” Archives of Toxicology
90 (10): 2513–29.

Gogiashvili, Mikheil, Karolina Edlund, Kathrin Gianmoena, Rosemarie Marchan, Alexander
Brik, Jan T Andersson, Jörg Lambert, et al. 2017. “Metabolic Profiling of Ob/Ob Mouse Fatty
Liver Using Hr-Mas 1 H-Nmr Combined with Gene Expression Analysis Reveals Alterations
in Betaine Metabolism and the Transsulfuration Pathway.” Analytical and Bioanalytical
Chemistry 409 (6): 1591–1606.

Kanehisa, Minoru, Miho Furumichi, Mao Tanabe, Yoko Sato, and Kanae Morishima. 2016.
“KEGG: New Perspectives on Genomes, Pathways, Diseases and Drugs.” Nucleic Acids
Research 45 (D1): D353–D361.

Picart-Armada, Sergio, Francesc Fernández-Albert, Maria Vinaixa, Miguel A Rodríguez, Suvi
Aivio, Travis H Stracker, Oscar Yanes, and Alexandre Perera-Lluna. 2017. “Null Diffusion-
Based Enrichment for Metabolomics Data.” PloS One 12 (12): e0189012.

14

