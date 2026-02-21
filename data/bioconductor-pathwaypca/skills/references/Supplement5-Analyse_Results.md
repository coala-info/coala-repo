# Suppl. Ch. 5 - Visualizing the Results

#### Gabriel Odom

#### 2025-10-30

* [1. Overview](#overview)
  + [1.1 Packages](#packages)
  + [1.2 Example Results](#example-results)
* [2. Plot Pathway Significance Levels](#plot-pathway-significance-levels)
  + [2.1 Trim Pathway Names](#trim-pathway-names)
  + [2.2 Tidy the Pathway Results](#tidy-the-pathway-results)
  + [2.3 Plot Significant Survival Pathways for One Adjustment](#plot-significant-survival-pathways-for-one-adjustment)
  + [2.4 Plot Significant Survival Pathways for All Adjustments](#plot-significant-survival-pathways-for-all-adjustments)
* [3. Inspecting the Driving Genes](#inspecting-the-driving-genes)
  + [3.1 Extract Pathway Decomposition](#extract-pathway-decomposition)
  + [3.2 Gene Loadings](#gene-loadings)
  + [3.3 Gene Correlations with PCs](#gene-correlations-with-pcs)
* [4. Plot patient-specific pathway activities](#plot-patient-specific-pathway-activities)
* [5. Review](#review)

# 1. Overview

This vignette is the fifth chapter in the “Pathway Significance Testing with `pathwayPCA`” workflow, providing a detailed perspective to the [Inspect Results](https://gabrielodom.github.io/pathwayPCA/articles/Supplement1-Quickstart_Guide.html#inspect-results) section of the Quickstart Guide. This vignette will discuss graphing the pathway-specific \(p\)-values, FDR values, and associated log-scores. Also, we will discuss how to plot the gene- or protein-specific loadings within a certain pathway and further how to plot the correlation between a gene or protein within a pathway and the principal component representing that pathway.

Before we move on, we will outline our steps. After reading this vignette, you should be able to

1. Plot the log-score rank of the top pathways.
2. Plot the feature loadings for a single pathway.
3. Plot the correlations between a pathway principal component and the features within that pathway.

## 1.1 Packages

First, load the `pathwayPCA` package and the [`tidyverse` package suite](https://www.tidyverse.org/).

```
library(tidyverse)
library(pathwayPCA)
```

## 1.2 Example Results

First, we will replicate the data setup from the previous vignette chapters on importing data and creating data objects ( [Chapter 2: Import and Tidy Data](https://gabrielodom.github.io/pathwayPCA/articles/Supplement2-Importing_Data.html) and [Chapter 3: Creating -Omics Data Objects](https://gabrielodom.github.io/pathwayPCA/articles/Supplement3-Create_Omics_Objects.html), respectively). See these chapters for detailed explination of the code below.

```
# Load Data: see Chapter 2
data("colonSurv_df")
data("colon_pathwayCollection")

# Create -Omics Container: see Chapter 3
colon_OmicsSurv <- CreateOmics(
  assayData_df = colonSurv_df[, -(2:3)],
  pathwayCollection_ls = colon_pathwayCollection,
  response = colonSurv_df[, 1:3],
  respType = "surv"
)
#>
#>   ======  Creating object of class OmicsSurv  =======
#> The input pathway database included 676 unique features.
#> The input assay dataset included 656 features.
#> Only pathways with at least 3 or more features included in the assay dataset are
#>   tested (specified by minPathSize parameter). There are 15 pathways which meet
#>   this criterion.
#> Because pathwayPCA is a self-contained test (PMID: 17303618), only features in
#>   both assay data and pathway database are considered for analysis. There are 615
#>   such features shared by the input assay and pathway database.
```

We will resume inspection of the analysis results from the [chapter 4 vignette](https://gabrielodom.github.io/pathwayPCA/articles/Supplement4-Methods_Walkthrough.html) for the AESPCA method.

```
# AESPCA Analysis: see Chapter 4
colonSurv_aespcOut <- AESPCA_pVals(
  object = colon_OmicsSurv,
  numReps = 0,
  numPCs = 2,
  parallel = TRUE,
  numCores = 2,
  adjustpValues = TRUE,
  adjustment = c("BH", "Bonf")
)
#> Part 1: Calculate Pathway AES-PCs
#> Initializing Computing Cluster: DONE
#> Extracting Pathway PCs in Parallel: DONE
#>
#> Part 2: Calculate Pathway p-Values
#> Initializing Computing Cluster: DONE
#> Extracting Pathway p-Values in Parallel: DONE
#>
#> Part 3: Adjusting p-Values and Sorting Pathway p-Value Data Frame
#> DONE
```

---

# 2. Plot Pathway Significance Levels

The first element of this results data object is a data frame of pathways and their significance levels (`pVals_df`).

```
getPathpVals(colonSurv_aespcOut)
#> # A tibble: 15 × 4
#>    terms                                            rawp  FDR_BH FWER_Bonferroni
#>    <chr>                                           <dbl>   <dbl>           <dbl>
#>  1 PID_EPHB_FWD_PATHWAY                          6.53e-6 9.80e-5       0.0000980
#>  2 REACTOME_PHOSPHOLIPID_METABOLISM              1.96e-4 1.47e-3       0.00295
#>  3 REACTOME_INSULIN_RECEPTOR_SIGNALLING_CASCADE  4.90e-4 2.45e-3       0.00735
#>  4 KEGG_ASTHMA                                   8.21e-4 3.08e-3       0.0123
#>  5 KEGG_ERBB_SIGNALING_PATHWAY                   1.47e-3 4.42e-3       0.0221
#>  6 PID_TNF_PATHWAY                               2.60e-3 6.51e-3       0.0390
#>  7 REACTOME_SIGNALING_BY_INSULIN_RECEPTOR        4.42e-3 9.08e-3       0.0662
#>  8 KEGG_PENTOSE_PHOSPHATE_PATHWAY                4.84e-3 9.08e-3       0.0726
#>  9 ST_GA12_PATHWAY                               1.48e-2 2.46e-2       0.222
#> 10 KEGG_RETINOL_METABOLISM                       2.55e-2 3.82e-2       0.382
#> 11 KEGG_NON_SMALL_CELL_LUNG_CANCER               4.69e-2 6.39e-2       0.703
#> 12 KEGG_ANTIGEN_PROCESSING_AND_PRESENTATION      7.37e-2 9.21e-2       1
#> 13 BIOCARTA_RELA_PATHWAY                         7.09e-1 8.01e-1       1
#> 14 BIOCARTA_TNFR1_PATHWAY                        7.76e-1 8.01e-1       1
#> 15 BIOCARTA_SET_PATHWAY                          8.01e-1 8.01e-1       1
```

Given the \(p\)-values from these pathways, we will now graph their score (negative log of the \(p\)-value) and description for the top 15 most-significant pathways.

## 2.1 Trim Pathway Names

Because pathway names are quite long, we truncate names longer than 35 characters for better display in the graphs.

```
pVals_df <-
  getPathpVals(colonSurv_aespcOut) %>%
  mutate(
    terms = ifelse(
      str_length(terms) > 35,
      paste0(str_sub(terms, 1, 33), "..."),
      terms
    )
  )

pVals_df
#> # A tibble: 15 × 4
#>    terms                                      rawp    FDR_BH FWER_Bonferroni
#>    <chr>                                     <dbl>     <dbl>           <dbl>
#>  1 PID_EPHB_FWD_PATHWAY                 0.00000653 0.0000980       0.0000980
#>  2 REACTOME_PHOSPHOLIPID_METABOLISM     0.000196   0.00147         0.00295
#>  3 REACTOME_INSULIN_RECEPTOR_SIGNALL... 0.000490   0.00245         0.00735
#>  4 KEGG_ASTHMA                          0.000821   0.00308         0.0123
#>  5 KEGG_ERBB_SIGNALING_PATHWAY          0.00147    0.00442         0.0221
#>  6 PID_TNF_PATHWAY                      0.00260    0.00651         0.0390
#>  7 REACTOME_SIGNALING_BY_INSULIN_REC... 0.00442    0.00908         0.0662
#>  8 KEGG_PENTOSE_PHOSPHATE_PATHWAY       0.00484    0.00908         0.0726
#>  9 ST_GA12_PATHWAY                      0.0148     0.0246          0.222
#> 10 KEGG_RETINOL_METABOLISM              0.0255     0.0382          0.382
#> 11 KEGG_NON_SMALL_CELL_LUNG_CANCER      0.0469     0.0639          0.703
#> 12 KEGG_ANTIGEN_PROCESSING_AND_PRESE... 0.0737     0.0921          1
#> 13 BIOCARTA_RELA_PATHWAY                0.709      0.801           1
#> 14 BIOCARTA_TNFR1_PATHWAY               0.776      0.801           1
#> 15 BIOCARTA_SET_PATHWAY                 0.801      0.801           1
```

## 2.2 Tidy the Pathway Results

For the data frame containing the survival data pathway \(p\)-values, we will transform the data for better graphics. This code takes in the pathway \(p\)-values data frame from the AESPCA method output and [gathers](https://rpubs.com/mm-c/gather-and-spread) it into a “tidy” data frame (compatible with `ggplot`). We also add on a column for the negative natural logarithm of the pathway \(p\)-values (called `score`) and recode the label of the \(p\)-value adjustment method.

```
colonOutGather_df <-
  # Take in the results data frame,
  pVals_df %>%
  # "tidy" the data,
  gather(variable, value, -terms) %>%
  # add the score variable, and
  mutate(score = -log(value)) %>%
  # store the adjustment methods as a factor
  mutate(variable = factor(variable)) %>%
  mutate(
    variable = recode_factor(
      variable,
      rawp = "None",
      FDR_BH = "Hochberg",
      FWER_Bonferroni = "Bonferroni"
    )
  )
```

## 2.3 Plot Significant Survival Pathways for One Adjustment

Now we will plot the pathway \(p\)-values for the most significant pathways as a horizontal bar chart. For more information on how to modify `ggplot` graphs, or to learn how to create your own, please see Chang’s [R Graphics Cookbook](https://www.amazon.com/dp/1449316956/ref%3Dcm_sw_su_dp?tag=ggplot2-20) or Wickham’s [`ggplot2`: Elegant Graphics for Data Analysis](http://ggplot2.org/book/).

First, we select the rows of the \(p\)-values data frame which correspond to the adjustment method we are interested in. We will select the Benjamini and Hochberg FDR-adjustment method.

```
BHpVals_df <-
  colonOutGather_df %>%
  filter(variable == "Hochberg") %>%
  select(-variable)
```

Now we plot the pathway significance level for the pathways based on this FDR-adjustment method.

```
ggplot(BHpVals_df) +
  # set overall appearance of the plot
  theme_bw() +
  # Define the dependent and independent variables
  aes(x = reorder(terms, score), y = score) +
  # From the defined variables, create a vertical bar chart
  geom_col(position = "dodge", fill = "#F47321") +
  # Set main and axis titles
  ggtitle("AES-PCA Significant Pathways: Colon Cancer") +
  xlab("Pathways") +
  ylab("Negative Log BH-FDR") +
  # Add a line showing the alpha = 0.01 level
  geom_hline(yintercept = -log(0.01), size = 2, color = "#005030") +
  # Flip the x and y axes
  coord_flip()
```

![](data:image/png;base64...)

## 2.4 Plot Significant Survival Pathways for All Adjustments

If we were interested in comparing adjustment methods, we can. This figure shows that a few of the simulated pathways are significant at the \(\alpha = 0.01\) for either the Benjamini and Hochberg or Bonferroni FWER approaches. The vertical black line is at \(-\log(p = 0.01)\). This figure is slightly different from the figures shown in the [Graph Top Pathways](https://gabrielodom.github.io/pathwayPCA/articles/Supplement1-Quickstart_Guide.html#graph-of-top-pathways) subsection of the Quickstart Guide.

```
ggplot(colonOutGather_df) +
  # set overall appearance of the plot
  theme_bw() +
  # Define the dependent and independent variables
  aes(x = reorder(terms, score), y = score) +
  # From the defined variables, create a vertical bar chart
  geom_col(position = "dodge", aes(fill = variable)) +
  # Set the legend, main titles, and axis titles
  scale_fill_discrete(guide = FALSE) +
  ggtitle("AES-PCA Significant Colon Pathways by FWER Adjustment") +
  xlab("Pathways") +
  ylab("Negative Log p-Value") +
  # Add a line showing the alpha = 0.01 level
  geom_hline(yintercept = -log(0.01), size = 1) +
  # Flip the x and y axes
  coord_flip() +
  # Create a subplot for each p-value adjustment method
  facet_grid(. ~ variable)
```

![](data:image/png;base64...)

---

# 3. Inspecting the Driving Genes

Now that we have a few significant pathways, we can look at the loadings of each gene onto the first AES-PC from these pathways.

```
pVals_df %>%
  filter(FDR_BH < 0.01) %>%
  select(terms)
#> # A tibble: 8 × 1
#>   terms
#>   <chr>
#> 1 PID_EPHB_FWD_PATHWAY
#> 2 REACTOME_PHOSPHOLIPID_METABOLISM
#> 3 REACTOME_INSULIN_RECEPTOR_SIGNALL...
#> 4 KEGG_ASTHMA
#> 5 KEGG_ERBB_SIGNALING_PATHWAY
#> 6 PID_TNF_PATHWAY
#> 7 REACTOME_SIGNALING_BY_INSULIN_REC...
#> 8 KEGG_PENTOSE_PHOSPHATE_PATHWAY
```

## 3.1 Extract Pathway Decomposition

We will chose the top two significant pathways for closer inspection, and we want to ascertain which genes load onto the pathway PCs. Notice that the pathway loadings are named by the internal pathway key, so we need to use the `getPathPCL()` to match this key to its pathway and extract the pathway PCs and loadings (PC & L) list from the `colonSurv_aespcOut` object. Here are the loading vectors and pathway details from `PID_EPHB_FWD_PATHWAY`:

```
pathway491_ls <- getPathPCLs(colonSurv_aespcOut, "PID_EPHB_FWD_PATHWAY")
pathway491_ls
#> $PCs
#> # A tibble: 250 × 3
#>    sampleID      V1     V2
#>    <chr>      <dbl>  <dbl>
#>  1 subj1    -0.712   0.525
#>  2 subj2    -0.0580  0.293
#>  3 subj3    -1.65    0.367
#>  4 subj4     3.63    1.78
#>  5 subj5    -1.60   -0.279
#>  6 subj6     1.95    3.12
#>  7 subj7     2.38    1.48
#>  8 subj8    -1.48   -0.126
#>  9 subj9    -0.102   0.364
#> 10 subj10    1.89    2.05
#> # ℹ 240 more rows
#>
#> $Loadings
#> # A tibble: 40 × 3
#>    featureID    PC1   PC2
#>    <chr>      <dbl> <dbl>
#>  1 EPHB2      0.242 0.123
#>  2 EPHB4      0.168 0
#>  3 EFNA5      0     0
#>  4 MAPK1     -0.265 0.251
#>  5 SRC        0     0.416
#>  6 GRB2       0     0
#>  7 MAP2K1     0     0
#>  8 PXN        0     0.471
#>  9 CRK        0     0
#> 10 CDC42      0     0
#> # ℹ 30 more rows
#>
#> $pathway
#> [1] "pathway491"
#>
#> $term
#> [1] "PID_EPHB_FWD_PATHWAY"
#>
#> $description
#> [1] NA
```

This tells us that `pathway491` represents the [EPHB forward signaling](http://software.broadinstitute.org/gsea/msigdb/geneset_page.jsp?geneSetName=PID_EPHB_FWD_PATHWAY) pathway.

We can also extract the PCs and loadings vectors for `KEGG_ASTHMA` (the [Asthma](http://software.broadinstitute.org/gsea/msigdb/geneset_page.jsp?geneSetName=KEGG_ASTHMA) pathway), which we will compare later.

```
pathway177_ls <- getPathPCLs(colonSurv_aespcOut, "KEGG_ASTHMA")
```

## 3.2 Gene Loadings

### 3.2.1 Wrangle Pathway Loadings

Given the loading vectors from the EPHB forward signaling pathway, we need to wrangle them into a data frame that the `ggplot()` function can use. For this, we’ve written a function that you can modify as you need. This function takes in the pathway PC & L list returned by the `getPathPCLs()` function and returns a data frame with all the components necessary for a plot of the gene loadings. For more aesthetically-pleasing plots, we set the default for one PC or loading vector per figure.

```
TidyLoading <- function(pathwayPCL, numPCs = 1){
  # browser()

  # Remove rows with 0 loading from the first numPCs columns
  loadings_df <- pathwayPCL$Loadings
  totLoad_num  <- rowSums(abs(
    loadings_df[, 2:(numPCs + 1), drop = FALSE]
  ))
  keepRows_idx <- totLoad_num > 0
  loadings_df <- loadings_df[keepRows_idx, , drop = FALSE]

  # Sort the value on first feature
  load_df <- loadings_df %>%
    arrange(desc(PC1))

  # Wrangle the sorted loadings:
  gg_df <- load_df %>%
    # make the featureID column a factor, and rename the ID column,
    mutate(ID = factor(featureID, levels = featureID)) %>%
    select(-featureID) %>%
    # "tidy" the data, and
    gather(Feature, Value, -ID) %>%
    # add the up / down indicator.
    mutate(Direction = ifelse(Value > 0, "Up", "Down"))

  # Add the pathway name and description
  attr(gg_df, "PathName") <- pathwayPCL$term
  attr(gg_df, "Description") <- pathwayPCL$description

  gg_df

}
```

We can use this function to “tidy up” the loadings from the EPHB forward signaling pathway:

```
tidyLoad491_df <- TidyLoading(pathwayPCL = pathway491_ls)
tidyLoad491_df
#> # A tibble: 26 × 4
#>    ID    Feature   Value Direction
#>    <fct> <chr>     <dbl> <chr>
#>  1 EPHB2 PC1      0.242  Up
#>  2 EPHB4 PC1      0.168  Up
#>  3 MAPK3 PC1      0.0451 Up
#>  4 EFNB3 PC1     -0.0371 Down
#>  5 RAP1A PC1     -0.0448 Down
#>  6 NCK1  PC1     -0.184  Down
#>  7 ROCK1 PC1     -0.218  Down
#>  8 RAP1B PC1     -0.238  Down
#>  9 MAPK1 PC1     -0.265  Down
#> 10 SYNJ1 PC1     -0.280  Down
#> # ℹ 16 more rows
```

### 3.2.2 Plot the Gene Loadings

We also wrote a function to create a `ggplot` graph object which uses this tidy data frame.

```
PathwayBarChart <- function(ggData_df, y_lab,
                            colours = c(Up = "#009292", Down = "#920000"),
                            label_size = 5,
                            sigFigs = 0,
                            ...){

  # Base plot layer
  p1 <- ggplot(ggData_df, aes(x = ID, y = Value, color = Direction))

  # Add geometric layer and split by Feature
  p1 <- p1 +
    geom_col(aes(fill = Direction), width = 0.5) +
    facet_wrap(~Feature, nrow = length(unique(ggData_df$Feature)))

  # Add Gene Labels
  p1 <- p1 +
    geom_text(
      aes(y = 0, label = ID),
      vjust = "middle",
      hjust = ifelse(ggData_df$Direction == "Up", "top", "bottom"),
      size = label_size, angle = 90, color = "black"
    )

  # Add Value Labels
  p1 <- p1 +
    geom_text(
      aes(label = ifelse(ggData_df$Value == 0, "", round(Value, sigFigs))),
      vjust = ifelse(ggData_df$Direction == "Up", "top", "bottom"),
      hjust = "middle",
      size = label_size, color = "black"
    )

  # Set the Theme
  p1 <- p1 +
    scale_y_continuous(expand = c(0.15, 0.15)) +
    theme_classic() +
    theme(
      axis.title.x = element_blank(),
      axis.text.x  = element_blank(),
      axis.ticks.x = element_blank(),
      strip.text   = element_text(size = 14),
      legend.position = "none"
    )

  # Titles, Subtitles, and Labels
  pathName <- attr(ggData_df, "PathName")
  pathDesc <- attr(ggData_df, "Description")
  if(is.na(pathDesc)){
    p1 <- p1 + ggtitle(pathName) + ylab(y_lab)
  } else {
    p1 <- p1 + labs(title = pathName, subtitle = pathDesc, y = y_lab)
  }

  # Return
  p1

}
```

This is the resulting loading bar plot for the EPHB forward signaling pathway (because all of the loadings are between -1 and 1, we set the significant figures to 2):

```
PathwayBarChart(
  ggData_df = tidyLoad491_df,
  y_lab = "PC Loadings",
  sigFigs = 2
)
#> Warning: Use of `ggData_df$Value` is discouraged.
#> ℹ Use `Value` instead.
```

![](data:image/png;base64...)

For comparison, this is the bar plot for the asthma pathway (`pathway177` in our -Omics data container):

```
# pathway177_loadings_bar_chart, fig.height = 6, fig.width = 10.7, out.width = "100%", out.height = "60%"
PathwayBarChart(
  ggData_df = tidyLoad177_df,
  y_lab = "PC Loadings",
  sigFigs = 2
)
#> Warning: Use of `ggData_df$Value` is discouraged.
#> ℹ Use `Value` instead.
```

![](data:image/png;base64...)

## 3.3 Gene Correlations with PCs

### 3.3.1 Calculate Pathway Correlations

Additionally, we can calculate the correlation between gene expression in the assay corresponding to the EPHB forward signaling pathway and the PC vectors extracted from this pathway. Thus, we need to extract the recorded gene levels corresponding to the non-zero loadings for the PCs, calculate the Spearman correlations between these values and their extracted PCs, then wrangle these correlations into a data frame that the `ggplot()` function can use. We have written an additional function that you can modify as you need. This function takes in the `Omics` data container (that you created in Chapter 3) and the PC & L list returned by `getPathPCLs()`. This function returns a data frame with all the components necessary for a plot of the assay-PC correlations.

```
TidyCorrelation <- function(Omics, pathwayPCL, numPCs = 1){

  loadings_df <- pathwayPCL$Loadings
  totLoad_num  <- rowSums(abs(
    loadings_df[, 2:(numPCs + 1), drop = FALSE]
  ))
  keepRows_idx <- totLoad_num > 0
  loadings_df <- loadings_df[keepRows_idx, , drop = FALSE]

  geneNames <- loadings_df$featureID
  geneCorr_mat <- t(
    cor(
      pathwayPCL$PCs[, -1],
      getAssay(Omics)[geneNames],
      method = "spearman"
    )
  )
  colnames(geneCorr_mat) <- paste0("PC", 1:ncol(geneCorr_mat))

  pathwayPCL$Loadings <- data.frame(
    featureID = rownames(geneCorr_mat),
    geneCorr_mat,
    stringsAsFactors = FALSE,
    row.names = NULL
  )

  TidyLoading(pathwayPCL, numPCs = numPCs)

}
```

We can use this function to “tidy up” the loadings from the EPHB forward signaling pathway:

```
tidyCorr491_df <- TidyCorrelation(
  Omics = colon_OmicsSurv,
  pathwayPCL = pathway491_ls
)
tidyCorr491_df
#>        ID Feature       Value Direction
#> 1   EPHB2     PC1  0.48756885        Up
#> 2   EPHB4     PC1  0.42455590        Up
#> 3   MAPK3     PC1  0.33756419        Up
#> 4   RAP1A     PC1 -0.29517214      Down
#> 5   EFNB3     PC1 -0.31177022      Down
#> 6   MAPK1     PC1 -0.44113346      Down
#> 7   ROCK1     PC1 -0.50611242      Down
#> 8   RAP1B     PC1 -0.52530894      Down
#> 9    NCK1     PC1 -0.54333836      Down
#> 10 PIK3CA     PC1 -0.61548850      Down
#> 11  SYNJ1     PC1 -0.65350665      Down
#> 12  ITSN1     PC1 -0.74234263      Down
#> 13 MAP4K4     PC1 -0.74507829      Down
#> 14  EPHB2     PC2  0.20538918        Up
#> 15  EPHB4     PC2  0.07888067        Up
#> 16  MAPK3     PC2  0.07749823        Up
#> 17  RAP1A     PC2 -0.10685319      Down
#> 18  EFNB3     PC2 -0.16173775      Down
#> 19  MAPK1     PC2  0.67115788        Up
#> 20  ROCK1     PC2 -0.30859295      Down
#> 21  RAP1B     PC2 -0.04189417      Down
#> 22   NCK1     PC2  0.06723602        Up
#> 23 PIK3CA     PC2  0.23174041        Up
#> 24  SYNJ1     PC2 -0.09783440      Down
#> 25  ITSN1     PC2  0.06114568        Up
#> 26 MAP4K4     PC2  0.12289233        Up
```

### 3.3.2 Plot the Assay-PC Correlation

This is the resulting correlation bar plot for the EPHB forward signaling pathway:

```
PathwayBarChart(
  ggData_df = tidyCorr491_df,
  y_lab = "Assay-PC Correlations",
  sigFigs = 1
)
```

![](data:image/png;base64...)

And this is the same figure for the asthma pathway.

```
PathwayBarChart(
  ggData_df = tidyCorr177_df,
  y_lab = "Assay-PC Correlations",
  sigFigs = 1
)
```

![](data:image/png;base64...)

# 4. Plot patient-specific pathway activities

estimate pathway activities for each patient, both for protein expressions and copy number expressions separately

This is the circle plot for the IL-1 signaling pathway:

```
# Load data (already ordered by copyNumber PC1 score)
circlePlotData <- readRDS("circlePlotData.RDS")

# Set color scales
library(grDevices)
bluescale <- colorRampPalette(c("blue", "white"))(45)
redscale  <- colorRampPalette(c("white", "red"))(38)
Totalpalette <- c(bluescale,redscale)

# Apply colours
copyCol <-  Totalpalette[circlePlotData$copyNumOrder]
proteoCol <- Totalpalette[circlePlotData$proteinOrder]
```

Blue stands for negative PC1 score, Red stands for positive PC1 score. The inner loop measures copy number variation, while the outer loop measures protein expression.

```
library(circlize)
#> ========================================
#> circlize version 0.4.16
#> CRAN page: https://cran.r-project.org/package=circlize
#> Github page: https://github.com/jokergoo/circlize
#> Documentation: https://jokergoo.github.io/circlize_book/book/
#>
#> If you use it in published research, please cite:
#> Gu, Z. circlize implements and enhances circular visualization
#>   in R. Bioinformatics 2014.
#>
#> This message can be suppressed by:
#>   suppressPackageStartupMessages(library(circlize))
#> ========================================

# Set parameters
nPathway <- 83
factors  <- 1:nPathway

# Plot Setup
circos.clear()
circos.par(
  "gap.degree" = 0,
  "cell.padding" = c(0, 0, 0, 0),
  start.degree = 360/40,
  track.margin = c(0, 0),
  "clock.wise" = FALSE
)
circos.initialize(factors = factors, xlim = c(0, 3))

# ProteoOmics
circos.trackPlotRegion(
  ylim = c(0, 3),
  factors = factors,
  bg.col = proteoCol,
  track.height = 0.3
)

# Copy Number
circos.trackPlotRegion(
  ylim = c(0, 3),
  factors = factors,
  bg.col = copyCol,
  track.height = 0.3
)

# Add labels
suppressMessages(
  circos.trackText(
    x = rep(-3, nPathway),
    y = rep(-3.8, nPathway),
    labels = "PID_IL1",
    factors = factors,
    col = "#2d2d2d",
    font = 2,
    adj = par("adj"),
    cex = 1.5,
    facing = "downward",
    niceFacing = TRUE
  )
)
```

![](data:image/png;base64...)

---

# 5. Review

We have has covered in this vignette:

1. Plotting the log-score rank of the top pathways.
2. Plotting the feature loadings for a single pathway.
3. Plotting the correlations between a pathway principal component and the features within that pathway.

We are exploring options to connect this package to other pathway-testing software. We are further considering other summary functions and/or graphics to help display the output of our `*_pVals()` functions. If you have any questions, comments, complaints, or suggestions, please [submit an issue ticket](https://github.com/gabrielodom/pathwayPCA/issues/new) and give us some feedback. Also you can visit our [development page](https://github.com/gabrielodom/pathwayPCA).

Here is the R session information for this vignette:

```
sessionInfo()
#> R version 4.5.1 Patched (2025-08-23 r88802)
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
#> [1] stats4    parallel  stats     graphics  grDevices utils     datasets
#> [8] methods   base
#>
#> other attached packages:
#>  [1] circlize_0.4.16             SummarizedExperiment_1.40.0
#>  [3] Biobase_2.70.0              GenomicRanges_1.62.0
#>  [5] Seqinfo_1.0.0               IRanges_2.44.0
#>  [7] S4Vectors_0.48.0            BiocGenerics_0.56.0
#>  [9] generics_0.1.4              MatrixGenerics_1.22.0
#> [11] matrixStats_1.5.0           survminer_0.5.1
#> [13] ggpubr_0.6.2                survival_3.8-3
#> [15] pathwayPCA_1.26.0           lubridate_1.9.4
#> [17] forcats_1.0.1               stringr_1.5.2
#> [19] dplyr_1.1.4                 purrr_1.1.0
#> [21] readr_2.1.5                 tidyr_1.3.1
#> [23] tibble_3.3.0                ggplot2_4.0.0
#> [25] tidyverse_2.0.0
#>
#> loaded via a namespace (and not attached):
#>  [1] tidyselect_1.2.1    farver_2.1.2        S7_0.2.0
#>  [4] fastmap_1.2.0       digest_0.6.37       timechange_0.3.0
#>  [7] lifecycle_1.0.4     magrittr_2.0.4      compiler_4.5.1
#> [10] rlang_1.1.6         sass_0.4.10         tools_4.5.1
#> [13] utf8_1.2.6          yaml_2.3.10         data.table_1.17.8
#> [16] knitr_1.50          ggsignif_0.6.4      S4Arrays_1.10.0
#> [19] labeling_0.4.3      bit_4.6.0           DelayedArray_0.36.0
#> [22] RColorBrewer_1.1-3  abind_1.4-8         withr_3.0.2
#> [25] grid_4.5.1          lars_1.3            colorspace_2.1-2
#> [28] xtable_1.8-4        scales_1.4.0        dichromat_2.0-0.1
#> [31] cli_3.6.5           rmarkdown_2.30      crayon_1.5.3
#> [34] km.ci_0.5-6         tzdb_0.5.0          cachem_1.1.0
#> [37] splines_4.5.1       XVector_0.50.0      survMisc_0.5.6
#> [40] vctrs_0.6.5         Matrix_1.7-4        jsonlite_2.0.0
#> [43] carData_3.0-5       car_3.1-3           hms_1.1.4
#> [46] bit64_4.6.0-1       rstatix_0.7.3       archive_1.1.12
#> [49] Formula_1.2-5       jquerylib_0.1.4     glue_1.8.0
#> [52] shape_1.4.6.1       stringi_1.8.7       gtable_0.3.6
#> [55] pillar_1.11.1       htmltools_0.5.8.1   R6_2.6.1
#> [58] KMsurv_0.1-6        vroom_1.6.6         evaluate_1.0.5
#> [61] lattice_0.22-7      backports_1.5.0     broom_1.0.10
#> [64] bslib_0.9.0         SparseArray_1.10.0  gridExtra_2.3
#> [67] nlme_3.1-168        mgcv_1.9-3          xfun_0.53
#> [70] GlobalOptions_0.1.2 zoo_1.8-14          pkgconfig_2.0.3
```