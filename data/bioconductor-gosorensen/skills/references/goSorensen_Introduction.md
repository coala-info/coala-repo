# An Introduction to goSorensen R-Package

Jordi Ocaña1\* and Pablo Flores2\*\*

1Department of Genetics, Microbiology and Statistics, Statistics Section, University of Barcelona
2Escuela Superior Politécnica de Chimborazo (ESPOCH), Facultad de Ciencias, Carrera de Estadística.

\*jocana@ateneu.ub.edu
\*\*p\_flores@espoch.edu.ec

#### 30 October 2025

#### Abstract

This vignette provides an introduction to [***goSorensen***](https://bioconductor.org/packages/release/bioc/html/goSorensen.html) R-package. The main goal of goSorensen is to implement an inferential statistical method to compare gene lists (to prove equivalence, in the sense of equivalence tests, e.g. Wellek ([2010](#ref-wellek2002testing))) in terms of their biological significance as expressed in the Gene Ontology GO. This method is presented in Flores et al. ([2022](#ref-flores2022equivalence)): “[***An equivalence test between features lists, based on the Sorensen - Dice index and the joint frequencies of GO term enrichment***](https://rdcu.be/cOISz).”

For a given ontology (BP, CC, or MF) and GO level, both enriched and non-enriched GO terms are identified for the compared lists. This enrichment can be summarized in contingency tables for each pair of compared lists. The dissimilarity between gene lists is assessed using a measure based on the Sorensen-Dice index. The fundamental guiding principle is that two gene lists are considered similar if they share a significant proportion of common enriched GO terms.

#### Package

goSorensen 1.12.0

```
library(goSorensen)
```

# 1 PRELIMINARIES.

## 1.1 Theoretical Framework of Reference.

Given two gene lists, \(L\_1\) and \(L\_2\), (the data) and a given set of \(n\) Gene Ontology (GO) terms (the frame of reference for biological significance in these lists), `goSorensen` makes the required computations to answer the following question: Is the dissimilarity between the biological information in both lists negligible? In other words, are both lists functionally equivalent?

We employ the following metric derived from the Sorensen-Dice index to quantify this dissimilarity:

\[\begin{equation\*}
\hat{d\_S} = 1 - \dfrac{2n\_{11}}{2n\_{11} + n\_{10} + n\_{01}} \\
\hat{d\_S} = 1 - \dfrac{\frac{2n\_{11}}{n}}{\frac{2n\_{11}}{n} + \frac{n\_{10}}{n} + \frac{n\_{01}}{n}} \\
\hat{d\_S} = 1 - \dfrac{2\widehat{p}\_{11}}{2\widehat{p}\_{11} + \widehat{p}\_{10} + \widehat{p}\_{01}}
\end{equation\*}\]

where:

* \(n\_{11}\) corresponds to the number (i.e., the absolute frequency) of GO terms enriched in both gene lists. Similarly, \(\hat{p}\_{11}\) corresponds to the relative frequency of joint enrichment.
* \(n\_{10}\) represents the number of GO terms enriched in list \(L\_1\) but not in list \(L\_2\), and \(n\_{01}\) the number of GO terms non enriched in list \(L\_1\) but enriched in \(L\_2\). In other words,\(n\_{10} + n\_{01}\) is the absolute frequency of marginal enrichment, and \(\hat{p}\_{10} + \hat{p}\_{01}\) the proportion of marginal enrichment.
* \(n\_{00}\) corresponds to the absolute frequency (and \(p\_{00}\) to the relative frequency) of GO terms not enriched in either gene list.

The enrichment frequency can be represented in a \(2 \times 2\) contingency table, as follows:

|  | **enriched in \(L\_2\)** | **non-enriched in \(L\_2\)** |  |
| --- | --- | --- | --- |
| **enriched in \(L\_1\)** | \(n\_{11}\) | \(n\_{10}\) | \(n\_{1.}\) |
| **non-enriched in \(L\_1\)** | \(n\_{01}\) | \(n\_{00}\) | \(n\_{0.}\) |
|  | \(n\_{.1}\) | \(n\_{.0}\) | \(n\) |

In Flores et al. ([2022](#ref-flores2022equivalence)) it is shown that \(d\_S\) asymptotically follows a normal distribution. In cases of low joint enrichment, a sampling distribution derived from the bootstrap approach demonstrates a better fit and provides more suitable results.

Consider the following equivalence hypothesis test:

\[\begin{equation\*}
H\_0:d\_S \ge d\_0 \\
H\_1: d\_S < d\_0
\end{equation\*}\]

where \(d\_S\) represents the “true” Sorensen dissimilarity. If this theoretical measure is equivalent to zero, it implies that the compared lists \(L\_1\) and \(L\_2\) share an important proportion of enriched GO terms, which can be interpreted as biological similarity. Equivalence is understood as an equality, except for negligible deviations, which is defined by the irrelevance limit \(d\_0\)

\(d\_0\) is a value that should be fixed in advance, greater than 0 and less than 1. In Flores et al. ([2022](#ref-flores2022equivalence)) it is shown that a not-so-arbitrary irrelevance limit is \(d\_0 = 0.4444\), or more restrictive \(d\_0=0.2857\)

For the moment, the reference set of GO terms can be only all those GO terms in a given level of one GO ontology, either Biological Process (BP), Cellular Component (CC) or Molecular Function (MF).

For more details, see the reference paper.

## 1.2 goSorensen Installation.

`goSorensen` package must be installed with a working R version (>=4.4.0). Installation could take a few minutes on a regular desktop or laptop. Package can be installed from Bioconductor, then it needs to be loaded using `library(goSorensen)`:

```
if (!requireNamespace("goSorensen", quietly = TRUE)) {
    BiocManager::install("goSorensen")
}
library(goSorensen)
```

## 1.3 Data Used in this Vignette.

The dataset used in this vignette, `allOncoGeneLists`, is based on the gene lists compiled at <http://www.bushmanlab.org/links/genelists>, a comprehensive set of gene lists related to cancer. The package `goSorensen` loads this dataset using `data(allOncoGeneLists)`:

```
data("allOncoGeneLists")
```

`allOncoGeneLists` is an object of class list, containing seven character vectors with the ENTREZ gene identifiers of a gene list related to cancer.

```
sapply(allOncoGeneLists, length)
```

```
        atlas      cangenes           cis miscellaneous        sanger
          991           189           613           187           450
   Vogelstein       waldman
          419           426
```

```
# First 15 gene identifiers of gene lists atlas and sanger:
allOncoGeneLists[["atlas"]][1:15]
```

```
 [1] "11186" "27086" "239"   "7764"  "5934"  "246"   "57124" "79663" "23136"
[10] "6281"  "1307"  "1978"  "3732"  "3636"  "7159"
```

```
allOncoGeneLists[["sanger"]][1:15]
```

```
 [1] "25"    "27"    "2181"  "57082" "10962" "51517" "27125" "10142" "207"
[10] "208"   "217"   "238"   "57714" "324"   "23365"
```

## 1.4 Before Using goSorensen.

Before using `goSorensen,` the users must have adequate knowledge of the species they intend to focus their analysis on. The genomic annotation packages available in Bioconductor provide all the essential information about many species.

For the specific case of this vignette and the help pages of the package, given that the analysis will be done in the human species, the `org.Hs.eg.db` package must be previously installed and activated as follows:

```
if (!requireNamespace("org.Hs.eg.db", quietly = TRUE)) {
    BiocManager::install("org.Hs.eg.db")
}
```

```
library(org.Hs.eg.db)
```

Actually, the `org.Hs.eg.db` package is automatically installed as a dependency on `goSorensen`, making its installation unnecessary. However, for any other species, the user must install the corresponding genome annotation for the species to analyse, as indicated in the above code.

In addition, it is necessary to have a vector containing the IDs of the universe of genes associated with the species under study. The genomic annotation package provides an easy way to obtain this universe. The ENTREZ identifiers of the gene universe for humans, necessary for this vignette, are obtained as follows:

```
humanEntrezIDs <- keys(org.Hs.eg.db, keytype = "ENTREZID")
```

In this same way, the identifiers of the gene universe can be obtained for any other species.

Other species available in **Bioconductor** may include:

* `org.Hs.eg.db`: Genome wide annotation for Humans.
* `org.At.tair.db`: Genome wide annotation for Arabidopsis
* `org.Ag.eg.db`: Genome wide annotation for Anopheles
* `org.Bt.eg.db`: Genome wide annotation for Bovine
* `org.Ce.eg.db`: Genome wide annotation for Worm
* `org.Cf.eg.db`: Genome wide annotation for Canine
* `org.Dm.eg.db`: Genome wide annotation for Fly
* `org.EcSakai.eg.db`: Genome wide annotation for E coli strain Sakai
* `org.EcK12.eg.db`: Genome wide annotation for E coli strain K12
* `org.Dr.eg.db`: Genome wide annotation for Zebrafish
* `org.Gg.eg.db`: Genome wide annotation for Chicken
* `org.Mm.eg.db`: Genome wide annotation for Mouse
* `org.Mmu.eg.db`: Genome wide annotation for Rhesus

Due to the extensive research conducted on the human species and the examples documented in `goSorensen` for this species, the installation of the `goSorensen` package automatically includes the annotation package `org.Hs.eg.db` as a dependency.

If you are working with other species, you must install the appropriate package to use the genomic annotation for those species."

# 2 MATRIX OF GO TERMS ENRICHMENT.

## 2.1 For One List.

The first step111 In fact, this is an internal step hidden within the function `buildEnrichTable` described in Section 3. However, providing a brief explanation of this process may help clarify certain details about how enrichment contingency tables are constructed. For users working with the package at a not-so-advanced level, this step can be skipped without affecting their understanding of how to use the core functions of `goSorensen`. is to determine whether the GO terms for a specific ontology and GO level are enriched or not enriched across the different lists to be compared. The `enrichedIn` function assigns `TRUE` when a GO term is enriched in a gene list and `FALSE` when it is not.

For example, for the list `atlas`, which is part of `allOncoGeneLists`, the enrichment of GO terms in the BP ontology at GO level 4 may be obtained as follows:

```
enrichedAtlas <- enrichedIn(allOncoGeneLists[["atlas"]],
           geneUniverse = humanEntrezIDs,
           orgPackg = "org.Hs.eg.db",
           onto = "BP", GOLevel = 4)
enrichedAtlas
```

```
GO:0001649 GO:0030278 GO:0030279 GO:0030282 GO:0045778 GO:0048755 GO:0060688
      TRUE       TRUE       TRUE       TRUE       TRUE       TRUE       TRUE
GO:0061138 GO:0002263 GO:0030168 GO:0050866 GO:0050867 GO:0072537 GO:0001780
      TRUE       TRUE       TRUE       TRUE       TRUE       TRUE       TRUE
GO:0002260 GO:0001818 GO:0002367 GO:0002534 GO:0010573 GO:0032602 GO:0032609
      TRUE       TRUE       TRUE       TRUE       TRUE       TRUE       TRUE
GO:0032612 GO:0032613 GO:0032615 GO:0032623 GO:0032635 GO:0071604 GO:0071706
      TRUE       TRUE       TRUE       TRUE       TRUE       TRUE       TRUE
GO:0002562 GO:0016445 GO:0002433 GO:0002443 GO:0002697 GO:0002698 GO:0002699
      TRUE       TRUE       TRUE       TRUE       TRUE       TRUE       TRUE
GO:0043299 GO:0002218 GO:0034101 GO:0002377 GO:0002700 GO:0002701 GO:0002702
      TRUE       TRUE       TRUE       TRUE       TRUE       TRUE       TRUE
GO:0002200 GO:0048534 GO:0002685 GO:1903706 GO:0002695 GO:0050777 GO:0050858
      TRUE       TRUE       TRUE       TRUE       TRUE       TRUE       TRUE
GO:1903707
      TRUE
 [ reached 'max' / getOption("max.print") -- omitted 340 entries ]
attr(,"nTerms")
[1] 3381
```

The result is a vector containing only the GO terms enriched (`TRUE`) in the `atlas` list in the BP ontology at GO level 4.

The attribute `nTerms` indicates the total number of GO terms, both enriched (`TRUE`) and non-enriched (`FALSE`), by the list `atlas` in the BP ontology at GO level 4. To obtain this vector, the logical argument `onlyEnriched` (which is `TRUE` by default) must be set to `FALSE`, as follows:

```
fullEnrichedAtlas <- enrichedIn(allOncoGeneLists[["atlas"]],
           geneUniverse = humanEntrezIDs,
           orgPackg = "org.Hs.eg.db",
           onto = "BP", GOLevel = 4,
           onlyEnriched = FALSE)
fullEnrichedAtlas
```

```
GO:0036349 GO:0036350 GO:0060256 GO:0060257 GO:1900735 GO:0010590 GO:0030994
     FALSE      FALSE      FALSE      FALSE      FALSE      FALSE      FALSE
GO:0030995 GO:1904652 GO:1905391 GO:2001042 GO:2001043 GO:0001649 GO:0030278
     FALSE      FALSE      FALSE      FALSE      FALSE       TRUE       TRUE
GO:0030279 GO:0030282 GO:0036072 GO:0036075 GO:0036076 GO:0036077 GO:0043931
      TRUE       TRUE      FALSE      FALSE      FALSE      FALSE      FALSE
GO:0043932 GO:0045778 GO:0010223 GO:0048755 GO:0060688 GO:0061137 GO:0061138
     FALSE       TRUE      FALSE       TRUE       TRUE      FALSE       TRUE
GO:0080181 GO:0002263 GO:0002266 GO:0007343 GO:0007407 GO:0014719 GO:0030168
     FALSE       TRUE      FALSE      FALSE      FALSE      FALSE       TRUE
GO:0032980 GO:0042118 GO:0044566 GO:0045321 GO:0050865 GO:0050866 GO:0050867
     FALSE      FALSE      FALSE      FALSE      FALSE       TRUE       TRUE
GO:0061900 GO:0071892 GO:0072537 GO:0001780 GO:0002260 GO:0033023 GO:0035702
     FALSE      FALSE       TRUE       TRUE       TRUE      FALSE      FALSE
GO:0036145
     FALSE
 [ reached 'max' / getOption("max.print") -- omitted 3331 entries ]
attr(,"nTerms")
[1] 3381
```

The full vector (`fullEnrichedAtlas`) is much larger than the vector containing only the enriched GO terms (`enrichedAtlas`), which implies a higher memory usage.

```
# number of GO terms in enrichedAtlas
length(enrichedAtlas)
```

```
[1] 390
```

```
# number of GO terms in fullEnrichedAtlas
length(fullEnrichedAtlas)
```

```
[1] 3381
```

The length of `fullEnrichedAtlas` corresponds to the total number of GO terms in the BP ontology at GO level 4. In contrast, the length of `enrichedAtlas` represents only the number of GO terms that are enriched in the list `atlas`.

## 2.2 For Two or More Lists.

For the seven lists of `allOncoGeneLists`, the matrix containing the GO terms enriched in at least one of the lists to be compared is calculated as follows:

```
enrichedInBP4 <- enrichedIn(allOncoGeneLists,
                               geneUniverse = humanEntrezIDs,
                               orgPackg = "org.Hs.eg.db",
                               onto = "BP", GOLevel = 4)
enrichedInBP4
```

```
           atlas cangenes   cis miscellaneous sanger Vogelstein waldman
GO:0001649  TRUE    FALSE  TRUE          TRUE   TRUE       TRUE    TRUE
GO:0030278  TRUE    FALSE FALSE          TRUE  FALSE       TRUE    TRUE
GO:0030279 FALSE    FALSE FALSE         FALSE  FALSE       TRUE    TRUE
GO:0030282  TRUE    FALSE FALSE         FALSE  FALSE       TRUE    TRUE
GO:0036075  TRUE    FALSE FALSE         FALSE  FALSE      FALSE   FALSE
GO:0045778 FALSE    FALSE FALSE          TRUE  FALSE      FALSE    TRUE
GO:0048755  TRUE    FALSE FALSE         FALSE  FALSE      FALSE   FALSE
GO:0060688  TRUE    FALSE FALSE          TRUE   TRUE       TRUE    TRUE
GO:0061138  TRUE    FALSE  TRUE          TRUE   TRUE       TRUE    TRUE
GO:0002263  TRUE    FALSE  TRUE          TRUE   TRUE       TRUE    TRUE
GO:0030168  TRUE    FALSE FALSE          TRUE   TRUE      FALSE    TRUE
GO:0042118 FALSE    FALSE FALSE         FALSE   TRUE       TRUE    TRUE
GO:0050866  TRUE    FALSE  TRUE          TRUE   TRUE       TRUE    TRUE
GO:0050867  TRUE    FALSE  TRUE          TRUE   TRUE       TRUE    TRUE
 [ reached 'max' / getOption("max.print") -- omitted 475 rows ]
attr(,"nTerms")
[1] 3907
```

To obtain the full matrix with all the GO terms in the BP ontology at GO level 4, we must set the argument `onlyEnriched` (which is `TRUE` by default) to `FALSE`, as follows:

```
fullEnrichedInBP4 <- enrichedIn(allOncoGeneLists,
                               geneUniverse = humanEntrezIDs,
                               orgPackg = "org.Hs.eg.db",
                               onto = "BP", GOLevel = 4,
                               onlyEnriched = FALSE)
fullEnrichedInBP4
```

```
           atlas cangenes   cis miscellaneous sanger Vogelstein waldman
GO:0036349 FALSE    FALSE FALSE         FALSE  FALSE      FALSE   FALSE
GO:0036350 FALSE    FALSE FALSE         FALSE  FALSE      FALSE   FALSE
GO:0060256 FALSE    FALSE FALSE         FALSE  FALSE      FALSE   FALSE
GO:0060257 FALSE    FALSE FALSE         FALSE  FALSE      FALSE   FALSE
GO:1900735 FALSE    FALSE FALSE         FALSE  FALSE      FALSE   FALSE
GO:0010590 FALSE    FALSE FALSE         FALSE  FALSE      FALSE   FALSE
GO:0030994 FALSE    FALSE FALSE         FALSE  FALSE      FALSE   FALSE
GO:0030995 FALSE    FALSE FALSE         FALSE  FALSE      FALSE   FALSE
GO:1904652 FALSE    FALSE FALSE         FALSE  FALSE      FALSE   FALSE
GO:1905391 FALSE    FALSE FALSE         FALSE  FALSE      FALSE   FALSE
GO:2001042 FALSE    FALSE FALSE         FALSE  FALSE      FALSE   FALSE
GO:2001043 FALSE    FALSE FALSE         FALSE  FALSE      FALSE   FALSE
GO:0001649  TRUE    FALSE  TRUE          TRUE   TRUE       TRUE    TRUE
GO:0030278  TRUE    FALSE FALSE          TRUE  FALSE       TRUE    TRUE
 [ reached 'max' / getOption("max.print") -- omitted 3893 rows ]
attr(,"nTerms")
[1] 3907
```

The number of rows in the full matrix (`fullEnrichedInBP4`) is much larger than in the matrix containing only the GO terms enriched in at least one list (`enrichedInBP4`), which implies a more intensive memory usage..

```
# number of GO terms (rows) in enrichedInBP4
nrow(enrichedInBP4)
```

```
[1] 489
```

```
# number of GO terms (rows) in fullEnrichedInBP4
nrow(fullEnrichedInBP4)
```

```
[1] 3907
```

The number of rows in `fullEnrichedInBP4` corresponds to the total number of GO terms in the BP ontology at GO level 4. In contrast, the number of rows in `enrichedInBP4` represents only the GO terms enriched in at least one list from `allOncoGeneLists`, meaning that each row in this matrix contains at least one `TRUE.`

#### NOTE:

To provide users with a quick visualization, the `goSorensen` package includes the objects `enrichedInBP4` and `fullEnrichedInBP4`, which can be accessed using `data(enrichedInBP4)` and `data(fullEnrichedInBP4)`.

Note that gene lists, GO terms, and Bioconductor may change over time. So, consider these objects only as illustrative examples, valid exclusively for the `allOncoGeneLists` at a specific time. The current version of these results was generated with Bioconductor version 3.20. The same comment is applicable to other objects included in `goSorensen` for quick visualization, some of which are also described in this vignette.

The calculations illustrated in this vignette are based on the matrix containing GO terms enriched in at least one list (in our case, `enrichedInBP4`). In the illustrations provided for this vignette, there is no evidence to suggest that this matrix produces results different from the full matrix, which includes all GO terms for a specific ontology and level, including those that are not enriched in any of the lists being compared. This is very beneficial since the computational cost of processing is much lower than it could be.

# 3 ENRICHMENT CONTINGENCY TABLES

## 3.1 For a Specific Ontology and one GO Level.

### 3.1.1 Contingency Tables for Two Lists.

The enrichment contingency tables considered in `goSorensen` are the direct result of obtaining cross-frequency tables between pairs of columns (lists) of the enrichment matrices described in the Section 2 of this vignette. In general, these are internal details that the user of this package does not need to worry about.

Possibly, the only aspect to take into account here is that the main function for this task, `buildEnrichTable`, always calls internally the function `enrichedIn` with the argument `onlyEnriched` put at `TRUE` and, therefore, the obtained enrichment tables are always in their compact version: Only rows with at least one TRUE (in other words, GO terms enriched in at least one gene list).

For the specific case of two gene lists, the function `buildEnrichTable` computes the contingency table by accepting two vectors of the class `character` containing the IDs of the lists to be compared.
For instance, for the BP ontology at GO level 4, the contingency table representing the enrichment of GO terms in the lists `atlas` and `sanger` is obtained as follows:

```
cont_atlas.sanger_BP4 <- buildEnrichTable(allOncoGeneLists$atlas,
                                          allOncoGeneLists$sanger,
                                          listNames = c("atlas", "sanger"),
                                          geneUniverse = humanEntrezIDs,
                                          orgPackg = "org.Hs.eg.db",
                                          onto = "BP",
                                          GOLevel = 4)
cont_atlas.sanger_BP4
```

```
                 Enriched in sanger
Enriched in atlas TRUE FALSE
            TRUE   201   212
            FALSE   29  3465
```

The result is an enrichment contingency table of class `table`. If the argument `storeEnrichedIn` of `buildEnrichTable` was set to `TRUE` (the default value), it has an attribute, `enriched`, with the logical matrix of enriched GO terms in these gene lists, i.e., the output of function `enrichedIn` (always de compact form of these matrices, only rows with almost one `TRUE`).

#### NOTE:

To provide users with a quick visualization, the `goSorensen` package includes the object `cont_atlas.sanger_BP4`, which can be accessed using `data(cont_atlas.sanger_BP4)`.

### 3.1.2 Contingency Tables for Two or More Lists.

Given \(s\) (\(s \geq 2\)) lists to compare, the \(s(s-1)/2\) possible enrichment contingency tables can also be obtained using the function `buildEnrichTable.` Instead of providing two vectors as the main argument, we provide an object of the class `list`, containing at least two elements, each of which contains the identifiers of the different lists to be compared.

For example, for the BP ontology at GO level 4, the \(7(6)/2=21\) contingency tables calculated from the 7 gene lists contained in `allOncoGeneLists` are obtained as follows:

```
cont_all_BP4 <- buildEnrichTable(allOncoGeneLists,
                                 geneUniverse = humanEntrezIDs,
                                 orgPackg = "org.Hs.eg.db",
                                 onto = "BP",
                                 GOLevel = 4)
```

The result is an object of the class `tableList`, which is exclusive from `goSorensen` and contains all the possible enrichment contingency tables between the compared gene lists at GO level 4 for the ontology BP. Since the output is very large, it is not displayed it in this vignette.

If the argument `storeEnrichedIn` of `buildEnrichTable` was set to `TRUE` (its default value), an important attribute of this object is `enriched`, accessible via `attr(cont_all_BP4, "enriched")`, which contains the enrichment matrix obtained using the `enrichedIn` function. For this particular case, `attr(cont_all_BP4, "enriched")` contains exactly the same information as the object `enrichedInBP4` from Section 2.2 of this vignette.

#### NOTE:

To provide users with a quick visualization, the `goSorensen` package includes the object `cont_all_BP4`, which can be accessed using `data(cont_all_BP4)`.

## 3.2 For More than One Ontology and GO Level.

When you want to obtain contingency tables for two or more lists across multiple ontologies and more than one GO level, you can use the function `allBuildEnrichTable.`

For example to obtain the \(7(6)/2=21\) contingency tables calculated from the 7 gene lists in `allOncoGeneLists` for the three ontologies (BP, CC, and MF) and for the GO levels from 3 to 10, you can use the function `allBuildEnrichTable` as follows:

```
allContTabs <- allBuildEnrichTable(allOncoGeneLists,
                                   geneUniverse = humanEntrezIDs,
                                   orgPackg = "org.Hs.eg.db",
                                   ontos = c("BP", "CC", "MF"),
                                   GOLevels = 3:10)
```

The result is an object of the class `allTableList`, which is exclusive from `goSorensen` and contains all possible enrichment contingency tables between the compared gene lists for the BP, CC, and MF ontologies, and for GO levels 3 to 10. Since the output is very large, it is not displayed in this vignette.

The attribute `enriched` is present in each element of this output, meaning that for each ontology and GO level contained in this object, there is an enrichment matrix similar to the one obtained with the function `enrichedIn`. For instance, by running the code `attr(allContTabs$BP$'level 4', 'enriched')`, you can access the enrichment matrix `enrichedInBP4` obtained in Section 2.2 of this vignette.

#### NOTE:

To provide users with a quick visualization, the `goSorensen` package includes the object `allContTabs`, which can be accessed using `data(allContTabs)`.

# 4 EQUIVALENCE TESTS.

## 4.1 For a Specific Ontology and GO level.

### 4.1.1 Equivalence Test for Two Lists.

The function `equivTestSorensen` performs an equivalence test to detect equivalence between gene lists.

For the specific case of two gene lists, you need to provide the function `equivTestSorensen` with two character vectors containing the IDs of the lists to be compared.

For example, using an asymptotic normal distribution, an irrelevance limit \(d\_0=0.4444\) and a significance level \(\alpha=0.05\) (the default parameters), an equivalence test to compare the lists `atlas` and `sanger` for the BP ontology at GO level 4 can be performed as follows:

```
eqTest_atlas.sanger_BP4 <- equivTestSorensen(allOncoGeneLists$atlas,
                                             allOncoGeneLists$sanger,
                                             listNames = c("atlas", "sanger"),
                                             geneUniverse = humanEntrezIDs,
                                             orgPackg = "org.Hs.eg.db",
                                             onto = "BP", GOLevel = 4,
                                             d0 = 0.4444,
                                             conf.level = 0.95)
eqTest_atlas.sanger_BP4
```

```
    Normal asymptotic test for 2x2 contingency tables based on the
    Sorensen-Dice dissimilarity

data:  tab
(d - d0) / se = -3.1, p-value = 9e-04
alternative hypothesis: true equivalence limit d0 is less than 0.4444
95 percent confidence interval:
 0.0000 0.4117
sample estimates:
Sorensen dissimilarity
                0.3748
attr(,"se")
standard error
       0.02241
```

If the enrichment contingency table is available prior to performing the test, such as `cont_atlas.sanger_BP4` determined in Section 3.1.1, the execution time for the calculation is much shorter. To use `equivTestSorensen` with the contingency table as input, proceed as follows:

```
equivTestSorensen(cont_atlas.sanger_BP4,
                  d0 = 0.4444,
                  conf.level = 0.95)
```

```
    Normal asymptotic test for 2x2 contingency tables based on the
    Sorensen-Dice dissimilarity

data:  cont_atlas.sanger_BP4
(d - d0) / se = -3.1, p-value = 9e-04
alternative hypothesis: true equivalence limit d0 is less than 0.4444
95 percent confidence interval:
 0.0000 0.4117
sample estimates:
Sorensen dissimilarity
                0.3748
attr(,"se")
standard error
       0.02241
```

As you can see, both procedures produce the same result, but the last one (whenever possible) is much faster because no time is wasted internally generating the contingency table from the lists of genes and GO terms. Regardless of the procedure, the result is an object of class `equivSDhtest` (a specialization of class `htest`), which is exclusive from `goSorensen`.

If you want to change the calculation parameters of the test, such as using a bootstrap distribution instead of a normal distribution, setting an irrelevance limit of \(d\_0 = 0.2857\) instead of \(d\_0 =0.4444\) (or any other), or changing the significance level to \(\alpha = 0.01\) instead of \(\alpha = 0.05\) (or any other), one option would be to use the `equivTestSorensen` function again with the new parameters. However, this would require performing all the calculations again, leading to additional computational costs, which increase as more tests are performed. Instead, the function `upgrade` allows you to update the test output much more quickly by simply specifying the name of the object where the test results are stored and the new parameters you wish to apply, as shown below:

```
upgrade(eqTest_atlas.sanger_BP4, d0 = 0.2857,
        conf.level = 0.99, boot = TRUE)
```

```
    Bootstrap test for 2x2 contingency tables based on the Sorensen-Dice
    dissimilarity (10000 bootstrap replicates)

data:  tab
(d - d0) / se = 4, p-value = 1
alternative hypothesis: true equivalence limit d0 is less than 0.2857
99 percent confidence interval:
 0.0000 0.4297
sample estimates:
Sorensen dissimilarity
                0.3748
attr(,"se")
standard error
       0.02241
```

### 4.1.2 Equivalence Test for Two or More Lists.

Given \(s\) (\(s \geq 2\)) lists to compare, the \(s(s-1)/2\) possible equivalence tests can also be obtained using the function `equivTestSorensen` Instead of providing two vectors as the main argument, we provide an object of the class `list`, containing at least two elements, each of which contains the identifiers of the different lists to be compared.

For example, for the BP ontology at GO level 4, the \(7(6)/2=21\) possible test calculated from the 7 gene lists contained in `allOncoGeneLists` are obtained as follows:

```
eqTest_all_BP4 <- equivTestSorensen(allOncoGeneLists,
                                    geneUniverse = humanEntrezIDs,
                                    orgPackg = "org.Hs.eg.db",
                                    onto = "BP",
                                    GOLevel = 4,
                                    d0 = 0.4444,
                                    conf.level = 0.95)
```

But remember, it is much simpler if we already have the contingency tables as an object of the class `tableList.` In our case, we have already calculated the contingency tables for all possible pairs of `allOncoGeneLists` for the ontology BP, GO level 4, in Section 3.1.2 and stored them in the object `cont_all_BP4.` Therefore, we can calculate the `eqTest_all_BP4` object more efficiently in the following way:

```
eqTest_all_BP4 <- equivTestSorensen(cont_all_BP4,
                                    d0 = 0.4444,
                                    conf.level = 0.95)
```

Remember that similarly to the comparison of two lists in Section 4.1.1, you can use the function `upgrade` to update the results by changing the parameters of the tests, such as the confidence level, irrelevance limit, and others. For instance, `upgrade(eqTest_atlas.sanger_BP4, d0 = 0.2857` to update the equivalence test using an irrelevance limit \(d\_0=0.2857\).

Since the output contained in `eqTest_all_BP4` is very large, it is not displayed in this vignette. However, `goSorensen` provides accessor functions that allow you to retrieve specific outputs of interest. For example, to obtain a summary of the Sorensen dissimilarities contained in the tests comparing all pairs of lists in the BP ontology at GO level 4, you can use the function `getDissimilarity` and retrieve them as follows:

```
getDissimilarity(eqTest_all_BP4, simplify = FALSE)
```

```
               atlas cangenes    cis miscellaneous sanger Vogelstein waldman
atlas         0.0000        1 0.6964        0.3937 0.3748     0.3474  0.2807
cangenes      1.0000        0 1.0000        1.0000 1.0000     1.0000  1.0000
cis           0.6964        1 0.0000        0.5503 0.5884     0.6216  0.6180
miscellaneous 0.3937        1 0.5503        0.0000 0.3065     0.3390  0.2281
sanger        0.3748        1 0.5884        0.3065 0.0000     0.1162  0.3270
Vogelstein    0.3474        1 0.6216        0.3390 0.1162     0.0000  0.2956
waldman       0.2807        1 0.6180        0.2281 0.3270     0.2956  0.0000
```

Another example of accessor function is the function `getPvalue` to obtain the p-values across the object `eqTest_all_BP4`:

```
getPvalue(eqTest_all_BP4, simplify = FALSE)
```

```
                  atlas cangenes    cis miscellaneous     sanger Vogelstein
atlas         0.000e+00      NaN 1.0000     1.362e-02  9.429e-04  3.028e-06
cangenes            NaN        0    NaN           NaN        NaN        NaN
cis           1.000e+00      NaN 0.0000     9.984e-01  1.000e+00  1.000e+00
miscellaneous 1.362e-02      NaN 0.9984     0.000e+00  1.643e-08  1.582e-05
sanger        9.429e-04      NaN 1.0000     1.643e-08  0.000e+00 1.724e-100
Vogelstein    3.028e-06      NaN 1.0000     1.582e-05 1.724e-100  0.000e+00
waldman       5.349e-18      NaN 1.0000     3.385e-26  3.222e-07  1.057e-11
                waldman
atlas         5.349e-18
cangenes            NaN
cis           1.000e+00
miscellaneous 3.385e-26
sanger        3.222e-07
Vogelstein    1.057e-11
waldman       0.000e+00
```

NaN values occur when the test statistic cannot be calculated due to an indeterminacy, for example when the standard error of the sample Sorensen-Dice dissimilarity cannot be calculated or is null. One of these scenarios occurs when there is no joint enrichment between two lists (i.e., when \(n\_{11}=0\)).

In addition other accesor functions include: `getSE` for the standard error, `getUpper` for the upper bound of the confidence interval and `getTable` for the enrichment contingency tables.

#### NOTE:

To provide users with a quick visualization, the `goSorensen` package includes the object `eqTest_all_BP4`, which can be accessed using `data(eqTest_all_BP4)`.

## 4.2 For More than One Ontology and GO level.

When you want to obtain the outputs of the equivalence tests to compare two or more lists across multiple ontologies and more than one GO level, you can use the function `allEquivTestSorensen`

For example to obtain the \(7(6)/2=21\) equivalence tests calculated from the 7 gene lists in `allOncoGeneLists` for the three ontologies (BP, CC, and MF) and for the GO levels from 3 to 10, you can use the function `allEquivTestSorensen` as follows:

```
allEqTests <- allEquivTestSorensen(allOncoGeneLists,
                                   geneUniverse = humanEntrezIDs,
                                   orgPackg = "org.Hs.eg.db",
                                   ontos = c("BP", "CC", "MF"),
                                   GOLevels = 3:10,
                                   d0 = 0.4444,
                                   conf.level = 0.95)
```

But remember, it is much simpler if we already have the contingency tables as an object of the class `allTableList` In our case, we have already calculated the contingency tables for all possible pairs of `allOncoGeneLists` for the ontologies BP, CC, MF, and for the GO levels 3 to 10, in Section 3.2 and stored them in the object `allContTabs` Therefore, we can calculate the `allEqTests` object more efficiently in the following way:

```
allEqTests <- allEquivTestSorensen(allContTabs,
                                   d0 = 0.4444,
                                   conf.level = 0.95)
```

The result is an object of the class `AllEquivSDhtest`, which is exclusive to `goSorensen.`

In a similar way to what is explained in Section 4.1.1 and 4.1.2, you can use the function `upgrade` to update the results by changing the parameters of the tests, such as the confidence level, irrelevance limit, sample distribution (normal or bootstrap) and others.

You can use also the accessor functions to obtain key test outputs, such as the Sorensen dissimilarities (`getDissimilarity`), p-values (`getPvalue`), enrichment contingency tables (`getTable`), and more.

#### NOTE:

To provide users with a quick visualization, the `goSorensen` package includes the object `allEqTests`, which can be accessed using `data(allEqTests)`.

# References

Flores, Pablo, Miquel Salicrú, Alex Sánchez-Pla, and Jordi Ocaña. 2022. “An Equivalence Test Between Features Lists, Based on the Sorensen–Dice Index and the Joint Frequencies of Go Term Enrichment.” *BMC Bioinformatics* 23 (1): 207.

Wellek, Stefan. 2010. *Testing Statistical Hypotheses of Equivalence and Noninferiority*. CRC Press-Chapman & Hall.

# Appendix