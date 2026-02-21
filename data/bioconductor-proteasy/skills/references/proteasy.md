# Using proteasy to Retrieve and Analyze Protease Data

Martin Rydén

#### 1 November 2022

#### Package

proteasy 1.0.0

# 1 Introduction

## 1.1 Motivation

Protease cleavages affect many vital physiological processes, and dysregulation
of proteolytic activity is associated with a variety of pathological
conditions. The field of degradomics is committed to provide insights about
proteolytic events by incorporating techniques for identification and
functional characterization of proteases and their substrates and inhibitors.

*[proteasy](https://bioconductor.org/packages/3.16/proteasy)* allows for batch identification of possible
proteases for a set of substrates (protein IDs and peptide sequences), and may
be an important tool in peptide-centric analyses of endogenously cleaved
peptides.

This package utilizes data derived from the
[MEROPS database](https://www.ebi.ac.uk/merops/).
The database is a manually curated knowledgebase with information about
proteolytic enzymes, their inhibitors and substrates.

This document illustrates the functionality of proteasy through some use cases.

## 1.2 Package scope and limitations

Similarly to existing tools such as
[TopFind](https://topfind.clip.msl.ubc.ca/), and
[Proteasix](http://www.proteasix.org), *[proteasy](https://bioconductor.org/packages/3.16/proteasy)*
exists for the purpose of retrieving data about proteases by mapping peptide
termini positions to known sites where a protease cleaves. Unlike the
*[cleaver](https://bioconductor.org/packages/3.16/cleaver)* package, which allows for in-silico cleavage
of amino acid sequences by specifying an enzyme, the functions in
*[proteasy](https://bioconductor.org/packages/3.16/proteasy)* relies only on experimentally derived data
to find proteases annotated to cleavage sites.

The *[proteasy](https://bioconductor.org/packages/3.16/proteasy)* package is limited to entries annotated
in MEROPS. Moreover, *[proteasy](https://bioconductor.org/packages/3.16/proteasy)* currently does not
allow for retrieval of proteolytic details for multiple organisms at once, or
inter-organism events. The package does however provide annotation data for all
organisms available in MEROPS.

The function findProtease will automatically map a peptide’s start- and end-
positions in its host-protein’s sequence. When a protein sequence has repeated
instances of a peptide sequence, *[proteasy](https://bioconductor.org/packages/3.16/proteasy)* will
only match to the first instance in the protein sequence.

# 2 Installation

The package should be installed using as described below:

```
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("proteasy")
```

The package can then be loaded with:

```
library("proteasy")
```

# 3 Usage

## 3.1 Find proteases by substrate search

A fast way to find which possible proteases, if any, are annotated as cleaving
actors for a substrate is by using the function *searchSubstrate*. Setting the
parameter summarize = TRUE will return only a vector of reviewed proteases,
and summarize = FALSE will return a table with details about each cleaving
event. We will explore the two options for kininogen-1 (P01042).

```
# Returns vector of reviewed proteases that cleave P01042
searchSubstrate(protein = "P01042", summarize = TRUE)
```

```
##  [1] "P07339" "P09668" "P07384" "P17655" "Q07075" "Q9UIQ6" "Q6P179" "Q6Q4G3"
##  [9] "Q9BYF1" "P52888" "Q99797" "P22894" "Q16819" "P08473" "P42892" "Q495T6"
## [17] "P15169" "P14384" "Q96IY4" "P14735" "Q5JRX3" "O43895" "Q9NQW7" "Q9Y337"
## [25] "Q9P0G3" "Q14520" "P08246" "P23946" "Q15661" "P20231" "P06870" "P20151"
## [33] "P03952" "P48147" "P42785" "Q9UHL4"
```

```
# Returns data.table with details on cleaving events
searchSubstrate(protein = "P01042", summarize = FALSE) |>
    head()
```

```
##    Protease (Uniprot) Protease status Protease organism Protease (MEROPS)
## 1:             P07339        reviewed      Homo sapiens           A01.009
## 2:             P07339        reviewed      Homo sapiens           A01.009
## 3:             P07339        reviewed      Homo sapiens           A01.009
## 4:             P09668        reviewed      Homo sapiens           C01.040
## 5:             P09668        reviewed      Homo sapiens           C01.040
## 6:             P07384        reviewed      Homo sapiens           C02.001
##    Cleaved residue   Substrate name Substrate (Uniprot) Residue number
## 1:               L      kininogen-1              P01042            289
## 2:               K      kininogen-1              P01042            316
## 3:               F      kininogen-1              P01042            321
## 4:               F       Bradykinin              P01042            385
## 5:               F Lysyl-bradykinin              P01042            385
## 6:               R      kininogen-1              P01042            389
##    Substrate organism Protease name     Cleavage type
## 1:       Homo sapiens   cathepsin D     physiological
## 2:       Homo sapiens   cathepsin D     physiological
## 3:       Homo sapiens   cathepsin D     physiological
## 4:       Homo sapiens   cathepsin H non-physiological
## 5:       Homo sapiens   cathepsin H non-physiological
## 6:       Homo sapiens     calpain-1     physiological
```

```
# The function also accepts multiple proteins as input. Let's inspect
# the last rows in the returned data.table.
searchSubstrate(protein = c("P01042", "P02461"), summarize = FALSE) |>
    tail()
```

```
##    Protease (Uniprot) Protease status Protease organism Protease (MEROPS)
## 1:             Q59EM4      unreviewed      Homo sapiens           S28.002
## 2:             B4DPD6      unreviewed      Homo sapiens           S28.002
## 3:             R4GNE8      unreviewed      Homo sapiens           S28.002
## 4:             R4GMR2      unreviewed      Homo sapiens           S28.002
## 5:             Q59EM4      unreviewed      Homo sapiens           S28.002
## 6:             B4DPD6      unreviewed      Homo sapiens           S28.002
##    Cleaved residue   Substrate name Substrate (Uniprot) Residue number
## 1:               P bradykinin (1-3)              P01042            382
## 2:               P bradykinin (1-3)              P01042            382
## 3:               P bradykinin (1-5)              P01042            382
## 4:               P bradykinin (1-5)              P01042            382
## 5:               P bradykinin (1-5)              P01042            382
## 6:               P bradykinin (1-5)              P01042            382
##    Substrate organism           Protease name     Cleavage type
## 1:       Homo sapiens dipeptidyl-peptidase II non-physiological
## 2:       Homo sapiens dipeptidyl-peptidase II non-physiological
## 3:       Homo sapiens dipeptidyl-peptidase II non-physiological
## 4:       Homo sapiens dipeptidyl-peptidase II non-physiological
## 5:       Homo sapiens dipeptidyl-peptidase II non-physiological
## 6:       Homo sapiens dipeptidyl-peptidase II non-physiological
```

```
# With summarize = FALSE we get both reviewed and unreviewed proteases.
```

## 3.2 Find substrates by protease search

A corresponding function, *searchProtease*, exists to find which (if any)
substrates a protease cleaves. The function is demonstrated with
MMP-12 (P39900) as an example.

```
# Returns vector of substrates that MMP-12 cleave
searchProtease(protein = "P39900", summarize = TRUE)
```

```
##  [1] "P00748"   "P15502"   "P02686"   "P15502-2" "P10646"   "P02751"
##  [7] "P08519"   "Q06828"   "P51888"   "P10909"   "P02647"   "P01009"
## [13] "P02671"   "P02778"   "P02458"   "P02461"   "P35556"   "Q07325"
## [19] "P21810"   "P07585"   "P15502-1" "O14625"   "P01857"   "P35555"
## [25] "Q03405"
```

```
# Returns data.table with details on cleaving events that involve MMP-12
searchProtease(protein = "P39900", summarize = FALSE) |> head()
```

```
##    Cleaved residue Protease (MEROPS)         Substrate name Substrate (Uniprot)
## 1:               A           M10.009 coagulation factor XII              P00748
## 2:               A           M10.009                elastin              P15502
## 3:               A           M10.009                elastin              P15502
## 4:               A           M10.009                elastin              P15502
## 5:               A           M10.009                elastin              P15502
## 6:               A           M10.009                elastin              P15502
##    Residue number Substrate organism              Protease name Cleavage type
## 1:            379       Homo sapiens matrix metallopeptidase-12 physiological
## 2:            670       Homo sapiens matrix metallopeptidase-12 physiological
## 3:            102       Homo sapiens matrix metallopeptidase-12 physiological
## 4:            687       Homo sapiens matrix metallopeptidase-12 physiological
## 5:             90       Homo sapiens matrix metallopeptidase-12 physiological
## 6:            688       Homo sapiens matrix metallopeptidase-12 physiological
##    Protease (Uniprot) Protease status Protease organism
## 1:             P39900        reviewed      Homo sapiens
## 2:             P39900        reviewed      Homo sapiens
## 3:             P39900        reviewed      Homo sapiens
## 4:             P39900        reviewed      Homo sapiens
## 5:             P39900        reviewed      Homo sapiens
## 6:             P39900        reviewed      Homo sapiens
```

## 3.3 Find possible proteases for cleaved peptides

The function *findProtease* automatically maps the peptide sequences to the
full-length protein sequence and obtains the start- and end-positions for the
peptide. Then, the positions are searched against the MEROPs database and
matches are returned.

```
# Create a vector of Uniprot IDs and corresponding peptide sequences

protein <- c("P02671", "P02671", "P68871",
             "P01011", "P68133", "P02461",
             "P0DJI8", "P0DJI8", "P0DJI8")
peptide <- c("FEEVSGNVSPGTR", "FVSETESR", "LLVVYPW",
             "ITLLSAL", "DSYVGDEAQS", "AGGFAPYYG",
             "FFSFLGEAFDGAR", "EANYIGSDKY", "GGVWAAEAISDAR")

# If we do not specify start position (start_pos) and end position
# (end_pos), the function will automatically assign these values by
# matching the provided peptide sequence against the full-length
# protein sequence.

res <- findProtease(protein = protein,
                    peptide = peptide,
                    organism = "Homo sapiens")

# The resulting S4 object can be inspected in three ways;
# (to save space we show only the first six rows)

# 1. Display sequence data for the provided input:

substrates(res) |> head()
```

```
##              Substrate name Substrate (Uniprot)
## 1:   fibrinogen alpha chain              P02671
## 2:   fibrinogen alpha chain              P02671
## 3:  hemoglobin subunit beta              P68871
## 4: alpha-1-antichymotrypsin              P01011
## 5:  Serum amyloid A protein              P0DJI8
## 6:  Serum amyloid A protein              P0DJI8
##                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    Substrate sequence
## 1: MFSMRIVCLVLSVVGTAWTADSGEGDFLAEGGGVRGPRVVERHQSACKDSDWPFCSDEDWNYKCPSGCRMKGLIDEVNQDFTNRINKLKNSLFEYQKNNKDSHSLTTNIMEILRGDFSSANNRDNTYNRVSEDLRSRIEVLKRKVIEKVQHIQLLQKNVRAQLVDMKRLEVDIDIKIRSCRGSCSRALAREVDLKDYEDQQKQLEQVIAKDLLPSRDRQHLPLIKMKPVPDLVPGNFKSQLQKVPPEWKALTDMPQMRMELERPGGNEITRGGSTSYGTGSETESPRNPSSAGSWNSGSSGPGSTGNRNPGSSGTGGTATWKPGSSGPGSTGSWNSGSSGTGSTGNQNPGSPRPGSTGTWNPGSSERGSAGHWTSESSVSGSTGQWHSESGSFRPDSPGSGNARPNNPDWGTFEEVSGNVSPGTRREYHTEKLVTSKGDKELRTGKEKVTSGSTTTTRRSCSKTVTKTVIGPDGHKEVTKEVVTSEDGSDCPEAMDLGTLSGIGTLDGFRHRHPDEAAFFDTASTGKTFPGFFSPMLGEFVSETESRGSESGIFTNTKESSSHHPGIAEFPSRGKSSSYSKQFTSSTSYNRGDSTFESKSYKMADEAGSEADHEGTHSTKRGHAKSRPVRDCDDVLQTHPSGTQSGIFNIKLPGSSKIFSVYCDQETSLGGWLLIQQRMDGSLNFNRTWQDYKRGFGSLNDEGEGEFWLGNDYLHLLTQRGSVLRVELEDWAGNEAYAEYHFRVGSEAEGYALQVSSYEGTAGDALIEGSVEEGAEYTSHNNMQFSTFDRDADQWEENCAEVYGGGWWYNNCQAANLNGIYYPGGSYDPRNNSPYEIENGVVWVSFRGADYSLRAVRMKIRPLVTQ
## 2: MFSMRIVCLVLSVVGTAWTADSGEGDFLAEGGGVRGPRVVERHQSACKDSDWPFCSDEDWNYKCPSGCRMKGLIDEVNQDFTNRINKLKNSLFEYQKNNKDSHSLTTNIMEILRGDFSSANNRDNTYNRVSEDLRSRIEVLKRKVIEKVQHIQLLQKNVRAQLVDMKRLEVDIDIKIRSCRGSCSRALAREVDLKDYEDQQKQLEQVIAKDLLPSRDRQHLPLIKMKPVPDLVPGNFKSQLQKVPPEWKALTDMPQMRMELERPGGNEITRGGSTSYGTGSETESPRNPSSAGSWNSGSSGPGSTGNRNPGSSGTGGTATWKPGSSGPGSTGSWNSGSSGTGSTGNQNPGSPRPGSTGTWNPGSSERGSAGHWTSESSVSGSTGQWHSESGSFRPDSPGSGNARPNNPDWGTFEEVSGNVSPGTRREYHTEKLVTSKGDKELRTGKEKVTSGSTTTTRRSCSKTVTKTVIGPDGHKEVTKEVVTSEDGSDCPEAMDLGTLSGIGTLDGFRHRHPDEAAFFDTASTGKTFPGFFSPMLGEFVSETESRGSESGIFTNTKESSSHHPGIAEFPSRGKSSSYSKQFTSSTSYNRGDSTFESKSYKMADEAGSEADHEGTHSTKRGHAKSRPVRDCDDVLQTHPSGTQSGIFNIKLPGSSKIFSVYCDQETSLGGWLLIQQRMDGSLNFNRTWQDYKRGFGSLNDEGEGEFWLGNDYLHLLTQRGSVLRVELEDWAGNEAYAEYHFRVGSEAEGYALQVSSYEGTAGDALIEGSVEEGAEYTSHNNMQFSTFDRDADQWEENCAEVYGGGWWYNNCQAANLNGIYYPGGSYDPRNNSPYEIENGVVWVSFRGADYSLRAVRMKIRPLVTQ
## 3:                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                MVHLTPEEKSAVTALWGKVNVDEVGGEALGRLLVVYPWTQRFFESFGDLSTPDAVMGNPKVKAHGKKVLGAFSDGLAHLDNLKGTFATLSELHCDKLHVDPENFRLLGNVLVCVLAHHFGKEFTPPVQAAYQKVVAGVANALAHKYH
## 4:                                                                                                                                                                                                                                                                                                                                                                                                                                                            MERMLPLLALGLLAAGFCPAVLCHPNSPLDEENLTQENQDRGTHVDLGLASANVDFAFSLYKQLVLKAPDKNVIFSPLSISTALAFLSLGAHNTTLTEILKGLKFNLTETSEAEIHQSFQHLLRTLNQSSDELQLSMGNAMFVKEQLSLLDRFTEDAKRLYGSEAFATDFQDSAAAKKLINDYVKNGTRGKITDLIKDLDSQTMMVLVNYIFFKAKWEMPFDPQDTHQSRFYLSKKKWVMVPMMSLHHLTIPYFRDEELSCTVVELKYTGNASALFILPDQDKMEEVEAMLLPETLKRWRDSLEFREIGELYLPKFSISRDYNLNDILLQLGIEEAFTSKADLSGITGARNLAVSQVVHKAVLDVFEEGTEASAATAVKITLLSALVETRTIVRFNRPFLMIIVPTDTQNIFFMSKVTNPKQA
## 5:                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         MKLLTGLVFCSLVLGVSSRSFFSFLGEAFDGARDMWRAYSDMREANYIGSDKYFHARGNYDAAKRGPGGAWAAEVITDARENIQRFFGHGAEDSLADQAANEWGRSGKDPNHFRPAGLPEKY
## 6:                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         MKLLTGLVFCSLVLGVSSRSFFSFLGEAFDGARDMWRAYSDMREANYIGSDKYFHARGNYDAAKRGPGGAWAAEVITDARENIQRFFGHGAEDSLADQAANEWGRSGKDPNHFRPAGLPEKY
##    Substrate length       Peptide Start position End position
## 1:              866 FEEVSGNVSPGTR            413          425
## 2:              866      FVSETESR            540          547
## 3:              147       LLVVYPW             32           38
## 4:              423       ITLLSAL            380          386
## 5:              122 FFSFLGEAFDGAR             21           33
## 6:              122    EANYIGSDKY             44           53
```

```
# 2. Show which known proteases may have cleaved this protein:

proteases(res) |> head()
```

```
##                        Protease name Protease (Uniprot) Protease status
## 1:                       cathepsin D             P07339        reviewed
## 2:                       cathepsin B             P07858        reviewed
## 3:             legumain, animal-type             Q99538        reviewed
## 4:           procollagen C-peptidase             P13497        reviewed
## 5: vertebrate tolloid-like 1 protein             O43897        reviewed
## 6:                       cathepsin D             V9HWI3      unreviewed
##    Protease (MEROPS)                                           Protease URL
## 1:           A01.009 https://www.ebi.ac.uk/merops/cgi-bin/pepsum?id=A01.009
## 2:           C01.060 https://www.ebi.ac.uk/merops/cgi-bin/pepsum?id=C01.060
## 3:           C13.004 https://www.ebi.ac.uk/merops/cgi-bin/pepsum?id=C13.004
## 4:           M12.005 https://www.ebi.ac.uk/merops/cgi-bin/pepsum?id=M12.005
## 5:           M12.016 https://www.ebi.ac.uk/merops/cgi-bin/pepsum?id=M12.016
## 6:           A01.009 https://www.ebi.ac.uk/merops/cgi-bin/pepsum?id=A01.009
```

```
# 3. Display details of associated proteolytic events:

cleavages(res) |> head()
```

```
##    Substrate (Uniprot)       Peptide Protease (Uniprot) Protease status
## 1:              P02671 FEEVSGNVSPGTR             P07339        reviewed
## 2:              P02671      FVSETESR             P07339        reviewed
## 3:              P68871       LLVVYPW             P07339        reviewed
## 4:              P01011       ITLLSAL             P07339        reviewed
## 5:              P0DJI8 FFSFLGEAFDGAR             P07858        reviewed
## 6:              P0DJI8    EANYIGSDKY             P07858        reviewed
##    Cleaved residue Cleaved terminus Cleavage type
## 1:               F                N physiological
## 2:               F                N physiological
## 3:               L                N  pathological
## 4:               L                C physiological
## 5:               F                N physiological
## 6:               E                N physiological
```

```
# We can find out what proportion of matching cleaving events by reviewed
# proteases occur at N- versus C-terminus

cl <- cleavages(res)[`Protease status` == "reviewed"]

cl$`Cleaved terminus` |> table() |> prop.table() |> round(digits = 2)
```

```
##
##   C   N
## 0.3 0.7
```

```
# And inspect the distribution of cleaved amino acids

cl$`Cleaved residue` |> table() |> barplot(cex.names = 2)
```

![](data:image/png;base64...)

```
# Find which protease is involved in the greatest number of cleaving events

cl[!duplicated(Peptide), .(count = .N), by = `Protease (Uniprot)`]
```

```
##    Protease (Uniprot) count
## 1:             P07339     4
## 2:             P07858     2
## 3:             Q99538     1
## 4:             P13497     1
```

```
# If start- and end-positions are specified, the function will not attempt
# to automatically look up sequence data for the specified protein/peptide.

cl_by_pos <- findProtease(
    protein = "P02671",
    peptide = "FEEVSGNVSPGTR",
    start_pos = 413,
    end_pos = 425
)

# However, this means sequence details for substrates is not available.

substrates(cl_by_pos)
```

```
##            Substrate name Substrate (Uniprot) Substrate sequence
## 1: fibrinogen alpha chain              P02671                 NA
##    Substrate length       Peptide Start position End position
## 1:               NA FEEVSGNVSPGTR            413          425
```

## 3.4 Look up a protease on MEROPS

We may want to read up on the details of an entry directly in MEROPS.
The function *browseProtease* takes a UniProt or MEROPS ID and opens the
MEROPS summary page which corresponds to that ID in a web browser.

```
browseProtease("P07339", keytype = "UniprotID") # (opens web browser)
```

# 4 Additional examples

## 4.1 Plot cleavages as a protein-protein interaction network.

Here we visualize the cleaving events of two substrates as a protein-protein
interaction network between substrates (red) and associated proteases (blue).

```
library(igraph)
library(data.table)
# Make a vector of substrates we want to investigate
proteins <- c('P01011','P02671')
# Look up known proteases which cleave these substrates, and associated data
# annotated to the cleaving events
res <- searchSubstrate(protein = proteins, summarize = FALSE)
# Filter to keep proteases with Uniprot status "reviewed"
res <- res[`Protease status` == "reviewed"]
# To create a network, we only need two columns of interactors
# i.e. the proteases with cleaving action on the substrates
res <- res[, c("Protease (Uniprot)", "Substrate (Uniprot)", "Cleavage type")]
# Construct the DAG
g <- igraph::graph_from_data_frame(res,
                                   directed = TRUE,
                                   vertices = unique(
                                       c(res$`Protease (Uniprot)`,
                                         res$`Substrate (Uniprot)`)))
# This will allow us to return to a layout we like
# (and where the legend fits nicely)
set.seed(104)
plot(g,
     vertex.label.family = "Helvetica",
     vertex.size = 14,
     vertex.color = ifelse(V(g)$name %in% res$`Protease (Uniprot)`,
                           "#377EB8", "#E41A1C"),
     vertex.label.cex = 1,
     vertex.label.color = "white",
     edge.arrow.size = .6,
     edge.color =  ifelse(E(g)$`Cleavage type` == "physiological",
                          "#01665E", "#8E0152"),
     layout = igraph::layout.davidson.harel)
legend(title = "Nodes", cex = 2, horiz = FALSE,
       title.adj = 0.0, inset = c(0.0, 0.2),
       "bottomleft", bty = "n",
       legend = c("Protease", "Substrate"),
       fill = c("#377EB8", "#E41A1C"), border = NA)
legend(title = "Edges", cex = 2, horiz = FALSE,
       title.adj = 0.0, inset = c(0.0, 0.0),
       "bottomleft", bty = "n",
       legend = c("Physiological", "Non-physiological"),
       fill = c("#01665E", "#8E0152"), border = NA)
```

![](data:image/png;base64...)

## 4.2 Annotated sequence similarity heatmaps

*[proteasy](https://bioconductor.org/packages/3.16/proteasy)* automatically finds protein sequences
from protein IDs (thanks to *[ensembldb](https://bioconductor.org/packages/3.16/ensembldb)* and
*[Rcpi](https://bioconductor.org/packages/3.16/Rcpi)*). We can use *substrates()* to access them.
Here, we look study similarity matrices of some protein- and peptide-level
sequences and plot them as heatmaps, which we annotate with cleavage data.

```
# Load additional libraries

library(Rcpi)
library(viridis)
suppressPackageStartupMessages(library(ComplexHeatmap))

# Prepare input: protein and associated peptide sequences

protein <- c('P01011','P01011','P01034','P01034',
             'P01042','P02671','P02671','P68871',
             'P68871','P01042')

peptide <- c('LVETRTIVRFNRPFLMIIVPTDTQNIFFMSKVTNPK','ITLLSAL',
             'KAFCSFQIY','AFCSFQIY','DIPTNSPELEETLTHTITKL','FEEVSGNVSPGTR',
             'FVSETESR','LLVVYPW','VDEVGGEALGR','KIYPTVNCQPLGMISLM')

# Find cleaving data associated with above substrates

res <- findProtease(protein = protein,
                    peptide = peptide,
                    organism = "Homo sapiens")

# Get substrate info

ss <- substrates(res)

# Show only unique sequences

ss_uniq <- ss[!duplicated(`Substrate sequence`)]

# Calculate protein (substrate) sequence similarity

psimmat = Rcpi::calcParProtSeqSim(ss_uniq$`Substrate sequence`,
                                  type = 'global',
                                  submat = 'BLOSUM62')

rownames(psimmat) <- colnames(psimmat) <- ss_uniq$`Substrate (Uniprot)`

# Plot as a heatmap

ComplexHeatmap::Heatmap(psimmat, col = viridis::mako(100))
```

![](data:image/png;base64...)

```
# We can do the same thing for peptide sequences,
# and annotate each row (cleaved peptide) with
# information about cleaved residue and termini

# Get cleavage details

cl <- cleavages(res)

# Calculate peptide sequence similarity

pep_psimmat = Rcpi::calcParProtSeqSim(cl$Peptide, type = 'global',
                                      submat = 'BLOSUM62')

# Right side annotation: cleaved residue

rsd <- cl$`Cleaved residue`
cols <- c("#8DD3C7", "#FFFFB3", "#BEBADA", "#FB8072")
names(cols) <- unique(rsd)
ha1 <- ComplexHeatmap::columnAnnotation(`cleaved residue` = rsd,
                         col = list(`cleaved residue` = cols))

# Right side annotation: Terminus

tn <- cl$`Cleaved terminus`
cols <- c("#B3E2CD", "#FDCDAC")
names(cols) <- unique(tn)
ha2 <- ComplexHeatmap::columnAnnotation(terminus = tn,
                     col = list(terminus = cols))

rownames(pep_psimmat) <- cl$`Substrate (Uniprot)`

# Plot as a heatmap

ComplexHeatmap::Heatmap(
    pep_psimmat,
    name = "sequence\nsimilarity",
    col = viridis::mako(100),
    show_column_names = FALSE,
    row_names_gp = grid::gpar(fontsize = 6.5),
    top_annotation = c(ha1, ha2)
)
```

![](data:image/png;base64...)

# 5 Session Information

```
## R version 4.2.1 (2022-06-23)
## Platform: x86_64-pc-linux-gnu (64-bit)
## Running under: Ubuntu 20.04.5 LTS
##
## Matrix products: default
## BLAS:   /home/biocbuild/bbs-3.16-bioc/R/lib/libRblas.so
## LAPACK: /home/biocbuild/bbs-3.16-bioc/R/lib/libRlapack.so
##
## locale:
##  [1] LC_CTYPE=en_US.UTF-8          LC_NUMERIC=C
##  [3] LC_TIME=en_GB                 LC_COLLATE=C
##  [5] LC_MONETARY=en_US.UTF-8       LC_MESSAGES=en_US.UTF-8
##  [7] LC_PAPER=en_US.UTF-8          LC_NAME=en_US.UTF-8
##  [9] LC_ADDRESS=en_US.UTF-8        LC_TELEPHONE=en_US.UTF-8
## [11] LC_MEASUREMENT=en_US.UTF-8    LC_IDENTIFICATION=en_US.UTF-8
##
## attached base packages:
## [1] grid      stats     graphics  grDevices utils     datasets  methods
## [8] base
##
## other attached packages:
## [1] ComplexHeatmap_2.14.0 viridis_0.6.2         viridisLite_0.4.1
## [4] Rcpi_1.34.0           data.table_1.14.4     igraph_1.3.5
## [7] proteasy_1.0.0        BiocStyle_2.26.0
##
## loaded via a namespace (and not attached):
##   [1] colorspace_2.0-3            rjson_0.2.21
##   [3] ellipsis_0.3.2              circlize_0.4.15
##   [5] XVector_0.38.0              GlobalOptions_0.1.2
##   [7] GenomicRanges_1.50.0        clue_0.3-62
##   [9] EnsDb.Hsapiens.v86_2.99.0   bit64_4.0.5
##  [11] AnnotationDbi_1.60.0        fansi_1.0.3
##  [13] xml2_1.3.3                  codetools_0.2-18
##  [15] R.methodsS3_1.8.2           doParallel_1.0.17
##  [17] cachem_1.0.6                GOSemSim_2.24.0
##  [19] knitr_1.40                  itertools_0.1-3
##  [21] jsonlite_1.8.3              Cairo_1.6-0
##  [23] Rsamtools_2.14.0            rJava_1.0-6
##  [25] cluster_2.1.4               GO.db_3.16.0
##  [27] dbplyr_2.2.1                png_0.1-7
##  [29] R.oo_1.25.0                 BiocManager_1.30.19
##  [31] compiler_4.2.1              httr_1.4.4
##  [33] assertthat_0.2.1            Matrix_1.5-1
##  [35] fastmap_1.1.0               lazyeval_0.2.2
##  [37] cli_3.4.1                   htmltools_0.5.3
##  [39] prettyunits_1.1.1           tools_4.2.1
##  [41] gtable_0.3.1                glue_1.6.2
##  [43] GenomeInfoDbData_1.2.9      dplyr_1.0.10
##  [45] rappdirs_0.3.3              Rcpp_1.0.9
##  [47] Biobase_2.58.0              jquerylib_0.1.4
##  [49] vctrs_0.5.0                 Biostrings_2.66.0
##  [51] rtracklayer_1.58.0          iterators_1.0.14
##  [53] xfun_0.34                   stringr_1.4.1
##  [55] lifecycle_1.0.3             restfulr_0.0.15
##  [57] ensembldb_2.22.0            XML_3.99-0.12
##  [59] zlibbioc_1.44.0             scales_1.2.1
##  [61] hms_1.1.2                   MatrixGenerics_1.10.0
##  [63] ProtGenerics_1.30.0         fingerprint_3.5.7
##  [65] parallel_4.2.1              SummarizedExperiment_1.28.0
##  [67] RColorBrewer_1.1-3          AnnotationFilter_1.22.0
##  [69] rcdk_3.7.0                  yaml_2.3.6
##  [71] curl_4.3.3                  gridExtra_2.3
##  [73] memoise_2.0.1               ggplot2_3.3.6
##  [75] sass_0.4.2                  biomaRt_2.54.0
##  [77] stringi_1.7.8               RSQLite_2.2.18
##  [79] highr_0.9                   S4Vectors_0.36.0
##  [81] BiocIO_1.8.0                foreach_1.5.2
##  [83] GenomicFeatures_1.50.0      BiocGenerics_0.44.0
##  [85] filelock_1.0.2              BiocParallel_1.32.0
##  [87] shape_1.4.6                 GenomeInfoDb_1.34.0
##  [89] rlang_1.0.6                 pkgconfig_2.0.3
##  [91] matrixStats_0.62.0          bitops_1.0-7
##  [93] evaluate_0.17               lattice_0.20-45
##  [95] GenomicAlignments_1.34.0    bit_4.0.4
##  [97] tidyselect_1.2.0            magrittr_2.0.3
##  [99] bookdown_0.29               R6_2.5.1
## [101] IRanges_2.32.0              magick_2.7.3
## [103] generics_0.1.3              DelayedArray_0.24.0
## [105] DBI_1.1.3                   pillar_1.8.1
## [107] KEGGREST_1.38.0             RCurl_1.98-1.9
## [109] tibble_3.1.8                crayon_1.5.2
## [111] rcdklibs_2.8                utf8_1.2.2
## [113] BiocFileCache_2.6.0         rmarkdown_2.17
## [115] GetoptLong_1.0.5            progress_1.2.2
## [117] blob_1.2.3                  digest_0.6.30
## [119] R.utils_2.12.1              stats4_4.2.1
## [121] munsell_0.5.0               bslib_0.4.0
```