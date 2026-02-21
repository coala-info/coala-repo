# Working with the Irrelevance-threshold Matrix of Dissimilarities.

Pablo Flores1\* and Jordi Ocaña2\*\*

1Escuela Superior Politécnica de Chimborazo (ESPOCH), Facultad de Ciencias, Carrera de Estadística.
2Department of Genetics, Microbiology and Statistics, Statistics Section, University of Barcelona

\*p\_flores@espoch.edu.ec
\*\*jocana@ateneu.ub.edu

#### 30 October 2025

#### Abstract

This vignette illustrates the calculation, visualisation, and interpretation of a dissimilarity matrix between gene lists. It is based on the concept of “irrelevance threshold”, the equivalence limit that would declare them equivalent. This matrix is derived from the statistical method implemented in `goSorensen` to test for equivalence between two or more gene lists, based on the Sorensen–Dice dissimilarity and joint GO term enrichment frequencies.

We begin with a brief introduction to the meaning of the matrix, followed by an explanation of the process for calculating it. Then, we visualize the dissimilarity matrix using interpretable statistical graphics, such as a dendrogram and the biplot generated from a multidimensional scaling (MDS) analysis. Characterizing the dimensions of the MDS biplot allows us to identify the biological functions (GO terms) associated with the observed dissimilarities.

#### Package

goSorensen 1.12.0

```
library(goSorensen)
```

# 1 PRELIMINARIES.

## 1.1 Theoretical Framework of Reference

\[\begin{equation}
\begin{aligned}
& \begin{matrix}
\hspace{0.6cm} L\_1 & L\_2 & \hspace{0.1cm} L\_3 & \hspace{0.1cm} \ldots \hspace{0.1cm} & L\_{s-1}
\end{matrix} \\
\mathfrak{D} = \begin{matrix}
L\_2 \\
L\_3 \\
L\_4 \\
\vdots \\
L\_s
\end{matrix} & \begin{pmatrix}
\mathfrak{d}\_{21} & & & & \\
\mathfrak{d}\_{31} & \mathfrak{d}\_{32} & & & \\
\mathfrak{d}\_{41} & \mathfrak{d}\_{42} & \mathfrak{d}\_{43} & & \\
\vdots & \vdots & \vdots & & \\
\mathfrak{d}\_{s1} & \mathfrak{d}\_{s2} & \mathfrak{d}\_{s3} & \ldots & \mathfrak{d}\_{s(s-1)} \\
\end{pmatrix}
\end{aligned}
\label{it-diss}
\end{equation}\]

Given \(s\) gene lists, \(L\_1, L\_2, \dots, L\_s\), each element \(\mathfrak{d}\_{ij}\) of the matrix \(\mathfrak{D}\) tries to quantify how different or distant are the lists \(L\_i\) and \(L\_j\) in the following terms: “A higher equivalence threshold than this would cause these lists to be declared equivalent”. These dissimilarities are based on the irrelevance (equivalence) threshold that would make them statistically significant, in the sense of the equivalence tests introduced in Flores et al. ([2022](#ref-flores2022equivalence)): “[***An equivalence test between features lists, based on the Sorensen - Dice index and the joint frequencies of GO term enrichment***](https://rdcu.be/cOISz).” This concept was introduced in an attempt to give this dissimilarity a more inferential meaning, not merely descriptive as could be the Sorensen–Dice dissimilarity used directly.

But analyzing simultaneously \(s\) gene lists poses a multiple testing problem, so the algorithm to obtain the matrix should be expressed as:

* Step 1. Establish \(h = s(s-1) / 2\) equivalence hypothesis tests. Each test \(ET\_I\) (with \(I = 1, \ldots, h\)) compares the pair of lists \(L\_{i}, L\_{j}\) (with \(i, j = 1, 2, \ldots, s, i \neq j\)). Equivalence is declared when the null hypothesis of non-equivalence is rejected.
* Step 2. According to a criterion of type I error control in multiple testing, let \(\mathfrak{d}\_h\) be the smallest irrelevance limit for which all \(h\) null hypothesis are rejected. The default adjusting criterion in `goSorensen` is the Holm’s method (“holm” option in the R function `p.adjust`). So, \(\mathfrak{d}\_h\) is computed as:
  \[\mathfrak{d}\_h = \text{min} \left(\mathfrak{d}: P\_{(I)}(\mathfrak{d}) \leq \frac{\alpha}{h+1-I}; \hspace{0.5cm} I=1, 2, \ldots,h \right).\]
* Step 3. Use \(\mathfrak{d}\_h\) as the irrelevance limit dissimilarity between the lists \(L\_i, L\_j\) corresponding to the last position in the vector of ordered p-values \(P\_{(1)}(\mathfrak{d}\_{h}) \le \ldots \le P\_{(h)}(\mathfrak{d}\_{h})\), i.e. \(\mathfrak{d}\_{ij} = \mathfrak{d}\_{h}.\)
* Step 4. Set \(h = h - 1\), excluding the comparison between the lists \(L\_i, L\_j\) from Step \(3\), and go back to Step \(2\) until \(h=0\).

## 1.2 Data Used in this Vignette.

The dataset used in this vignette, `allOncoGeneLists`, is derived from gene lists compiled at <http://www.bushmanlab.org/links/genelists>, which contains an extensive collection of gene lists associated with cancer. The `goSorensen` package loads this dataset using the command `data(allOncoGeneLists)`:

```
data("allOncoGeneLists")
```

`allOncoGeneLists` is an object of class list containing 7 elements. Each element is a character vector that holds the ENTREZ identifiers for the respective gene lists:

```
# name and length of the gene lists:
sapply(allOncoGeneLists, length)
```

```
        atlas      cangenes           cis miscellaneous        sanger
          991           189           613           187           450
   Vogelstein       waldman
          419           426
```

# 2 Obtaining the Irrelevance-threshold Matrix of Dissimilarities.

## 2.1 For a Specific Ontology and one GO level.

One method to compute the dissimilarity matrix \(\mathfrak{D}\) for a given ontology and level (e.g., ontology BP, level 4) is to directly input the gene lists into the `sorenThreshold` function:

```
# Previously load the genomic annotation package for the studied specie:
library(org.Hs.eg.db)
humanEntrezIDs <- keys(org.Hs.eg.db, keytype = "ENTREZID")

# Computing the irrelevance-threshold matrix of dissimilarities
dissMatrx_BP4 <- sorenThreshold(allOncoGeneLists,
                            geneUniverse = humanEntrezIDs,
                            orgPackg = "org.Hs.eg.db",
                            onto = "BP",
                            GOLevel = 4,
                            trace = FALSE)
dissMatrx_BP4
```

```
               atlas    cis miscellaneous sanger Vogelstein
cis           0.7413
miscellaneous 0.5496 0.6096
sanger        0.4955 0.6464        0.3476
Vogelstein    0.4027 0.6808        0.4467 0.2547
waldman       0.3123 0.6707        0.2820 0.3659     0.3322
```

Alternatively, we can previously compute all the enrichment contingency tables for all 21 possible pairs of lists from `allOncoGeneLists` using the function `buildEnrichTable.` The result is an object of class `tableList`, from which we can obtain the dissimilarity matrix as follows:

```
# Previously compute the enrichment contingency tables:
cont_all_BP4 <- buildEnrichTable(allOncoGeneLists,
                                 geneUniverse = humanEntrezIDs,
                                 orgPackg = "org.Hs.eg.db",
                                 onto = "BP",
                                 GOLevel = 4)
```

```
# Computing the irrelevance-threshold matrix of dissimilarities from the
# enrichment contingency table "cont_all_BP4":
dissMatrx_BP4 <- sorenThreshold(cont_all_BP4,
                                trace = FALSE)
dissMatrx_BP4
```

```
               atlas    cis miscellaneous sanger Vogelstein
cis           0.7413
miscellaneous 0.5496 0.6096
sanger        0.4955 0.6464        0.3476
Vogelstein    0.4027 0.6808        0.4467 0.2547
waldman       0.3123 0.6707        0.2820 0.3659     0.3322
```

Both alternatives yield the same results; however, the latter approach (whenever possible, if all contingency tables are already available) is much faster, as it eliminates the internal time required to generate the contingency tables since they are provided as arguments to the function `sorenThreshold`.

The dissimilarity matrix `dissMatrx_BP4` is obtained using equivalence tests based on the normal asymptotic distribution. If the user prefers the tests to be based on the bootstrap distribution, they should set the argument `boot = TRUE` (the default is `FALSE`), as shown below:

```
boot_dissMatrx_BP4 <- sorenThreshold(allOncoGeneLists,
                            geneUniverse = humanEntrezIDs,
                            orgPackg = "org.Hs.eg.db",
                            onto = "BP",
                            GOLevel = 4,
                            boot = TRUE, # use bootstrap distribution
                            trace = FALSE)
boot_dissMatrx_BP4
```

```
               atlas    cis miscellaneous sanger Vogelstein
cis           0.7401
miscellaneous 0.4463 0.6091
sanger        0.4136 0.6465        0.3498
Vogelstein    0.3836 0.6799        0.3913 0.2572
waldman       0.3153 0.6709        0.2848 0.4951     0.5491
```

Or, it is faster if we already have the enrichment contingency tables:

```
boot_dissMatrx_BP4 <- sorenThreshold(cont_all_BP4,
                                     boot = TRUE,
                                     trace = FALSE)
boot_dissMatrx_BP4
```

```
               atlas    cis miscellaneous sanger Vogelstein
cis           0.7401
miscellaneous 0.4463 0.6091
sanger        0.4136 0.6465        0.3498
Vogelstein    0.3836 0.6799        0.3913 0.2572
waldman       0.3153 0.6709        0.2848 0.4951     0.5491
```

An important and useful attribute of this dissimilarity matrix (whether calculated using the normal or bootstrap distribution) is `attr(, "all2x2Tables")`, which contains the enrichment contingency tables for all possible pairs of lists among the set of gene lists being compared. These contingency tables, in turn, include the matrix of GO terms enrichment in its attribute `attr(, "enriched")`.

For more details about the matrix of GO terms enrichment, the enrichment contingency tables and the equivalence tests (including computation, outputs, attributes, etc.), refer to the vignette [An Introduction to the goSorensen R Package](goSorensen_Introduction.html).

#### NOTE:

To provide users with a quick visualization, the `goSorensen` package includes the objects `cont_all_BP4` and `dismatBP4`, which can be accessed using `data(cont_all_BP4)` and `data(dismatBP4)`.

Note that gene lists, GO terms, and Bioconductor may change over time. So, consider these objects only as illustrative examples, valid exclusively for the dataset `allOncoGeneLists` at a specific time. The current version of these results was generated with Bioconductor version 3.20. The same comment is applicable to other objects included in `goSorensen` for quick visualization, some of which are also described in this vignette.

## 2.2 For More than One Ontology and GO Level.

To calculate dissimilarity matrices for multiple ontologies and GO levels, we use the `allSorenThreshold` function. The first option is to provide the lists of genes to compare as the main input, as shown below:

```
# For example, for GO levels 3 to 10 and for the ontologies BP, CC and MF:
allDissMatrx <- allSorenThreshold(allOncoGeneLists,
                                  geneUniverse = humanEntrezIDs,
                                  orgPackg = "org.Hs.eg.db",
                                  ontos = c("BP", "CC", "MF"),
                                  GOLevels = 3:10,
                                  trace = FALSE)
```

Another option is previously computing all the enrichment contingency tables from `allOncoGeneLists` using the function `allBuildEnrichTable.` The result is an object of class `allTableList`, from which we can obtain the dissimilarity matrix as follows:

```
# Previously compute the enrichment contingency tables:
allContTabs <- allBuildEnrichTable(allOncoGeneLists,
                                   geneUniverse = humanEntrezIDs,
                                   orgPackg = "org.Hs.eg.db",
                                   ontos = c("BP", "CC", "MF"),
                                   GOLevels = 3:10)

# Computing the irrelevance-threshold matrix of dissimilarities from the
# enrichment contingency tables "allContTabs":
allDissMatrx <- allSorenThreshold(allContTabs,
                                  trace = FALSE)
```

Remember that, by default, these matrices are obtained from equivalence tests based on the normal distribution. If the user prefers to use the bootstrap distribution instead, they must set the argument `boot = TRUE` inside the `allSorenThreshold` function.

#### NOTE:

Given the large number of outcomes produced in `allDissMatrx`, displaying all of them is not feasible. However, for a quick visualization, the `goSorensen` package includes the object `allDissMatrx`, which can be accessed using `data(allDissMatrx)`.

# 3 Representing a Dissimilarity Matrix in Statistical Graphs.

## 3.1 Dendrogram.

Below, we present a dendrogram of the dissimilarity matrix for the specific case of the `allOncoGeneLists` dataset, for the BP ontology and GO Level 4, which was computed in Section 2.1 of this vignette (object `dissMatrx_BP4`):

```
clust.threshold <- hclustThreshold(dissMatrx_BP4)
plot(clust.threshold)
```

![](data:image/png;base64...)

Since the dissimilarities used to form the biplot are based on an inferential measure of significant equivalence, we can deduce that the closer two or more lists are (forming groups), the stronger the evidence suggesting that these lists are functionally similar, and the opposite for distant lists.

For example, in this particular dendrogram, two groups appear to be formed, as two pairs of lists are very close to each other. The first group consists of sanger and vogelstein, while the second group includes miscellaneous and waldman. So, it can then be inferred that the pairs of lists within each group provide stronger evidence of equivalence.

## 3.2 MDS-Biplot.

Multidimensional Scaling (MDS) transforms the initial dissimilarity matrix into Euclidean distances, preserving as much of the original variability as possible. In this case, we compute the first two dimensions, which capture the highest proportion of the original variability. Like in the dendrogram example, we use the dissimilarity matrix `dissMatrx_BP4` computed in Section 2.1 of this vignette:

```
# multidimensional scaling analysis:
mds <- as.data.frame(cmdscale(dissMatrx_BP4, k = 2))
```

Below we plot the MDS-Biplot:

```
library(ggplot2)
library(ggrepel)
graph <- ggplot() +
 geom_point(aes(mds[,1], mds[,2]), color = "blue", size = 3) +
 geom_text_repel(aes(mds[,1], mds[,2], label = attr(dissMatrx_BP4, "Labels")),
                 color = "black", size = 3) +
 xlab("Dim 1") +
 ylab("Dim 2") +
 theme_light()
graph
```

![](data:image/png;base64...)

The biplot suggests that the closest lists (clusters) are Waldman-Vogelstein and Sanger-Miscellaneous; therefore, there is stronger evidence for equivalence among these lists.

Characterizing the axes of the biplot on which these groups are formed is of great interest, as it can help determine the biological functions associated with the formation of these groups. Specifically, it allows us to identify the GO terms involved in the evidence supporting the biological similarity between the compared gene lists. In the following section, we propose a 5-step procedure to characterize the axes of the biplot and identify the GO terms associated with the formation of these groups. This is a very preliminary version of a work in progress.

# 4 Characterizing MDS-Biplot Dimensions.

In this vignette, we will apply the 5-step procedure to Dimension 1. However, the technique would be the same if we were to apply it to Dimension 2 or any other dimension.

## 4.1 Step 1. Split the biplot axis:

Split the axis (in this case, Dimension 1) in three parts to identify the lists located at the extremes.
For example, we could allocate 20% to each extreme, leaving 60% in the middle, as follows:

```
# Split the axis 20% to the left, 60% to the middle and 20% to the right:
prop <- c(0.2, 0.6, 0.2)

# Sort according  dimension 1:
sorted <- mds[order(mds[, 1]), ]

# Determine the range for dimension 1.
range <- sorted[, 1][c(1, nrow(mds))]

# Find the cut-points to split the axis:
cutpoints <- (cumsum(prop)[1:2] * diff(range)) + range[1]

# Identify lists to the left:
lleft <- rownames(sorted[sorted[, 1] < cutpoints[1], ])
lleft
```

```
[1] "cis"
```

```
# Identify lists to the right
lright <- rownames(sorted[sorted[, 1] > cutpoints[2], ])
lright
```

```
[1] "waldman"    "Vogelstein" "atlas"
```

Visualizing in the Biplot:

```
graph +
  geom_vline(xintercept = cutpoints, color = "red",
             linetype = "dashed", linewidth = 0.75)
```

![](data:image/png;base64...)

The basic idea is that if the enrichment of a GO term differs between these two groups of lists at the extremes, we can deduce that this GO term discriminates the groups, thus explaining their formation.

## 4.2 Step 2. Obtain the matrix of GO terms enrichment:

Obtain the matrix of GO terms enrichment for the lists located at the extremes detected in Step 1. Remember, this matrix is stored as an attribute of the enrichment contingency tables. Therefore:

```
# enrichment contingency tables:
contTablesBP4 <- attr(dissMatrx_BP4, "all2x2Tables")

# matrix of GO term enrichment for the lists located at the extreme left
tableleft <- attr(contTablesBP4, "enriched")[, lleft, drop = FALSE]
tableleft
```

```
             cis
GO:0001649  TRUE
GO:0030278 FALSE
GO:0030279 FALSE
GO:0030282 FALSE
GO:0036075 FALSE
GO:0045778 FALSE
GO:0048755 FALSE
GO:0060688 FALSE
GO:0061138  TRUE
GO:0002263  TRUE
GO:0030168 FALSE
GO:0042118 FALSE
GO:0050866  TRUE
GO:0050867  TRUE
GO:0061900 FALSE
GO:0072537 FALSE
 [ reached 'max' / getOption("max.print") -- omitted 473 rows ]
```

```
# matrix of GO term enrichment for the lists located at the extreme right
tableright <- attr(contTablesBP4, "enriched")[, lright, drop = FALSE]
tableright
```

```
           waldman Vogelstein atlas
GO:0001649    TRUE       TRUE  TRUE
GO:0030278    TRUE       TRUE  TRUE
GO:0030279    TRUE       TRUE FALSE
GO:0030282    TRUE       TRUE  TRUE
GO:0036075   FALSE      FALSE  TRUE
GO:0045778    TRUE      FALSE FALSE
GO:0048755   FALSE      FALSE  TRUE
GO:0060688    TRUE       TRUE  TRUE
GO:0061138    TRUE       TRUE  TRUE
GO:0002263    TRUE       TRUE  TRUE
GO:0030168    TRUE      FALSE  TRUE
GO:0042118    TRUE       TRUE FALSE
GO:0050866    TRUE       TRUE  TRUE
GO:0050867    TRUE       TRUE  TRUE
GO:0061900   FALSE      FALSE  TRUE
GO:0072537   FALSE      FALSE  TRUE
 [ reached 'max' / getOption("max.print") -- omitted 473 rows ]
```

Actually, the contingency tables saved in the objects `contTablesBP4` and `cont_all_BP4` (from Section 2.1) are exactly the same.

## 4.3 Step 3. Compute means and variances:

Compute the means and variances for each of the GO terms detected in each extreme group. In other words, calculate the means and variances by rows of the GO term enrichment matrix for the lists at the extremes:

```
# function to compute mean and standard deviation:
mean_sd <- function(x){
  c("mean" = mean(x), "sd" = ifelse(length(x) == 1, 0, sd(x)))
}

# mean and sd of the lists to the extreme left:
lmnsd <- apply(tableleft, 1, mean_sd)

# mean and sd of the lists to the extreme right:
rmnsd <- apply(tableright, 1, mean_sd)
```

## 4.4 Step 4. Establish a statistic:

Establish a statistic to assess the degree of enrichment disparity between extreme groups for each GO term. This measure should consider that a GO term discriminates a dimension if:

1. the lists show opposing patterns of enrichment in the GO term, indicated by a large difference between \(| \_L\overline{X}\_{GO\_j} - \_R \overline{X}\_{GO\_j}|\) (\(L\) represents Left and \(R\) Rigth), and
2. the behavior of the lists remains stable at each extreme, indicated by a small amount of \(\_LS^2\_{GO\_j} + \_RS^2\_{GO\_j}\).

Considering these specific details, the following statistic, is suggested:

\[st\_j = \dfrac{| \_L\overline{X}\_{GO\_j} - \_R \overline{X}\_{GO\_j}|}{\sqrt{\dfrac{\_LS^2\_{GO\_j}}{l} + \dfrac{\_RS^2\_{GO\_j}}{r} + \epsilon }}\]
with \(l\) the number of lists to the extreme left and \(r\) the number of lists to the extreme right. Using \(\epsilon= 0.00000001\) the statistic is computed as follows:

```
nl <- ncol(tableleft)
nr <- ncol(tableright)
t_stat <- abs(lmnsd[1, ] - rmnsd[1, ]) /
  sqrt((((lmnsd[2, ] / nl) + (rmnsd[2, ] / nr))) + 0.00000001)
```

## 4.5 Step 5. Select the GO terms with the highest statistic:

GO terms with the highest statistic are those with a value closest to \(\frac{1}{\sqrt{\epsilon}}\). These GO terms are the main contributors to the formation of clusters in the analyzed dimension. Therefore, they are strongly related to the equivalence between the compared gene lists. They are detected as follows:

```
result <- t_stat[t_stat == max(t_stat)]
result
```

```
GO:0030278 GO:0030282 GO:0060688 GO:0002367 GO:0002562 GO:0016445 GO:0002443
     10000      10000      10000      10000      10000      10000      10000
GO:0034101 GO:0002377 GO:0002700 GO:0002200 GO:0007281 GO:0007548 GO:0045137
     10000      10000      10000      10000      10000      10000      10000
GO:0048608 GO:0060512 GO:0060736 GO:0060740 GO:0060742 GO:0001666 GO:0006979
     10000      10000      10000      10000      10000      10000      10000
GO:0009408 GO:0045786 GO:0051321 GO:0009755 GO:0008366 GO:0009791 GO:0046660
     10000      10000      10000      10000      10000      10000      10000
GO:0046661 GO:0009880 GO:0007611 GO:0010463 GO:0033002 GO:0072111 GO:0009895
     10000      10000      10000      10000      10000      10000      10000
GO:0009612 GO:0009266 GO:0009314 GO:0070482 GO:0071214 GO:0003151 GO:0003179
     10000      10000      10000      10000      10000      10000      10000
GO:0003206 GO:0031069 GO:0060323 GO:0060411 GO:0060560 GO:0072028 GO:0045913
     10000      10000      10000      10000      10000      10000      10000
GO:0001558
     10000
 [ reached 'max' / getOption("max.print") -- omitted 75 entries ]
```

In addition, we can identify the biological functions associated with the detected GO terms:

```
library(GO.db)
library(DT)
# Previous function to get the description of the identified GO terms:
get_go_description <- function(go_id) {
  go_term <- Term(GOTERM[[go_id]])
  return(go_term)
}

# GO terms description:
datatable(data.frame(GO_term = names(result),
                     Description = sapply(names(result), get_go_description,
                                           USE.NAMES = TRUE)),
          filter = "top", rownames = FALSE)
```

# References

Flores, Pablo, Miquel Salicrú, Alex Sánchez-Pla, and Jordi Ocaña. 2022. “An Equivalence Test Between Features Lists, Based on the Sorensen–Dice Index and the Joint Frequencies of Go Term Enrichment.” *BMC Bioinformatics* 23 (1): 207.