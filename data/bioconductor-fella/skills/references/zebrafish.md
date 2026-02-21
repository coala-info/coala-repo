An oxybenzone exposition study on gilt-
head bream

Sergio Picart-Armada ∗1 and Alexandre Perera-Lluna †1

1B2SLab at Polytechnic University of Catalonia

∗sergi.picart@upc.edu †alexandre.perera@upc.edu

September 18, 2018

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

2

Enrichment analysis on liver tissue .

Building the database.

Note on reproducibility .

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

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

Examining the pathways .

.

Examining the metabolites .

.

.

3

Enrichment analysis on plasma.

Defining the input and running the enrichment .

Examining the pathways .

.

Examining the metabolites .

1.1

1.2

2.1

2.2

2.3

3.1

3.2

3.3

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

4

5

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

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

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

3

3

6

6

7

7

10

10

11

11

13

An oxybenzone exposition study on gilt-head bream

1

Introduction

This vignette contains a case study of the effects of environmental contamination on gilt-head
bream (Sparus aurata) (Ziarrusta et al. 2018). Fish were exposed over 14 days to oxybenzone
and changes were sought in their brain, liver and plasma using untargeted metabolomics.
Samples were processed using Ultra-performance liquid chromatography mass-spectrometry
(UHPLC-qOrbitrap MS) in positive and negative modes with both C18 and HILIC separation.

The mortality of exposed fish was not altered, as well as the brain-related metabolites. However,
liver and plasma showed perturbations, proving that adverse effects beyond the well-studied
hormonal activity were present.

The enrichment procedure implemented in FELLA (Picart-Armada et al. 2017) was used in
the study for a deeper understanding of the dysregulated metabolites in both tissues.

1.1

Building the database

At the time of publication, the KEGG database (Kanehisa et al. 2016) –upon which FELLA
is based– did not have pathway annotations for the Sparus aurata organism. It is common,
however, to use the zebrafish (Danio rerio) pathways as a good approximation. KEGG provides
pathway annotations for it under the organismal code dre, which will be used to build the
FELLA.DATA object.

library(FELLA)

library(igraph)

library(magrittr)

set.seed(1)

# Filter the dre01100 overview pathway, as in the article

graph <- buildGraphFromKEGGREST(

organism = "dre",

filter.path = c("01100"))

tmpdir <- paste0(tempdir(), "/my_database")
# Make sure the database does not exist from a former vignette build

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

We load the FELLA.DATA object to run both analyses:

fella.data <- loadKEGGdata(

databaseDir = tmpdir,

internalDir = FALSE,

2

An oxybenzone exposition study on gilt-head bream

loadMatrix = "none"

)

Given the 11-month temporal gap between the study and this vignette, small changes to the
amount of nodes in each category are expected (see section 2.4 Data handling and statistical
analyses from the study). Please see the Note on reproducibility to understand why.

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

* Nodes: 11857
* Edges: 35610
* Density: 0.0002533139
* Categories:

+ pathway [182]

+ module [121]

+ enzyme [1086]

+ reaction [6044]

+ compound [4424]

##

* Size: 5.8 Mb
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

1.2

Note on reproducibility

We want to emphasise that each time this vignette is built, FELLA constructs its FELLA.DATA
object using the most recent version of the KEGG database. KEGG is frequently updated
and therefore small changes can take place in the knowledge graph between different releases.
The discussion on our findings was written at the date specified in the vignette header and
using the KEGG release in the Reproducibility section.

2

Enrichment analysis on liver tissue

2.1

Defining the input and running the enrichment

Table 1 from the main body in (Ziarrusta et al. 2018) contains 5 KEGG identifiers associated
to metabolic changes in liver tissue and 12 in plasma. Our first enrichment analysis with
FELLA will be based on the liver-derived metabolites. Also note that we use the faster approx

3

An oxybenzone exposition study on gilt-head bream

= "normality" approach, whereas the original article uses approx = "simulation" with niter
= 15000 This is not only intended to keep the bulding time of this vignette as low as possible,
but also to demonstrate that the findings using both statistical approaches are consistent.

cpd.liver <- c(

"C12623",

"C01179",

"C05350",

"C05598",

"C01586"

)

analysis.liver <- enrich(

compounds = cpd.liver,

data = fella.data,

method = "diffusion",

approx = "normality")

## No background compounds specified. Default background will be used.

## Warning in defineCompounds(compounds = compounds, compoundsBackground =

## compoundsBackground, : Some compounds were introduced as affected but they do

## not belong to the background. These compounds will be excluded from the

## analysis. Use 'getExcluded' to see them.

## Running diffusion...

## Computing p-scores through the specified distribution.

## Done.

All the metabolites are successfully mapped:

analysis.liver %>%

getInput %>%

getName(data = fella.data)

## $C01179

## [1] "3-(4-Hydroxyphenyl)pyruvate" "4-Hydroxyphenylpyruvate"

## [3] "p-Hydroxyphenylpyruvic acid"

##

## $C05350

## [1] "2-Hydroxy-3-(4-hydroxyphenyl)propenoate"

## [2] "4-Hydroxy-enol-phenylpyruvate"

##

## $C05598

## [1] "Phenylacetylglycine"

##

## $C12623

## [1] "trans-2,3-Dihydroxycinnamate"

## [2] "(2E)-3-(2,3-Dihydroxyphenyl)prop-2-enoate"

Below is a plot of the reported sub-network using the default parameters. The five metabolites
are present and lie within the same connected component.

plot(

analysis.liver,

method = "diffusion",

data = fella.data,

4

An oxybenzone exposition study on gilt-head bream

nlimit = 250,

plotLegend = FALSE)

We will examine the igraph object with the reported sub-network and some of its reported
entities in tabular format:

g.liver <- generateResultsGraph(

object = analysis.liver,

data = fella.data,

method = "diffusion")

tab.liver <- generateResultsTable(

object = analysis.liver,

data = fella.data,

method = "diffusion")

## Writing diffusion results...

## Done.

The reported sub-network contains around 100 nodes and can be manually inquired:

g.liver

## IGRAPH 94adf82 UNW- 88 144 --

## + attr: organism (g/c), name (v/c), com (v/n), NAME (v/x), entrez

## | (v/x), label (v/c), input (v/l), weight (e/n)

## + edges from 94adf82 (vertex names):

##

##

##

[1] dre00350--M00042

dre00350--M00044

dre00360--1.13.11.27

[4] M00044 --1.13.11.27 dre00360--1.14.16.1

dre00400--1.14.16.1

[7] M00042 --1.14.16.2 dre00360--1.4.3.2

dre00400--1.4.3.2

## [10] M00044 --1.4.3.2

dre00350--1.4.3.21

dre00360--1.4.3.21

5

Tyrosine metabolism − ...Phenylalanine metaboli...Phenylalanine, tyrosin...Catecholamine biosynth...Tyrosine degradation, ...4−hydroxyphenylpyruvat...phenylalanine 4−monoox...tyrosine 3−monooxygena...L−amino−acid oxidaseprimary−amine oxidaseaspartate transaminasetyrosine transaminasearomatic−L−amino−acid ...phenylpyruvate tautome...1,2−benzenediol:oxygen...4−hydroxyphenylpyruvat...acetaldehyde:NAD+ oxid...L−aspartic acid:oxygen...glycine:ferricytochrom...glycine:oxygen oxidore...L−alanine:glyoxylate a...glycine:2−oxoglutarate...glycine:oxaloacetate a...sarcosine:oxygen oxido...L−phenylalanine:NAD+ o...L−phenylalanine:oxygen...L−phenylalanine:pyruva...L−phenylalanine:2−oxog...L−phenylalanine ammoni...L−tyrosine:oxygen oxid...L−tyrosine:oxygen oxid...L−tyrosine:2−oxoglutar...5,10−methylenetetrahyd...glycine:NAD+ 2−oxidore...phenylpyruvate:oxygen ...prephenate hydro−lyase...D−phenylalanine:quinon...phenylpyruvate carboxy...phenylpyruvate keto−en...D−phenylalanine:2−oxog...prephenate:NAD+ oxidor...prephenate:NADP+ oxido...4−hydroxyphenylacetate...4−hydroxyphenylacetate...4−hydroxyphenylpyruvat...phenylacetate:CoA liga...phenylacetyl−CoA:L−glu...(R)−3−(4−hydroxyphenyl...(R)−3−(4−hydroxyphenyl...4−hydroxyphenylpyruvat...3−(4−hydroxyphenyl)pyr...phenylacetyl−CoA:glyci...4−Hydroxyphenylglyoxyl...4−hydroxyphenylpyruvat...trans−Cinnamate <=> tr...trans−cinnamate,NADH:o...(2E)−3−(cis−5,6−dihydr...(2E)−3−(3−hydroxypheny...(2E)−3−(2,3−dihydroxyp...(2Z,4E,7E)−2−hydroxy−6...Phenylacetic acid <=> ...phenylacetyl−CoA:quino...L−tyrosine:pyruvate am...L−tyrosine:NAD+ oxidor...phenylacetyl−CoA:oxyge...Phenylacetyl−CoA + H2O...L−phenylalanine:2−oxo−...L−tyrosine carboxy−lya...L−phenylalanine carbox...L−tyrosine:hydrogen−pe...sarcosine,5,6,7,8−tetr...sarcosine:ferredoxin o...L−Tyrosine + NADPH + O...3−(4−hydroxyphenyl)pyr...CoAGlycineL−TyrosinePhenylpyruvatePhenylacetyl−CoA3−(4−Hydroxyphenyl)pyr...2−Hydroxy−3−phenylprop...(R)−3−(4−Hydroxyphenyl...2−Hydroxy−3−(4−hydroxy...Phenylacetylglycinetrans−3−Hydroxycinnama...cis−3−(3−Carboxyetheny...trans−2,3−Dihydroxycin...2−Hydroxy−6−ketononatr...An oxybenzone exposition study on gilt-head bream

## [13] dre00350--2.6.1.1

dre00360--2.6.1.1

dre00400--2.6.1.1

## [16] dre00360--2.6.1.5

dre00400--2.6.1.5

M00044

--2.6.1.5

## [19] dre00360--4.1.1.28

M00042

--4.1.1.28

dre00350--5.3.2.1

## + ... omitted several edges

2.2

Examining the pathways

Figure 2 from the original study frames the five metabolites in the input around Phenylalanine
metabolism. We can verify that FELLA finds such pathway and two closely related suggestions:
Tyrosine metabolism and Phenylalanine, tyrosine and tryptophan biosynthesis.

path.fig2 <- "dre00360" # Phenylalanine metabolism

path.fig2 %in% V(g.liver)$name

## [1] TRUE

These are the reported pathways:

tab.liver[tab.liver$Entry.type == "pathway", ]

##

KEGG.id Entry.type

KEGG.name

## 1 dre00350

pathway

Tyrosine metabolism - Danio rerio (zebrafish)

## 2 dre00360

pathway Phenylalanine metabolism - Danio rerio (zebra...

## 3 dre00400

pathway Phenylalanine, tyrosine and tryptophan biosyn...

##

p.score

## 1 0.000001000

## 2 0.000001000

## 3 0.009093168

2.3

Examining the metabolites

Figure 2 also gathers two types of metabolites: metabolites in the input (inside shaded frames)
and other contextual metabolites (no frames) that link the input metabolites.

First of all, we can check that all the input metabolites appear in the suggested sub-network.
While it’s expected that most of the input metabolites appear as relevant, it is an impor-
tant property of our method, in order to elaborate a sensible biological justification of the
experimental differences.

cpd.liver %in% V(g.liver)$name

## [1] TRUE TRUE TRUE TRUE FALSE

On the other hand, one of the two contextual metabolites is also suggested by FELLA, proving
its usefulness to fill the gaps between the input metabolites.

cpd.fig2 <- c(

"C00079", # Phenylalanine

"C00082" # Tyrosine

)

cpd.fig2 %in% V(g.liver)$name

## [1] FALSE TRUE

6

An oxybenzone exposition study on gilt-head bream

3

Enrichment analysis on plasma

3.1

Defining the input and running the enrichment

As shown in section Defining the input and running the enrichment, 12 KEGG identifiers (one
ID is repeated) are related to the experimental changes observed in plasma, which are the
starting point of the enrichment:

cpd.plasma <- c(

"C16323",

"C00740",

"C08323",

"C00623",

"C00093",

"C06429",

"C16533",

"C00740",

"C06426",

"C06427",

"C07289",

"C01879"

) %>% unique

analysis.plasma <- enrich(

compounds = cpd.plasma,

data = fella.data,

method = "diffusion",

approx = "normality")

## No background compounds specified. Default background will be used.

## Running diffusion...

## Computing p-scores through the specified distribution.

## Done.

The totality of the 11 unique metabolites map to the FELLA.DATA object:

analysis.plasma %>%

getInput %>%

getName(data = fella.data)

## $C16323

## [1] "3,6-Nonadienal"

##

## $C00740

## [1] "D-Serine"

##

## $C08323

## [1] "(15Z)-Tetracosenoic acid"

"Nervonic acid"

## [3] "(Z)-15-Tetracosenoic acid"

##

## $C00623

## [1] "sn-Glycerol 1-phosphate" "sn-Gro-1-P"

## [3] "L-Glycerol 1-phosphate"

##

7

An oxybenzone exposition study on gilt-head bream

## $C00093

## [1] "sn-Glycerol 3-phosphate" "Glycerophosphoric acid"

## [3] "D-Glycerol 1-phosphate"

##

## $C06429

## [1] "(4Z,7Z,10Z,13Z,16Z,19Z)-Docosahexaenoic acid"

## [2] "4,7,10,13,16,19-Docosahexaenoic acid"

## [3] "Docosahexaenoic acid"

## [4] "Docosahexaenoate"

## [5] "4Z,7Z,10Z,13Z,16Z,19Z-Docosahexaenoic acid"

## [6] "(4Z,7Z,10Z,13Z,16Z,19Z)-Docosa-4,7,10,13,16,19-hexaenoic acid"

##

## $C16533

## [1] "(13Z,16Z)-Docosadienoic acid"

"(13Z,16Z)-Docosa-13,16-dienoic acid"

## [3] "13Z,16Z-Docosadienoic acid"

##

## $C06426

## [1] "(6Z,9Z,12Z)-Octadecatrienoic acid" "6,9,12-Octadecatrienoic acid"

## [3] "gamma-Linolenic acid"

"Gamolenic acid"

##

## $C06427

## [1] "(9Z,12Z,15Z)-Octadecatrienoic acid" "alpha-Linolenic acid"

## [3] "9,12,15-Octadecatrienoic acid"

"Linolenate"

## [5] "alpha-Linolenate"

##

## $C07289

## [1] "Crepenynate"

"(9Z)-Octadec-9-en-12-ynoate"

## [3] "(Z)-9-Octadecen-12-ynoic acid" "Crepenynic acid"

##

## $C01879

## [1] "5-Oxoproline"

"Pidolic acid"

## [3] "Pyroglutamic acid"

"5-Pyrrolidone-2-carboxylic acid"

## [5] "Pyroglutamate"

"5-Oxo-L-proline"

## [7] "L-Pyroglutamic acid"

"L-5-Pyrrolidone-2-carboxylic acid"

Again, the reported sub-network consists of a large connected component encompassing most
input metabolites:

plot(

analysis.plasma,

method = "diffusion",

data = fella.data,

nlimit = 250,

plotLegend = FALSE)

8

An oxybenzone exposition study on gilt-head bream

We will export the results as a network and as a table:

g.plasma <- generateResultsGraph(

object = analysis.plasma,

data = fella.data,

method = "diffusion")

tab.plasma <- generateResultsTable(

object = analysis.plasma,

data = fella.data,

method = "diffusion")

## Writing diffusion results...

## Done.

The reported sub-network is a bit larger than the one from liver, containing roughly 120 nodes:

g.plasma

## IGRAPH 2154bff UNW- 150 243 --

## + attr: organism (g/c), name (v/c), com (v/n), NAME (v/x), entrez

## | (v/x), label (v/c), input (v/l), weight (e/n)

## + edges from 2154bff (vertex names):

##

##

##

[1] dre00260--M00020

dre00062--M00085

dre01212--M00085

[4] dre01212--M00086

dre00062--M00415

dre01040--M00415

[7] dre01212--M00415

dre01040--M00861

dre01212--M00861

## [10] dre00564--1.1.1.8

dre00564--1.1.5.3

dre01040--1.14.19.1

## [13] dre01212--1.14.19.1 dre00592--1.14.19.3 dre01040--1.14.19.3

## [16] dre01212--1.14.19.3 dre00564--2.3.1.15

dre00592--2.3.1.16

## [19] M00085 --2.3.1.16 M00861

--2.3.1.16

M00861

--2.3.1.176

## + ... omitted several edges

9

Fatty acid elongation ...Glycine, serine and th...D−Amino acid metabolis...Glycerophospholipid me...Linoleic acid metaboli...alpha−Linolenic acid m...Biosynthesis of unsatu...Fatty acid metabolism ...Cornified envelope for...Serine biosynthesis, g...Fatty acid elongation ...beta−Oxidation, acyl−C...Fatty acid elongation ...beta−Oxidation, peroxi...glycerol−3−phosphate d...glycerol−3−phosphate d...stearoyl−CoA 9−desatur...acyl−CoA 6−desaturaseglycerol−3−phosphate 1...acetyl−CoA C−acyltrans...propanoyl−CoA C−acyltr...1−acylglycerophosphoch...protein−glutamine gamm...glycerol kinaseL−serine−phosphatidyle...CDP−diacylglycerol−−−g...phospholipase A1phospholipase A2lysophospholipasepalmitoyl−CoA hydrolas...palmitoyl[protein] hyd...phosphoserine phosphat...glycerophosphocholine ...matriptasefurinbleomycin hydrolasecalpain−15−oxoprolinase (ATP−hy...protein−arginine deimi...CDP−glycerol diphospha...ethanolamine−phosphate...D−serine ammonia−lyaseglutathione−specific g...gamma−glutamylcyclotra...NADH:ferricytochrome−b...L−serine ammonia−lyaseD−serine ammonia−lyase5−oxo−L−proline amidoh...O−phospho−L−serine pho...serine racemasesn−glycerol−3−phosphat...sn−glycerol−3−phosphat...sn−glycerol−3−phosphat...sn−glycerol−3−phosphat...ATP:glycerol 3−phospho...sn−glycerol−3−phosphat...acyl−CoA:sn−glycerol−3...CDPglycerol phosphogly...CTP:sn−glycerol−3−phos...L−cysteinylglycine dip...sn−glycero−3−phosphoch...glutathione:L−amino−ac...palmitoyl−CoA hydrolas...phosphatidylcholine ph...phosphatidylcholine 2−...phosphatidylcholine 1−...phosphatidylcholine 2−...acyl−CoA:1−acyl−sn−gly...acyl−CoA:2−acyl−sn−gly...sn−glycero−3−phosphoet...CDP−diacylglycerol:sn−...phosphatidylglycerol c...gamma−L−glutamyl−L−cys...D−Serine + Amino acid(...(5−L−glutamyl)−L−amino...linoleoyl−CoA,ferrocyt...beta−alanyl−L−arginine...geranylgeranyl diphosp...sn−glycerol−1−phosphat...sn−glycerol−1−phosphat...linoleate,ferrocytochr...CDP−diacylglycerol:cho...acyl−CoA:sn−glycerol−3...linoleoyl−CoA,hydrogen...phosphatidylcholine 2−...Phosphatidylcholine + ...acetyl−CoA:heparan−alp...Phosphatidylcholine + ...Phosphatidylcholine + ...(9Z,12Z,15Z)−Octadecat...(9Z,11E,15Z)−(13S)−hyd...(9Z,12Z,15Z)−Octadecat...9(S)−HPOT <=> 9,10−EOT...(8E)−9−[(1E,3Z,6Z)−non...9(S)−HPOT <=> 9−Oxonon...(9Z,12Z,15Z)−Octadecat...(4Z,7Z,10Z,13Z,16Z,19Z...stearoyl−CoA hydrolaseoleoyl−CoA hydrolaselinoleoyl−CoA hydrolas...(9Z,12Z,15Z)−Octadecat...(4Z,7Z,10Z,13Z,16Z,19Z...gamma−Linolenoyl−CoA +...Arachidonyl−CoA + H2O ...Tetracosenoyl−CoA + H2...(13Z,16Z)−Docosadienoy...gamma−L−glutamyl−butir...long−chain fatty−acyl−...oleoyl−CoA,ferrocytoch...glutathione gamma−glut...acyl−CoA:phosphatidyl−...acyl−CoA:phosphatidyl−...linoleoyl−CoA,ferrocyt...acyl phosphoate:sn−gly...sn−Glycerol 1−phosphat...L−Serine <=> Ethanolam...(9Z,12Z,15Z)−Octadecat...CoAL−Serinesn−Glycerol 3−phosphat...Glycerone phosphateL−Amino acidPhosphatidylcholinesn−Glycerol 1−phosphat...D−SerineFerricytochrome b5Ferrocytochrome b5Cys−GlyLinoleateOrnithineD−Lombricine5−OxoprolineAmino acid(Arg−)gamma−Linolenoyl−CoA(5−L−Glutamyl)−L−amino...(6Z,9Z,12Z)−Octadecatr...(9Z,12Z,15Z)−Octadecat...(4Z,7Z,10Z,13Z,16Z,19Z...Crepenynate(15Z)−Tetracosenoic ac...(4Z,7Z,10Z,13Z,16Z,19Z...Colnelenic acid9(S)−HPOT9−Oxononanoic acid3,6−Nonadienal9,10−EOTTetracosenoyl−CoA(13Z,16Z)−Docosadienoi...(13Z,16Z)−Docosadienoy...gamma−L−Glutamyl−butir...An oxybenzone exposition study on gilt-head bream

3.2

Examining the pathways

Figure 3 from the original study is a holistic view of the affected metabolites found in plasma,
based on literature and on an analysis with FELLA. The 11 metabolites are depicted within
their core metabolic pathways. We will check whether FELLA is able to highlight them, by
first showing the reported metabolic pathways:

tab.plasma[tab.plasma$Entry.type == "pathway", ]

##

KEGG.id Entry.type

KEGG.name

## 1 dre00062

pathway Fatty acid elongation - Danio rerio (zebrafis...

## 2 dre00260

pathway Glycine, serine and threonine metabolism - Da...

## 3 dre00470

pathway D-Amino acid metabolism - Danio rerio (zebraf...

## 4 dre00564

pathway Glycerophospholipid metabolism - Danio rerio ...

## 5 dre00591

pathway Linoleic acid metabolism - Danio rerio (zebra...

## 6 dre00592

pathway alpha-Linolenic acid metabolism - Danio rerio...

## 7 dre01040

pathway Biosynthesis of unsaturated fatty acids - Dan...

## 8 dre01212

pathway Fatty acid metabolism - Danio rerio (zebrafis...

## 9 dre04382

pathway Cornified envelope formation - Danio rerio (z...

##

p.score

## 1 1.000000e-06

## 2 5.010749e-03

## 3 8.957334e-03

## 4 3.281915e-06

## 5 2.707888e-02

## 6 1.000000e-06

## 7 1.000000e-06

## 8 5.777889e-06

## 9 1.682997e-06

And then comparing against the ones in Figure 3 :

path.fig3 <- c(

"dre00591", # Linoleic acid metabolism

"dre01040", # Biosynthesis of unsaturated fatty acids

"dre00592", # alpha-Linolenic acid metabolism

"dre00564", # Glycerophospholipid metabolism

"dre00480", # Glutathione metabolism

"dre00260" # Glycine, serine and threonine metabolism

)

path.fig3 %in% V(g.plasma)$name

## [1] TRUE TRUE TRUE TRUE FALSE

TRUE

All of them but Glutathione metabolism are recovered, showing how FELLA can help gaining
perspective on the input metabolites.

3.3

Examining the metabolites

As in the analogous section for liver, we will quantify how many input metabolites, drawn
within a shaded frame in Figure 3, are reported in the sub-network:

cpd.plasma %in% V(g.plasma)$name

##

[1] TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE

10

An oxybenzone exposition study on gilt-head bream

From the 11 highlighted metabolites, only one is not reported by FELLA: 5-Oxo-L-proline.

Conversely, two out of the three contextual metabolites from the same figure are reported:

cpd.fig3 <- c(

"C01595", # Linoleic acid

"C00157", # Phosphatidylcholine

"C00037" # Glycine

)

cpd.fig3 %in% V(g.plasma)$name

## [1] TRUE TRUE FALSE

As Figure 3 shows, the addition of linoleic acid and phosphatidylcholine, backed up by FELLA,
helps connecting almost all the metabolites found in blood.

FELLA misses glycine and, in fact, stays consistent with the pathway (Glutathione metabolism)
and the input metabolite (5-Oxo-L-proline) that it left out from Figure 3. The fact that FELLA
does not suggest such pathway seems to happen at several molecular levels and therefore
none of its metabolites are pinpointed.

Even if the glutathione pathway was not reported, FELLA can greatly ease the creation of
elaborated contextual figures, such as Figure 3, by suggesting the intermediate metabolites
and the metabolic pathways that link the input compounds.

4

Conclusions

In this vignette, we apply FELLA to an untargeted metabolic study of gilt-head bream exposed
to an environmental contaminat (oxybenzome). This study is an example of how FELLA can
be useful for (1) organisms not limited to Homo sapiens, and (2) conditions not limited to a
specific disease.

On one hand, FELLA helps creating complex contextual interpretations of the data, such as the
comprehensive Figure 3 from the original article (Ziarrusta et al. 2018). This material would
be challenging to build through regular over-representation analysis of the input metabolites.
On the other hand, metabolites and pathways suggested by FELLA were also mentioned in
the literature and supported the main findings in the study. In particular, it helped identify
key processes such as phenylalanine metabolism, alpha-linoleic acid metabolism and serine
metabolism, which ultimately pointed to alterations in oxidative stress.

5

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

LAPACK version 3.12.0

11

An oxybenzone exposition study on gilt-head bream

## locale:

##

##

##

##

[1] LC_CTYPE=en_US.UTF-8
[3] LC_TIME=en_GB
[5] LC_MONETARY=en_US.UTF-8
[7] LC_PAPER=en_US.UTF-8
[9] LC_ADDRESS=C

LC_NUMERIC=C
LC_COLLATE=C
LC_MESSAGES=en_US.UTF-8
LC_NAME=C
LC_TELEPHONE=C

##
## [11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C
##
## time zone: America/New_York
## tzcode source: system (glibc)

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

[1] sass_0.4.10
[4] digest_0.6.37
[7] bookdown_0.45
##
## [10] jsonlite_2.0.0
## [13] DBI_1.2.3
## [16] httr_1.4.7
## [19] cli_3.6.5
## [22] XVector_0.50.0
## [25] yaml_2.3.10
## [28] curl_7.0.0
## [31] png_0.1-8
## [34] Seqinfo_1.0.0
## [37] bslib_0.9.0
## [40] xfun_0.53
## [43] rmarkdown_2.30

RSQLite_2.4.3
evaluate_1.0.5
fastmap_1.2.0
plyr_1.8.9
tinytex_0.57
Biostrings_2.78.0
rlang_1.1.6
bit64_4.6.0-1
tools_4.5.1
vctrs_0.6.5
magick_2.9.0
bit_4.6.0
glue_1.8.0
knitr_1.50
compiler_4.5.1

lattice_0.22-7
grid_4.5.1
blob_1.2.4
Matrix_1.7-4
BiocManager_1.30.26
jquerylib_0.1.4
crayon_1.5.3
cachem_1.1.0
memoise_2.0.1
R6_2.6.1
lifecycle_1.0.4
pkgconfig_2.0.3
Rcpp_1.1.0
htmltools_0.5.8.1

KEGG version:

cat(getInfo(fella.data))

## T01004

## dre

##

##

##

## linked db

##

##

##

##

Danio rerio (zebrafish) KEGG Genes Database

Release 116.0+/10-26, Oct 25

Kanehisa Laboratories

41,508 entries

pathway

brite

module

ko

genome

12

An oxybenzone exposition study on gilt-head bream

##

##

##

##

enzyme

ncbi-geneid

ncbi-proteinid

uniprot

Date of generation:

date()

## [1] "Thu Oct 30 00:12:29 2025"

Image of the workspace (for submission):

tempfile(pattern = "vignette_dre_", fileext = ".RData") %T>%

message("Saving workspace to ", .) %>%

save.image(compress = "xz")

## Saving workspace to /tmp/RtmpxweDtV/vignette_dre_5aa0466406874.RData

References

Kanehisa, Minoru, Miho Furumichi, Mao Tanabe, Yoko Sato, and Kanae Morishima. 2016.
“KEGG: New Perspectives on Genomes, Pathways, Diseases and Drugs.” Nucleic Acids
Research 45 (D1): D353–D361.

Picart-Armada, Sergio, Francesc Fernández-Albert, Maria Vinaixa, Miguel A Rodríguez, Suvi
Aivio, Travis H Stracker, Oscar Yanes, and Alexandre Perera-Lluna. 2017. “Null Diffusion-
Based Enrichment for Metabolomics Data.” PloS One 12 (12): e0189012.

Ziarrusta, Haizea, Leire Mijangos, Sergio Picart-Armada, Mireia Irazola, Alexandre Perera-
Lluna, Aresatz Usobiaga, Ailette Prieto, Nestor Etxebarria, Maitane Olivares, and Olatz
Zuloaga. 2018. “Non-Targeted Metabolomics Reveals Alterations in Liver and Plasma of
Gilt-Head Bream Exposed to Oxybenzone.” Chemosphere 211: 624–31.

13

