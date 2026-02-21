Code

* Show All Code
* Hide All Code

# R-side access to published microbial signatures from BugSigDB

Ludwig Geistlinger, Jennifer Wokaty, and Levi Waldron

#### 29 December 2025

#### Package

bugsigdbr 1.16.2

# 1 BugSigDB: a comprehensive database of published microbial signatures

[BugSigDB](https://bugsigdb.org) is a manually curated database of microbial
signatures from the published literature of differential abundance studies of
human and other host microbiomes.

BugSigDB provides:

* standardized data on geography, health outcomes, host body sites, and
  experimental, epidemiological, and statistical methods using controlled
  vocabulary,
* results on microbial diversity,
* microbial signatures standardized to the NCBI taxonomy, and
* identification of published signatures where a microbe has been reported.

The [bugsigdbr](https://github.com/waldronlab/bugsigdbr) package implements
convenient access to BugSigDB from within R/Bioconductor.
The goal of the package is to facilitate import of BugSigDB data into
R/Bioconductor, provide utilities for extracting microbe signatures, and enable
export of the extracted signatures to plain text files in standard file formats
such as [GMT](https://software.broadinstitute.org/cancer/software/gsea/wiki/index.php/Data_formats#GMT:_Gene_Matrix_Transposed_file_format_.28.2A.gmt.29).

The [bugsigdbr](https://github.com/waldronlab/bugsigdbr) package is primarily a
data package. For descriptive statistics and comprehensive analysis of BugSigDB
contents, please see the
[BugSigDBStats package](https://github.com/waldronlab/BugSigDBStats)
and [analysis vignette](http://waldronlab.io/BugSigDBStats/articles/BugSigDBStats.html).

We start by loading the package.

```
library(bugsigdbr)
```

## 1.1 Obtaining published microbial signatures from BugSigDB

The function `importBugSigDB` can be used to import the complete collection of
curated signatures from BugSigDB. The dataset is downloaded once and
subsequently cached. Use `cache = FALSE` to force a fresh download of BugSigDB
and overwrite the local copy in your cache.

```
bsdb <- importBugSigDB()
dim(bsdb)
#> [1] 8163   50
colnames(bsdb)
#>  [1] "BSDB ID"                    "Study"
#>  [3] "Study design"               "PMID"
#>  [5] "DOI"                        "URL"
#>  [7] "Authors list"               "Title"
#>  [9] "Journal"                    "Year"
#> [11] "Keywords"                   "Experiment"
#> [13] "Location of subjects"       "Host species"
#> [15] "Body site"                  "UBERON ID"
#> [17] "Condition"                  "EFO ID"
#> [19] "Group 0 name"               "Group 1 name"
#> [21] "Group 1 definition"         "Group 0 sample size"
#> [23] "Group 1 sample size"        "Antibiotics exclusion"
#> [25] "Sequencing type"            "16S variable region"
#> [27] "Sequencing platform"        "Statistical test"
#> [29] "Significance threshold"     "MHT correction"
#> [31] "LDA Score above"            "Matched on"
#> [33] "Confounders controlled for" "Pielou"
#> [35] "Shannon"                    "Chao1"
#> [37] "Simpson"                    "Inverse Simpson"
#> [39] "Richness"                   "Signature page name"
#> [41] "Source"                     "Curated date"
#> [43] "Curator"                    "Revision editor"
#> [45] "Description"                "Abundance in Group 1"
#> [47] "MetaPhlAn taxon names"      "NCBI Taxonomy IDs"
#> [49] "State"                      "Reviewer"
```

Each row of the resulting `data.frame` corresponds to a microbe signature from
differential abundance analysis, i.e. a set of microbes that has been found
with increased or decreased abundance in one sample group when compared to
another sample group (eg. in a case-vs.-control setup).
The curated signatures are richly annotated with additional metadata columns
providing information on study design, antibiotics exclusion criteria,
sample size, and experimental and statistical procedures, among others.

Subsetting the full dataset to certain conditions, body sites, or other
metadata columns of interest can be done along the usual lines for
subsetting `data.frame`s.

For example, the following `subset` command restricts the dataset to signatures
obtained from microbiome studies on obesity, based on fecal samples from
participants in the US.

```
us.obesity.feces <- subset(bsdb,
                           `Location of subjects` == "United States of America" &
                           Condition == "obesity" &
                           `Body site` == "feces")
```

## 1.2 Extracting microbe signatures

Given the full BugSigDB collection (or a subset of interest), the function
`getSignatures` can be used to obtain the microbes annotated to each signature.

Microbes annotated to a signature are returned following the
[NCBI Taxonomy](https://www.ncbi.nlm.nih.gov/taxonomy) nomenclature per
default.

```
sigs <- getSignatures(bsdb)
length(sigs)
#> [1] 7910
sigs[1:3]
#> $`bsdb:11/1/1_Cervical-glandular-intraepithelial-neoplasia:HIV-patients-with-lesion-at-12-months_vs_HIV-pateints-with-normal-tissue-at-6-months_DOWN`
#> [1] "2702"
#>
#> $`bsdb:39/1/1_Body-odor-measurement:youth-underarm-after-exercise_vs_youth-underarm-before_UP`
#> [1] "1282"
#>
#> $`bsdb:39/1/2_Body-odor-measurement:youth-underarm-after-exercise_vs_youth-underarm-before_DOWN`
#> [1] "265"
```

It is also possible obtain signatures based on the full taxonomic
classification in [MetaPhlAn](https://github.com/biobakery/MetaPhlAn)
format …

```
mp.sigs <- getSignatures(bsdb, tax.id.type = "metaphlan")
mp.sigs[1:3]
#> $`bsdb:11/1/1_Cervical-glandular-intraepithelial-neoplasia:HIV-patients-with-lesion-at-12-months_vs_HIV-pateints-with-normal-tissue-at-6-months_DOWN`
#> [1] "d__Bacteria|k__Bacillati|p__Actinomycetota|c__Actinomycetes|o__Bifidobacteriales|f__Bifidobacteriaceae|g__Gardnerella|s__Gardnerella vaginalis"
#>
#> $`bsdb:39/1/1_Body-odor-measurement:youth-underarm-after-exercise_vs_youth-underarm-before_UP`
#> [1] "d__Bacteria|k__Bacillati|p__Bacillota|c__Bacilli|o__Bacillales|f__Staphylococcaceae|g__Staphylococcus|s__Staphylococcus epidermidis"
#>
#> $`bsdb:39/1/2_Body-odor-measurement:youth-underarm-after-exercise_vs_youth-underarm-before_DOWN`
#> [1] "d__Bacteria|k__Pseudomonadati|p__Pseudomonadota|c__Alphaproteobacteria|o__Rhodobacterales|f__Paracoccaceae|g__Paracoccus"
```

… or using the taxonomic name only:

```
tn.sigs <- getSignatures(bsdb, tax.id.type = "taxname")
tn.sigs[1:3]
#> $`bsdb:11/1/1_Cervical-glandular-intraepithelial-neoplasia:HIV-patients-with-lesion-at-12-months_vs_HIV-pateints-with-normal-tissue-at-6-months_DOWN`
#> [1] "Gardnerella vaginalis"
#>
#> $`bsdb:39/1/1_Body-odor-measurement:youth-underarm-after-exercise_vs_youth-underarm-before_UP`
#> [1] "Staphylococcus epidermidis"
#>
#> $`bsdb:39/1/2_Body-odor-measurement:youth-underarm-after-exercise_vs_youth-underarm-before_DOWN`
#> [1] "Paracoccus"
```

As metagenomic profiling with 16S RNA sequencing or whole-metagenome shotgun
sequencing is typically conducted on a certain taxonomic level, it is also
possible to obtain signatures restricted to eg. the genus level …

```
gn.sigs <- getSignatures(bsdb,
                         tax.id.type = "taxname",
                         tax.level = "genus")
gn.sigs[1:3]
#> $`bsdb:39/1/2_Body-odor-measurement:youth-underarm-after-exercise_vs_youth-underarm-before_DOWN`
#> [1] "Paracoccus"
#>
#> $`bsdb:39/2/1_Body-odor-measurement:youth-Neck-before_vs_after-excercise_DOWN`
#> [1] "Acinetobacter"
#>
#> $`bsdb:39/3/1_Body-odor-measurement:Children-underarm-before_vs_after-excercise_DOWN`
#> [1] "Paracoccus"
```

… or the species level:

```
gn.sigs <- getSignatures(bsdb,
                         tax.id.type = "taxname",
                         tax.level = "species")
gn.sigs[1:3]
#> $`bsdb:11/1/1_Cervical-glandular-intraepithelial-neoplasia:HIV-patients-with-lesion-at-12-months_vs_HIV-pateints-with-normal-tissue-at-6-months_DOWN`
#> [1] "Gardnerella vaginalis"
#>
#> $`bsdb:39/1/1_Body-odor-measurement:youth-underarm-after-exercise_vs_youth-underarm-before_UP`
#> [1] "Staphylococcus epidermidis"
#>
#> $`bsdb:39/2/1_Body-odor-measurement:youth-Neck-before_vs_after-excercise_DOWN`
#> [1] "Cutibacterium granulosum" "Acinetobacter schindleri"
```

Note that restricting signatures to microbes given at the genus level, will per
default exclude microbes given at a more specific taxonomic rank such as
species or strain.

For certain applications, it might be desirable to not exclude microbes given
at a more specific taxonomic rank, but rather extract the more general
`tax.level` for microbes given at a more specific taxonomic level.

This can be achieved by setting the argument `exact.tax.level` to `FALSE`,
which will here extract genus level taxon names, for taxa given at the species
or strain level.

```
gn.sigs <- getSignatures(bsdb,
                         tax.id.type = "taxname",
                         tax.level = "genus",
                         exact.tax.level = FALSE)
gn.sigs[1:3]
#> $`bsdb:11/1/1_Cervical-glandular-intraepithelial-neoplasia:HIV-patients-with-lesion-at-12-months_vs_HIV-pateints-with-normal-tissue-at-6-months_DOWN`
#> [1] "Gardnerella"
#>
#> $`bsdb:39/1/1_Body-odor-measurement:youth-underarm-after-exercise_vs_youth-underarm-before_UP`
#> [1] "Staphylococcus"
#>
#> $`bsdb:39/1/2_Body-odor-measurement:youth-underarm-after-exercise_vs_youth-underarm-before_DOWN`
#> [1] "Paracoccus"
```

## 1.3 Writing microbe signatures to file in GMT format

Once signatures have been extracted using a taxonomic identifier type of
choice, the function `writeGMT` allows to write the signatures to plain text
files in [GMT format](https://software.broadinstitute.org/cancer/software/gsea/wiki/index.php/Data_formats#GMT:_Gene_Matrix_Transposed_file_format_.28.2A.gmt.29).

```
writeGMT(sigs, gmt.file = "bugsigdb_signatures.gmt")
```

This is the standard file format for gene sets used by
[MSigDB](https://www.gsea-msigdb.org/gsea/msigdb/) and
[GeneSigDB](https://pubmed.ncbi.nlm.nih.gov/22110038)
and is compatible with most enrichment analysis software.

## 1.4 Displaying BugSigDB signature and taxon pages

Leveraging BugSigDB’s semantic MediaWiki web interface, we can also
programmatically access annotations for individual microbes and microbe
signatures.

The `browseSignature` function can be used to display BugSigDB signature pages
in an interactive session. For programmatic access in a non-interactive
setting, the URL of the signature page is returned.

```
browseSignature(names(sigs)[1])
#> [1] "https://bugsigdb.org/Study_11/Experiment_1/Signature_1"
```

Analogously, the `browseTaxon` function displays BugSigDB taxon pages in an
interactive session, or the URL of the corresponding taxon page otherwise.

```
browseTaxon(sigs[[1]][1])
#> [1] "https://bugsigdb.org/Special:RunQuery/Taxon?Taxon%5BNCBI%5D=2702&_run=1"
```

# 2 Ontology-based queries for experimental factors and body sites

The Semantic MediaWiki curation interface at [bugsigdb.org](https://bugsigdb.org)
enforces metadata annotation of signatures to follow established ontologies such
as the [Experimental Factor Ontology (EFO)](https://www.ebi.ac.uk/efo/) for condition,
and the [Uber-Anatomy Ontology (UBERON)](https://www.ebi.ac.uk/ols/ontologies/uberon)
for body site.

The `getOntology` function can be used to import both ontologies into R.
The result is an object of class `ontology_index` from the
[ontologyIndex](https://cran.r-project.org/web/packages/ontologyIndex/index.html)
package.

```
efo <- getOntology("efo")
#> Loading required namespace: ontologyIndex
#> Using cached version from 2025-12-26 02:51:11
efo
#> Ontology with 83267 terms
#>
#> format-version: 1.2
#> data-version: http://www.ebi.ac.uk/efo/releases/v3.85.0/efo.owl
#> ontology: http://www.ebi.ac.uk/efo/efo.owl
#>
#> Properties:
#>  id: character
#>  name: character
#>  parents: list
#>  children: list
#>  ancestors: list
#>  obsolete: logical
#>  equivalent_to: list
#> Roots:
#>  efo:EFO_0000001 - experimental factor
#>  efo:EFO_0000824 - relationship
#>  RO:0000053 - bearer_of
#>  RO:0000057 - has_participant
#>  RO:0000056 - participates_in
#>  RO:0002233 - has input
#>  RO:0002323 - mereotopologically related to
#>  RO:0002502 - depends on
#>  genomically_related_to - genomically_related_to
#>  located_in - located_in
#>  ... 66 more
```

```
uberon <- getOntology("uberon")
#> Using cached version from 2025-12-26 02:52:06
uberon
#> Ontology with 14741 terms
#>
#> format-version: 1.2
#> data-version: uberon/releases/2025-12-04/uberon-basic.owl
#> ontology: uberon/uberon-basic
#>
#> Properties:
#>  id: character
#>  name: character
#>  parents: list
#>  children: list
#>  ancestors: list
#>  obsolete: logical
#> Roots:
#>  UBERON:0001062 - anatomical entity
#>  UBERON:0000000 - processual entity
#>  develops_from - develops from
#>  action_notes - actions_notes
#>  ambiguous_for_taxon - ambiguous for taxon
#>  appendage_segment_number - appendage segment number
#>  axiom_lost_from_external_ontology - axiom_lost_from_external_ontology
#>  curator_notes - curator note
#>  dc-contributor - contributor
#>  dc-creator - creator
#>  ... 56 more
```

As demonstrated above, subsets of BugSigDB signatures can be obtained for signatures
associated with certain experimental factors or specific body sites of interest.
Higher-level queries can be performed with the `subsetByOntology` function, which
implements subsetting by more general ontology terms. This facilitates grouping
of signatures that semantically belong together.

More specifically, subsetting BugSigDB signatures by an EFO term then involves
subsetting the `Condition` column to the term itself and all descendants of that
term in the EFO ontology and that are present in the `Condition` column. Here,
we demonstrate the usage by subsetting to signatures associated with cancer.

```
sdf <- subsetByOntology(bsdb,
                        column = "Condition",
                        term = "cancer",
                        ontology = efo)
dim(sdf)
#> [1] 283  50
table(sdf[,"Condition"])
#>
#>                                            Bladder carcinoma
#>                                                            2
#>                                                Breast cancer
#>                                                           40
#>                                              Cervical cancer
#>                                                           22
#> Cervical glandular intraepithelial neoplasia,Cervical cancer
#>                                                            2
#>                                      Digestive system cancer
#>                                                            2
#>                                           Endometrial cancer
#>                                                           19
#>                                            Esophageal cancer
#>                                                           10
#>                                               Gastric cancer
#>                                                           91
#>                                      Head and neck carcinoma
#>                                                            7
#>              Human papilloma virus infection,Cervical cancer
#>                                                            2
#>                                                  Lung cancer
#>                                                           26
#>                       Mycobacterium tuberculosis,Lung cancer
#>                                                            1
#>                                        Oral cavity carcinoma
#>                                                           19
#>                                               Ovarian cancer
#>                                                           36
#>                                              Prostate cancer
#>                                                            4
```

And analogously, subsetting by an UBERON term involves subsetting the
`Body site` column to the term itself and all descendants of that term in the
UBERON ontology and that are present in the `Body site` column. For example,
we can use `subsetByOntology` to subset to signatures for which microbiome
samples have been obtained from parts of the digestive system.

```
sdf <- subsetByOntology(bsdb,
                        column = "Body site",
                        term = "digestive system",
                        ontology = uberon)
dim(sdf)
#> [1] 1185   50
table(sdf[,"Body site"])
#>
#>                                Actinopterygian pyloric caecum
#>                                                             2
#>                                                Bronchus,Mouth
#>                                                             2
#>                                                 Buccal mucosa
#>                                                            16
#>                                                        Caecum
#>                                                            41
#>                                             Cardia of stomach
#>                                                             2
#>                                             Cavity of pharynx
#>                                                             2
#>                                                  Cecum mucosa
#>                                                            31
#>     Cecum mucosa,Colonic mucosa,Mucosa of rectum,Ileal mucosa
#>                                                             5
#>                                                         Colon
#>                                                            70
#>                                             Colon,Blood serum
#>                                                             1
#>                                                   Colon,Feces
#>                                                             2
#>                                                Colonic mucosa
#>                                                             8
#>                                             Colorectal mucosa
#>                                                            18
#>                                       Colorectal mucosa,Feces
#>                                                             2
#>                                                    Colorectum
#>                                                             3
#>                                                 Dental plaque
#>                                                            17
#>                     Dental plaque,Internal cheek pouch,Saliva
#>                                                             2
#>                                               Digestive tract
#>                                                             8
#>                                               Duodenal mucosa
#>                                                             6
#>                                                      Duodenum
#>                                                            18
#>                                            Duodenum,Bile duct
#>                                                             1
#>                                      Epithelium of oropharynx
#>                                                             3
#>                                                     Esophagus
#>                                                            40
#>                                                   Feces,Colon
#>                                                             4
#>                                          Feces,Colonic mucosa
#>                                                             1
#>                                       Feces,Colorectal mucosa
#>                                                             2
#>                                                Feces,Duodenum
#>                                                             6
#>                              Feces,Mucosa of descending colon
#>                                                             5
#>                               Feces,Mucosa of small intestine
#>                                                             4
#>                                             Feces,Oral cavity
#>                                                             9
#>                    Feces,Stomach,Caecum,Small intestine,Colon
#>                                                             2
#>                                                   Gastric pit
#>                                                             4
#>                                                       Gingiva
#>                                                             5
#>                                               Gingival groove
#>                                                             9
#>                                                       Hindgut
#>                                                             4
#>                                                   Hypopharynx
#>                                                             1
#>                                                         Ileum
#>                                                            23
#>                                                   Ileum,Colon
#>                                                             2
#>                                                   Ileum,Feces
#>                                                             2
#>                                            Ileum,Feces,Rectum
#>                                                             2
#>                                                 Ileum,Jejunum
#>                                                             2
#>                                                  Ileum,Rectum
#>                                                             2
#>                                          Internal cheek pouch
#>                                                            21
#>                                             Intestinal mucosa
#>                                                            12
#>                                                     Intestine
#>                                                            59
#>                                                       Jejunum
#>                                                            29
#>                                       Lower lip,Buccal mucosa
#>                                                             8
#>                                             Lumen of duodenum
#>                                                             2
#>                                                        Midgut
#>                                                             2
#>                                                  Midgut,Ovary
#>                                                             2
#>                                 Midgut,Saliva-secreting gland
#>                                                             2
#>                           Midgut,Saliva-secreting gland,Ovary
#>                                                             6
#>                                                         Mouth
#>                                                           111
#>                                                  Mouth mucosa
#>                                                             4
#>                                     Mucosa of ascending colon
#>                                                             2
#>                                     Mucosa of body of stomach
#>                                                             1
#>                                         Mucosa of oral region
#>                                                             2
#> Mucosa of oral region,Vagina,Skin of forehead,Skin of forearm
#>                                                             1
#>                                          Mucosa of oropharynx
#>                                                             4
#>                                              Mucosa of rectum
#>                                                             5
#>                                       Mucosa of sigmoid colon
#>                                                             3
#>                                     Mucosa of small intestine
#>                                                             2
#>                                             Mucosa of stomach
#>                                                             3
#>                                          Nasopharyngeal gland
#>                                                             2
#>                                   Nasopharyngeal gland,Saliva
#>                                                             6
#>                                                   Nasopharynx
#>                                                            82
#>                                              Nasopharynx,Lung
#>                                                             3
#>                                        Nasopharynx,Oropharynx
#>                                                             8
#>                                            Nasopharynx,Throat
#>                                                            12
#>                                                    Nose,Mouth
#>                                                             2
#>                                                   Oral cavity
#>                                                            60
#>                                         Oral cavity,Esophagus
#>                                                             2
#>                                             Oral cavity,Feces
#>                                                             2
#>                                                  Oral opening
#>                                                             6
#>                                    Oropharyngeal gland,Saliva
#>                                                             6
#>                                                    Oropharynx
#>                                                            32
#>                                                       Pharynx
#>                                                             8
#>                                  Posterior wall of oropharynx
#>                                                             6
#>                                         Proventriculus,Cloaca
#>                                                             9
#>                                                  Rectal lumen
#>                                                             2
#>                                                        Rectum
#>                                                            31
#>                                                         Rumen
#>                                                            13
#>                  Saliva,Esophagus,Gastric juice,Stomach,Feces
#>                                                             3
#>                  Saliva,Esophagus,Stomach,Gastric juice,Feces
#>                                                             3
#>                              Saliva,Subgingival dental plaque
#>                                                             3
#>                            Saliva,Supragingival dental plaque
#>                                                             6
#>                                  Saliva-secreting gland,Ovary
#>                                                             2
#>                                                 Sigmoid colon
#>                                                             2
#>                                               Small intestine
#>                                                            19
#>                                                  Sputum,Mouth
#>                                                             2
#>                                                       Stomach
#>                                                            48
#>                                     Subgingival dental plaque
#>                                                            85
#>                               Subgingival dental plaque,Feces
#>                                                             3
#>                                   Supragingival dental plaque
#>                                                             8
#>                            Supragingival dental plaque,Saliva
#>                                                             2
#>                                                        Tongue
#>                                                            33
#>                                               Tonsillar fossa
#>                                                             2
#>                                       Wall of small intestine
#>                                                             2
```

# 3 Session info

```
sessionInfo()
#> R version 4.5.2 (2025-10-31)
#> Platform: x86_64-pc-linux-gnu
#> Running under: Ubuntu 24.04.3 LTS
#>
#> Matrix products: default
#> BLAS:   /home/biocbuild/bbs-3.22-bioc/R/lib/libRblas.so
#> LAPACK: /usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.12.0  LAPACK version 3.12.0
#>
#> locale:
#>  [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C
#>  [3] LC_TIME=en_GB              LC_COLLATE=C
#>  [5] LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8
#>  [7] LC_PAPER=en_US.UTF-8       LC_NAME=C
#>  [9] LC_ADDRESS=C               LC_TELEPHONE=C
#> [11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C
#>
#> time zone: America/New_York
#> tzcode source: system (glibc)
#>
#> attached base packages:
#> [1] stats     graphics  grDevices utils     datasets  methods   base
#>
#> other attached packages:
#> [1] bugsigdbr_1.16.2 BiocStyle_2.38.0
#>
#> loaded via a namespace (and not attached):
#>  [1] bit_4.6.0           jsonlite_2.0.0      dplyr_1.1.4
#>  [4] compiler_4.5.2      BiocManager_1.30.27 filelock_1.0.3
#>  [7] tidyselect_1.2.1    blob_1.2.4          jquerylib_0.1.4
#> [10] yaml_2.3.12         fastmap_1.2.0       R6_2.6.1
#> [13] generics_0.1.4      curl_7.0.0          httr2_1.2.2
#> [16] knitr_1.51          ontologyIndex_2.12  tibble_3.3.0
#> [19] bookdown_0.46       DBI_1.2.3           bslib_0.9.0
#> [22] pillar_1.11.1       rlang_1.1.6         cachem_1.1.0
#> [25] xfun_0.55           sass_0.4.10         bit64_4.6.0-1
#> [28] otel_0.2.0          RSQLite_2.4.5       memoise_2.0.1
#> [31] cli_3.6.5           withr_3.0.2         magrittr_2.0.4
#> [34] digest_0.6.39       dbplyr_2.5.1        rappdirs_0.3.3
#> [37] lifecycle_1.0.4     BiocFileCache_3.0.0 vctrs_0.6.5
#> [40] evaluate_1.0.5      glue_1.8.0          purrr_1.2.0
#> [43] rmarkdown_2.30      tools_4.5.2         pkgconfig_2.0.3
#> [46] htmltools_0.5.9
```