# Gene Summaries from RefSeq Database

#### Zuguang Gu (z.gu@dkfz.de)

#### 2023-09-27

This package provides long description of genes collected from [the RefSeq database](https://ftp.ncbi.nih.gov/refseq/). The text in “COMMENT” section started with “Summary:” is extracted as the description of the gene, e.g. in the following example:

```
LOCUS       NM_012363                936 bp    mRNA    linear   PRI 12-FEB-2021
DEFINITION  Homo sapiens olfactory receptor family 1 subfamily N member 1
            (OR1N1), mRNA.
ACCESSION   NM_012363 XM_071152
VERSION     NM_012363.1
KEYWORDS    RefSeq; MANE Select.
SOURCE      Homo sapiens (human)
  ORGANISM  Homo sapiens
            Eukaryota; Metazoa; Chordata; Craniata; Vertebrata; Euteleostomi;
            Mammalia; Eutheria; Euarchontoglires; Primates; Haplorrhini;
            Catarrhini; Hominidae; Homo.
REFERENCE   1  (bases 1 to 936)
  AUTHORS   Malnic B, Godfrey PA and Buck LB.
  TITLE     The human olfactory receptor gene family
  JOURNAL   Proc Natl Acad Sci U S A 101 (8), 2584-2589 (2004)
   PUBMED   14983052
  REMARK    Erratum:[Proc Natl Acad Sci U S A. 2004 May 4;101(18):7205]
REFERENCE   2  (bases 1 to 936)
  AUTHORS   Fuchs T, Malecova B, Linhart C, Sharan R, Khen M, Herwig R,
            Shmulevich D, Elkon R, Steinfath M, O'Brien JK, Radelof U, Lehrach
            H, Lancet D and Shamir R.
  TITLE     DEFOG: a practical scheme for deciphering families of genes
  JOURNAL   Genomics 80 (3), 295-302 (2002)
   PUBMED   12213199
REFERENCE   3  (bases 1 to 936)
  AUTHORS   Rouquier S, Taviaux S, Trask BJ, Brand-Arpon V, van den Engh G,
            Demaille J and Giorgi D.
  TITLE     Distribution of olfactory receptor genes in the human genome
  JOURNAL   Nat Genet 18 (3), 243-250 (1998)
   PUBMED   9500546
  REMARK    Erratum:[Nat Genet 1998 May;19(1):102]
COMMENT     REVIEWED REFSEQ: This record has been curated by NCBI staff. The
            reference sequence was derived from AL359636.17.
            On Apr 5, 2004 this sequence version replaced XM_071152.1.

            Summary: Olfactory receptors interact with odorant molecules in the
            nose, to initiate a neuronal response that triggers the perception
            of a smell. The olfactory receptor proteins are members of a large
            family of G-protein-coupled receptors (GPCR) arising from single
            coding-exon genes. Olfactory receptors share a 7-transmembrane
            domain structure with many neurotransmitter and hormone receptors
            and are responsible for the recognition and G protein-mediated
            transduction of odorant signals. The olfactory receptor gene family
            is the largest in the genome. The nomenclature assigned to the
            olfactory receptor genes and proteins for this organism is
            independent of other organisms. [provided by RefSeq, Jul 2008].

            ##RefSeq-Attributes-START##
            MANE Ensembl match     :: ENST00000304880.2/ ENSP00000306974.2
            RefSeq Select criteria :: based on single protein-coding transcript
            ##RefSeq-Attributes-END##
```

Function `loadGeneSummary()` extracts the gene summary table. Specifying the `organism` argument with the full name or the corresponding taxon ID returns a table of genes and their summaries:

```
library(GeneSummary)
```

```
## Gene summaries were retrieved from RefSeq database release 220 (December 21, 2022).
```

```
tb = loadGeneSummary(organism = 9606)
# # or use the full organism name
# tb = loadGeneSummary(organism = "Homo sapiens")
dim(tb)
```

```
## [1] 73575     6
```

```
head(tb)
```

```
##   RefSeq_accession     Organism Taxon_ID Gene_ID      Review_status
## 1      NR_030309.1 Homo sapiens     9606  693168 PROVISIONAL REFSEQ
## 2   NM_001353788.2 Homo sapiens     9606     321    REVIEWED REFSEQ
## 3   NM_001004748.1 Homo sapiens     9606  401667 PROVISIONAL REFSEQ
## 4   NM_001370511.1 Homo sapiens     9606    5723    REVIEWED REFSEQ
## 5      NM_206891.3 Homo sapiens     9606   23181    REVIEWED REFSEQ
## 6      NM_130846.3 Homo sapiens     9606    5801    REVIEWED REFSEQ
##                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      Gene_summary
## 1 microRNAs (miRNAs) are short (20-24 nt) non-coding RNAs that are involved in post-transcriptional regulation of gene expression in multicellular organisms by affecting both the stability and translation of mRNAs. miRNAs are transcribed by RNA polymerase II as part of capped and polyadenylated primary transcripts (pri-miRNAs) that can be either protein-coding or non-coding. The primary transcript is cleaved by the Drosha ribonuclease III enzyme to produce an approximately 70-nt stem-loop precursor miRNA (pre-miRNA), which is further cleaved by the cytoplasmic Dicer ribonuclease to generate the mature miRNA and antisense miRNA star (miRNA*) products. The mature miRNA is incorporated into a RNA-induced silencing complex (RISC), which recognizes target mRNAs through imperfect base pairing with the miRNA and most commonly results in translational inhibition or destabilization of the target mRNA. The RefSeq represents the predicted microRNA stem-loop.
## 2                                                                                                                                                                                                                                                                                                                                                              The protein encoded by this gene is a member of the X11 protein family. It is a neuronal adapter protein that interacts with the Alzheimer's disease amyloid precursor protein (APP). It stabilizes APP and inhibits production of proteolytic APP fragments including the A beta peptide that is deposited in the brains of Alzheimer's disease patients. This gene product is believed to be involved in signal transduction processes. It is also regarded as a putative vesicular trafficking protein in the brain that can form a complex with the potential to couple synaptic vesicle exocytosis to neuronal cell adhesion.
## 3                                                                                                                                                                                                                                                                                                 Olfactory receptors interact with odorant molecules in the nose, to initiate a neuronal response that triggers the perception of a smell. The olfactory receptor proteins are members of a large family of G-protein-coupled receptors (GPCR) arising from single coding-exon genes. Olfactory receptors share a 7-transmembrane domain structure with many neurotransmitter and hormone receptors and are responsible for the recognition and G protein-mediated transduction of odorant signals. The olfactory receptor gene family is the largest in the genome. The nomenclature assigned to the olfactory receptor genes and proteins for this organism is independent of other organisms.
## 4                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            The protein encoded by this gene belongs to a subfamily of the phosphotransferases. This encoded enzyme is responsible for the third and last step in L-serine formation. It catalyzes magnesium-dependent hydrolysis of L-phosphoserine and is also involved in an exchange reaction between L-serine and L-phosphoserine. Deficiency of this protein is thought to be linked to Williams syndrome.
## 5                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    The protein encoded by this gene may be involved in axon patterning in the central nervous system. This gene is not highly expressed. Several transcript variants encoding different isoforms have been found for this gene.
## 6                                                                                                                                                                                                                             The protein encoded by this gene is a member of the protein tyrosine phosphatase (PTP) family. PTPs are known to be signaling molecules that regulate a variety of cellular processes including cell growth, differentiation, mitotic cycle, and oncogenic transformation. This PTP possesses an extracellular region, a single transmembrane region, and a single intracellular catalytic domain, and thus represents a receptor-type PTP. Silencing of this gene has been associated with colorectal cancer. Multiple transcript variants encoding different isoforms have been found for this gene. This gene shares a symbol (PTPRQ) with another gene, protein tyrosine phosphatase, receptor type, Q (GeneID 374462), which is also located on chromosome 12.
```

Setting `organism` to `NULL` returns a table of all organisms.

```
tb = loadGeneSummary(organism = NULL)
sort(table(tb$Organism))
```

```
##
##                       Aedes aegypti                     Aotus nancymaae
##                                   1                                   1
##                 Aplysia californica                   Bison bison bison
##                                   1                                   1
##                 Callorhinchus milii                   Macaca nemestrina
##                                   1                                   1
##              Mandrillus leucophaeus             Rhinopithecus roxellana
##                                   1                                   1
##                  Anas platyrhynchos                     Cercocebus atys
##                                   2                                   2
##                      Chelonia mydas        Colobus angolensis palliatus
##                                   2                                   2
##                   Crassostrea gigas                     Geospiza fortis
##                                   2                                   2
##                 Latimeria chalumnae                  Loxodonta africana
##                                   2                                   2
##             Melopsittacus undulatus                   Python bivittatus
##                                   2                                   2
##                  Alligator sinensis            Amphimedon queenslandica
##                                   3                                   3
##                 Chlorocebus sabaeus                       Columba livia
##                                   3                                   3
##                       Falco cherrug                    Falco peregrinus
##                                   3                                   3
##                  Nannospalax galili                 Oncorhynchus mykiss
##                                   3                                   3
##               Orycteropus afer afer                 Pelodiscus sinensis
##                                   3                                   3
##                         Salmo salar              Zonotrichia albicollis
##                                   3                                   3
##          Alligator mississippiensis                           Bos mutus
##                                   4                                   4
##                 Ficedula albicollis                 Meleagris gallopavo
##                                   4                                   4
##                     Myotis brandtii                      Myotis davidii
##                                   4                                   4
##               Pseudopodoces humilis              Ailuropoda melanoleuca
##                                   4                                   5
##                  Astyanax mexicanus          Balaenoptera acutorostrata
##                                   5                                   5
## Balaenoptera acutorostrata scammoni                       Camelus ferus
##                                   5                                   5
##               Elephantulus edwardii                     Panthera tigris
##                                   5                                   5
##                    Poecilia formosa                     Chrysemys picta
##                                   5                                   6
##               Heterocephalus glaber                  Otolemur garnettii
##                                   6                                   6
##                    Physeter catodon                 Saimiri boliviensis
##                                   6                                   6
##                       Sorex araneus                     Cavia porcellus
##                                   6                                   7
##                 Chinchilla lanigera                Dasypus novemcinctus
##                                   7                                   7
##             Leptonychotes weddellii                    Myotis lucifugus
##                                   7                                   7
##                       Octodon degus           Ceratotherium simum simum
##                                   7                                   8
##                  Condylura cristata                   Echinops telfairi
##                                   8                                   8
##                 Erinaceus europaeus                     Jaculus jaculus
##                                   8                                   8
##                Mesocricetus auratus               Mustela putorius furo
##                                   8                                   8
##                   Ochotona princeps                     Pteropus alecto
##                                   8                                   8
##                       Vicugna pacos              Chrysochloris asiatica
##                                   8                                   9
##          Ictidomys tridecemlineatus                  Lipotes vexillifer
##                                   9                                   9
##         Odobenus rosmarus divergens                        Orcinus orca
##                                   9                                   9
##      Trichechus manatus latirostris                  Tursiops truncatus
##                                   9                                   9
##                         Felis catus                Microtus ochrogaster
##                                  10                                  10
##                        Papio anubis                     Bubalus bubalis
##                                  10                                  11
##                 Macaca fascicularis                 Nomascus leucogenys
##                                  11                                  11
##      Peromyscus maniculatus bairdii                  Callithrix jacchus
##                                  11                                  15
##                      Hydra vulgaris                        Pongo abelii
##                                  20                                  22
##       Strongylocentrotus purpuratus                Sarcophilus harrisii
##                                  64                                  65
##                      Xenopus laevis                       Brassica rapa
##                                  85                                  89
##            Saccoglossus kowalevskii                        Cucumis melo
##                                  90                                 105
##                          Ovis aries                 Acyrthosiphon pisum
##                                 117                                 125
##                     Malus domestica                   Takifugu rubripes
##                                 132                                 141
##                     Citrus sinensis                Solanum lycopersicum
##                                 146                                 152
##                      Vitis vinifera                     Oryzias latipes
##                                 156                                 161
##                            Zea mays                        Pan paniscus
##                                 166                                 179
##                    Tupaia chinensis                   Solanum tuberosum
##                                 184                                 215
##                  Cricetulus griseus                  Xenopus tropicalis
##                                 236                                 245
##                 Taeniopygia guttata                      Apis mellifera
##                                 249                                 257
##                        Capra hircus                 Anolis carolinensis
##                                 277                                 294
##             Brachypodium distachyon               Oryctolagus cuniculus
##                                 312                                 323
##                  Ciona intestinalis                 Tribolium castaneum
##                                 331                                 334
##                 Nasonia vitripennis                     Gorilla gorilla
##                                 350                                 374
##            Ornithorhynchus anatinus                         Bombyx mori
##                                 418                                 423
##                          Sus scrofa                         Danio rerio
##                                 427                                 468
##                    Eptesicus fuscus                         Glycine max
##                                 494                                 671
##                      Macaca mulatta               Monodelphis domestica
##                                 677                                 685
##                     Pan troglodytes                       Gallus gallus
##                                 686                                 969
##              Canis lupus familiaris                      Equus caballus
##                                1101                                1463
##                          Bos taurus                   Rattus norvegicus
##                                1968                                2332
##                        Mus musculus                        Homo sapiens
##                               11008                               73575
```

```
sort(table(tb$Review_status))
```

```
##
##   PREDICTED REFSEQ    INFERRED REFSEQ   VALIDATED REFSEQ PROVISIONAL REFSEQ
##                 13               2374               8886              18920
##    REVIEWED REFSEQ
##              73610
```

A specific status can be set via argument `status`, e.g. only to `"reviewed"`:

```
tb = loadGeneSummary(organism = NULL, status = "reviewed")
sort(table(tb$Review_status))
```

```
## REVIEWED REFSEQ
##           73610
```

Version of the data:

```
GeneSummary
```

```
## RefSeq gene summaries
##   RefSeq release: 220
##   Source: https://ftp.ncbi.nih.gov/refseq/release/complete/*.rna.gbff.gz
##   Number of organisms: 129
##   Built date:  2023-09-23
```

```
sessionInfo()
```

```
## R version 4.3.1 (2023-06-16)
## Platform: x86_64-pc-linux-gnu (64-bit)
## Running under: Ubuntu 22.04.3 LTS
##
## Matrix products: default
## BLAS:   /home/biocbuild/bbs-3.18-bioc/R/lib/libRblas.so
## LAPACK: /usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.10.0
##
## locale:
##  [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C
##  [3] LC_TIME=en_GB              LC_COLLATE=C
##  [5] LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8
##  [7] LC_PAPER=en_US.UTF-8       LC_NAME=C
##  [9] LC_ADDRESS=C               LC_TELEPHONE=C
## [11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C
##
## time zone: America/New_York
## tzcode source: system (glibc)
##
## attached base packages:
## [1] stats     graphics  grDevices utils     datasets  methods   base
##
## other attached packages:
## [1] GeneSummary_0.99.6
##
## loaded via a namespace (and not attached):
##  [1] digest_0.6.33   R6_2.5.1        fastmap_1.1.1   xfun_0.40
##  [5] cachem_1.0.8    knitr_1.44      htmltools_0.5.6 rmarkdown_2.25
##  [9] cli_3.6.1       sass_0.4.7      jquerylib_0.1.4 compiler_4.3.1
## [13] tools_4.3.1     evaluate_0.21   bslib_0.5.1     yaml_2.3.7
## [17] rlang_1.1.1     jsonlite_1.8.7
```