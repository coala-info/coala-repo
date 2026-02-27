proBatch
Jelena Čuklina, Chloe H. Lee, Patrick Pedrioli and Ruedi Aebersold
Institute of Molecular Systems Biology, Department of Biology, ETH Zurich, Switzerland

2019-05-02

Abstract

This vignette describes how to apply diﬀerent functions from the proBatch package to diagnose and
correct for batch eﬀects. Most of the functions are applicable any “omic” data, however, the package has
a number of functions, designed speciﬁcally for mass spectrometry-based proteomics, and has been tested
on SWATH data.

The proBatch package provides a complete functionality for batch correction workﬂow: to prepare the
data for analysis, diagnose and correct batch eﬀects and ﬁnally, to evaluate the correction with quality
control metrics.

The proBatch package was programmed and intended for use by researchers without extensive

programming skills, but with basic R knowledge.

Contents

1 Introduction

1.1 Batch eﬀects analysis in large-scale data . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .

2 Preparation for the analysis

Installing dependencies and proBatch . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
2.1
2.2 Preparing the data for analysis . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
2.2.1 Loading the libraries . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
2.2.2
Input data formats . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
2.2.3 Example dataset . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
2.2.4 Preparing sample and peptide annotations . . . . . . . . . . . . . . . . . . . . . . . . .
2.2.5 Other utility functions . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .

3 Step-by-step workﬂow

3.1

Initial assessment of the raw data matrix . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
3.1.1 Plotting the sample mean . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
3.1.2 Plotting boxplots . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
3.2 Normalization . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
3.2.1 Median normalization . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
3.2.2 Quantile normalization . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
3.3 Diagnostics of batch eﬀects in normalized data . . . . . . . . . . . . . . . . . . . . . . . . . .
3.3.1 Hierarchical clustering . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
3.3.2 Principal component analysis (PCA) . . . . . . . . . . . . . . . . . . . . . . . . . . . .
3.3.3 Principal variance component analysis (PVCA) . . . . . . . . . . . . . . . . . . . . . .
3.3.4 Peptide-level diagnostics and spike-ins . . . . . . . . . . . . . . . . . . . . . . . . . . .
3.4 Correction of batch eﬀects . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
3.4.1 Continuous drift correction . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
3.4.2 Discrete batch correction: combat or peptide-level median centering . . . . . . . . . .
3.4.3 Correct batch eﬀects: universal function . . . . . . . . . . . . . . . . . . . . . . . . . .
3.5 Quality control on batch-corrected data matrix . . . . . . . . . . . . . . . . . . . . . . . . . .
3.5.1 Heatmap of selected replicate samples . . . . . . . . . . . . . . . . . . . . . . . . . . .
3.5.2 Correlation distribution of samples . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
3.5.3 Correlation of peptide distributions within and between proteins . . . . . . . . . . . .

2
2

3
3
4
4
4
5
6
7

8
8
8
9
10
10
10
11
11
13
14
15
16
16
17
18
19
19
20
21

1

4 SessionInfo

5 Citation

6 References

1

Introduction

22

24

25

1.1 Batch eﬀects analysis in large-scale data

Recent advances in mass-spectrometry enabled fast and near-exhaustive identiﬁcation and quantiﬁcation
of proteins in complex biological samples [1], allowing for the proﬁling of large-scale datasets. Obtaining a
suﬃciently large dataset is, however, associated with considerable logistics eﬀorts. Often multiple handlers
at the sample preparation and data acquisition steps are involved e.g. protein extraction, peptide digestion,
instrument cleaning. This introduces systematic technical variations known as batch eﬀects.

Batch eﬀects can alter or obscure the biological signal in the data [2, 3]. Thus, the presence and severity of
batch eﬀects should be assessed, and, if necessary, corrected.

The fundamental objective of the batch eﬀects adjustment procedure is to make all measurements of samples
comparable for a meaningful biological analysis. Normalization brings the measurements into the same scale.
Bias in the data, however, can persist even after normalization, as batch eﬀects might aﬀect speciﬁc features
(peptides, genes) thus requiring additional batch correction procedures. This means, that the correction of
technical bias has often two steps: normalization and batch eﬀects correction.

The improvement of the data is best assessed visually at each step of the correction procedure. The initial
assessment sets the baseline, before any correction is executed. After normalization, batch eﬀects diagnostics
allow to determine the severity of the remaining bias. Finally, the quality control step allows to determine
whether the correction improved the quality of the data.

The pipeline, summarizing this workﬂow, is shown in Fig.1.

##Analysis of large-scale data: steps before and after batch correction

We recommend users to follow this batch correction workﬂow to ensure all measurements are comparable for
downstream analysis. We provide step-by-step illustrations to implement this workﬂow in the next sections.

Before starting the description, we give a few hints about the steps preceding and following batch eﬀects
analysis and correction.

• It is assumed that the initial data processing is completed. In mass spectrometry- based proteomics,

this involves primarily peptide-spectrum matching [4, 5] and FDR control [6].

• Data ﬁltering is commonly the next step of data processing. In the context of batch eﬀects correction,
both peptide and sample ﬁltering need to be approached with caution. First of all, decoy measurements
should be ﬁltered out to ensure correct sample intensity distribution alignment. However, non-proteotypic
peptides should be retained. Filtering out low-quality samples,also substantially alters normalization
and batch eﬀects correction. The “bad” samples, usually identiﬁed by the total intensity of identiﬁed
peptides or correlation of samples, can be removed either before or after the correction for technical
bias. Which option is best for a given dataset, should be decided in each case individually.

• We strongly advocate not to impute missing values before correction and to exclude “requant” values,
inferred from SWATH data. Two common strategies to impute values use either “average” measurements,
or random noise-level measurements. Both strategies bias the mean/median estimate of the peptide
and are detrimental to both normalization and batch eﬀects correction.

• We suggest to perform protein quantiﬁcation after batch eﬀects correction, as the correction procedure
alters the abundances of peptides and peptide transitions, and these abundances are critical for protein

2

Figure 1: proBatch in batch correction workﬂow

quantity inference. Instead, we do recommend to correct the technical noise at the level, which is used
to infer the proteins (thus, fragment-level for inference tools such as aLFQ or MSstats).

2 Preparation for the analysis

2.1 Installing dependencies and proBatch

proBatch is primarily a wrapper of functions from other packages, therefore it has numerous dependencies.
If some of these dependencies are not installed, you will need to do that before running proBatch.
bioc_deps <- c("GO.db", "impute", "preprocessCore", "pvca","sva" )
cran_deps <- c("corrplot", "data.table", "ggplot2", "ggfortify","lazyeval", "pheatmap", "reshape2", "rlang",

"tibble", "dplyr", "tidyr" "wesanderson","WGCNA")

if (!requireNamespace("BiocManager", quietly = TRUE))

install.packages("BiocManager")

BiocManager::install(bioc_deps)
install.packages(cran_deps)

To install the proBatch package, the following commands can be executed in R:

# Once the proBatch package is in Bioconductor, can easily install by:
install.packages("proBatch")

# Alternatively, install the development version from GitHub:
install.packages("devtools")
devtools::install_github("symbioticMe/proBatch", build_vignettes = TRUE)

3

2.2 Preparing the data for analysis

2.2.1 Loading the libraries

In this vignette, we use functions from dplyr, tibble , ggplot2 and other tidyverse package family to
transform some data frames
require(dplyr)
require(tibble)
require(ggplot2)

2.2.2

Input data formats

To analyze an experiment for batch eﬀects, three tables need to be loaded into environment:

The package typically requires three datasets: 1) measurement (data matrix), 2) sample annotation, and 3)
feature annotation (optional) tables. If you are familiar with the Biobase package, these correspond to 1)
assayData, 2) joined phenoData and protocolData, and 3)featureData.

1) Measurement table

Either a wide data matrix or long format data frame. In the wide (matrix) format, referred in this vignette as
data_matrix, rows represent features (for proteomics, peptides/fragments) and columns represent samples. In
the long format, referred in this vignette as df_long, each row is a measurement of a speciﬁc feature (peptide,
fragment) in the speciﬁc sample. At least three columns are required: feature ID column, measurement
(intensity) column and sample ID column. For batch correction, we also assume, that the imputed values,
e.g. requants in SWATH, are ﬂagged in quality column, such as m_score, so that they can be ﬁltered out
(see below).

In this vignette, the essential columns have the following names:

feature_id_col = 'peptide_group_label'
measure_col = 'Intensity'
sample_id_col = 'FullRunName'
essential_columns = c(feature_id_col, measure_col, sample_id_col)

The names of the columns can be technology-speciﬁc. These column names are speciﬁc to the OpenSWATH
tsv output format.

In the package, we provide the functionality to convert from long to matrix format (see section 2.2.4.1 “Utility
functions”).

Note that the sample IDs (column names in data_matrix) should match the values of the sample ID column
in sample_annotation and the feature ID column values should match the feature annotation table (here -
peptide_annotation). For OpenSWATH tsv ﬁle, which is a long format data frame, peptide_annotation
can be generated in the beginning of the analysis.

2) Sample annotation

A data frame, where one row corresponds to one sample (run/ﬁle), and the columns contain information
on biological and technical factors. Minimally, sample annotation has to contain a sample ID column, at
least one technical and one biological factor column, and a biological ID column (unique ID for the biological
replicate, which is repeated for each technical replicate).

In our example data, these columns are:

1. sample_id_col = 'FullRunName'
2. technical covariates:

• SacrificeDate - date when tissues were extracted

4

• ProteinPrepDate - date when samples were prepared
• RunDate (and RunTime, if available) - will be used to determine run order
• MS_batch - number of MS batches (in this case, sets of runs between machine cleaning)

3. biological covariates:

• Strain
• Diet
• Sex

4. biospecimen_id_col = "EarTag"

Thus, technical and biological factors are:
technical_covariates = c('MS_batch', 'digestion_batch', 'RunDate', 'RunTime')
biological_covariates = c('Strain', 'Diet', 'Sex', 'Age_Days')
biospecimen_id_col = "EarTag"

In the example dataset, you will also ﬁnd order column, which is, however, best inferred from the run
date/time with the corresponding function (see Utility functions below).

3) Feature (peptide) annotation

A dataframe, where one row corresponds to one feature (in MS proteomics - peptide or fragment), and
the columns are names of proteins and corresponding genes. Thus, the minimum columns are feature ID
(peptide_group_id) and name of corresponding protein (in this vignette, we use Gene name).

2.2.3 Example dataset

The proBatch package can be applied to any dataset, for which an intensity matrix and a sample annotation
tables are available. However, the package was primarily designed with proteomic data in mind, and thoroughly
tested on SWATH data. Thus, as and example dataset we include a reduced SWATH-MS measurement ﬁle,
generated from a BXD mouse aging study. In this study, the liver proteome of mouse from BXD reference
population have been proﬁled to identify proteome changes associated with aging. The animals of each strain
were subjected to Chow and High-Fat Diet and sacriﬁced at diﬀerent ages (the age factor is excluded from
the example data as age-related diﬀerences are the focus of an unpublished manuscript).

This dataset has a few features, that make it a good illustrative example: 1. This is a large dataset of
371 samples, that was aﬀected by multiple technical factors, described above in the sample_annotation
subsection. Speciﬁcally, 7 MS batches drive the similarity of the samples. 2. The technical factors bias the
data in at least two ways: discrete shifts (aﬀecting diﬀerent peptides in a batch-speciﬁc way), and continous
shifts from MS drift associated with sample running order. We will illustrate, how such biases can be corrected.
3. Replicate structure: samples from two animals were injected in the MS instrument every 10-15 samples.
Additionally, several samples were repeated back-to-back in the end and in the beginning of two consecutive
batches. This replication scheme allows to evaluate the coeﬃcient of variation and is highly beneﬁcial for
assessment of sample correlation.

The example SWATH data and annotation ﬁles can be loaded from the package with the function data().
library(proBatch)
data("example_proteome", "example_sample_annotation", "example_peptide_annotation",

package = "proBatch")

5

2.2.4 Preparing sample and peptide annotations

proBatch provides utility functions to facilitate the preparation of sample and peptide annotation. Feel free
to skip this section if you don’t require them.

2.2.4.1 Deﬁning the order of samples from running date and time

In proteomics, sequential measurement of samples may introduce order-related eﬀects. To facilitate the
examination of such eﬀects, it is necessary to deﬁne an order column in the sample annotation. Using the
date_to_sample_order() function one can infer sample order from the date and time of the measurements.

You can specify the columns illustrating date and time with time_column and their formats with the
dateTimeFormat parameters (see POSIX date format for reference).
generated_sample_annotation <- date_to_sample_order(example_sample_annotation,
time_column = c('RunDate','RunTime'),
new_time_column = 'generated_DateTime',
dateTimeFormat = c("%b_%d", "%H:%M:%S"),
new_order_col = 'generated_order',
instrument_col = NULL)

library(knitr)
kable(generated_sample_annotation[1:5,] %>%

select(c("RunDate", "RunTime", "order", "generated_DateTime", "generated_order")))

RunDate RunTime

order

generated_DateTime

generated_order

Oct_05
Oct_05
Oct_05
Oct_05
Oct_06

18:35:00
20:12:00
21:50:00
23:28:00
01:51:00

1
2
3
4
5

2019-10-05 18:35:00
2019-10-05 20:12:00
2019-10-05 21:50:00
2019-10-05 23:28:00
2019-10-06 01:51:00

1
2
3
4
5

The new time and order columns have been generated. Note that the generated_order has the same order as
the manually annotated order column.

2.2.4.2 Generating peptide annotation from OpenSWATH data

From the OpenSWATH output, you can generate peptide annotation using create_peptide_annotation()
by denoting the peptide ID with the feature_id_col and the annotation columns with the annotation_col
parameters.
generated_peptide_annotation <- create_peptide_annotation(example_proteome,

feature_id_col = 'peptide_group_label',
annotation_col = c('ProteinName', 'Gene'))

In practice, the generation of peptide annotation from proteomic data allows one to remove peptide annotation
columns from the intensity dataframe, thereby reducing the memory load, and can be achieved as follows:
example_proteome = example_proteome %>% select(one_of(essential_columns))
gc()
#>
#> Ncells 3380268 180.6
#> Vcells 6122152 46.8

(Mb)
4641849 248.0
76.5

used (Mb) gc trigger (Mb) max used

93.6 10022578

6896112 368.3

12255594

Additionally, smaller peptide annotation matrices allow for faster mapping of UniProt identiﬁers to gene
names and other IDs.

6

2.2.5 Other utility functions

2.2.5.1 Transforming the data to long or wide format

Plotting functions accept data in either data matrix or long data frame formats. Our package provides the
helper functions long_to_matrix() and matrix_to_long() to conveniently convert datasets back and forth.
example_matrix <- long_to_matrix(example_proteome)

2.2.5.2 Transforming the data to log scale

Additionally, if the data are expected to be log-transformed, one can:
log_transformed_matrix <- log_transform(example_matrix)

2.2.5.3 Deﬁning the color scheme

For color annotation, you ﬁrst assign colors to biological and technical covariates with sample_annotation_to_colors().
Using this function columns are assigned to factoric, non-factoric or numeric types to specify colors into
qualitative or sequential color scales.
color_scheme <- sample_annotation_to_colors (example_sample_annotation,

factor_columns = c('MS_batch','EarTag', "Strain", "Diet", "digestion_batch", "Sex"),
not_factor_columns = 'DateTime',
numeric_columns = c('order'))

color_list = color_scheme$list_of_colors

7

3 Step-by-step workﬂow

3.1 Initial assessment of the raw data matrix

Before any correction, it is informative to set the baseline of the data quality by examining global quantitative
patterns in the raw data matrix. Commonly, batch eﬀects manifest as batch-speciﬁc intensity distribution
changes.

In proteomics, batch-speciﬁc intensity drifts of sample mean can occur. Thus, it is important to carefully
keep track of the order of sample measurement. Order inference can be performed as shown in the previous
section “Deﬁning the order of samples from running date and time”. If the order column is not available
(order_col = NULL), the samples order in the sample annotation is used for plotting.

3.1.1 Plotting the sample mean

The plot_sample_mean() function illustrates global average vs. sample running order. This can be helpful
to visualize the global quantitative pattern and to identify discrepancies within or between batches.

batch_col = 'MS_batch'
plot_sample_mean(log_transformed_matrix, example_sample_annotation, order_col = 'order',

batch_col = batch_col, color_by_batch = TRUE, ylimits = c(12, 16),
color_scheme = color_list[[batch_col]])

We can clearly see down-sloping trends in the BXD aging dataset. In fact, during the data acquisition, the
mass-spectrometer had to be interrupted several times for tuning and/or column exchange as the signal was
decreasing.

8

1213141516050100150200orderAverage_IntensityMS_batchBatch_1Batch_2Batch_3Batch_43.1.2 Plotting boxplots

Alternatively, plot_boxplots() captures the global distribution vs. the sample running order.
log_transformed_long <- matrix_to_long(log_transformed_matrix)
batch_col = 'MS_batch'
plot_boxplot(log_transformed_long, example_sample_annotation,

batch_col = batch_col, color_scheme = color_list[[batch_col]])

In many cases, global quantitative properties such as sample medians or standard deviations won’t match. The
initial assessment via mean plots or boxplots can capture such information and hint at which normalization
method is better suitable. If the distributions are comparable, methods as simple as global median centering
can ﬁx the signal shift, while quantile normalization can help in case of divergent distributions.

9

05101520050100150200orderIntensityMS_batchBatch_1Batch_2Batch_3Batch_43.2 Normalization

In large-scale experiments, the total intensity of the samples is likely to be diﬀerent due to a number of
reasons, such as diﬀerent amount of sample loaded or ﬂuctuations in measurement instrument sensitivity.
To make samples comparable, they need to be scaled. This processed is called normalization. In proBatch,
two normalization approaches are used: median centering and quantile normalization. The normalization
function normalize_data() by default takes log-transformed data, and if needed, log-transformation can be
done on-the-ﬂy by specifying log_base = 2 for log2-transformation.

3.2.1 Median normalization

Median normalization is a conservative approach that shifts the intensity of the sample to the global median
of the experiment. If the distributions of samples are dramatically diﬀerent and this cannot be explained by
non-technical factors, such as heterogeneity of samples, other approaches, such as quantile normalization
need to be used.
median_normalized_matrix = normalize_data(log_transformed_matrix,

normalizeFunc = "medianCentering")

Same result will be achieved with:
median_normalized_matrix = normalize_data(example_matrix,

normalizeFunc = "medianCentering", log_base = 2)

3.2.2 Quantile normalization

Quantile normalization sets diﬀerent distributions of individual samples to the same quantiles, which forces
the distribution of the raw signal intensities to be the same in all samples. This method is computationally
eﬀective and has simple assumption that the majority of features (genes, proteins) is constant among the
samples, thus also the distribution in principle are identical.
quantile_normalized_matrix = normalize_data(log_transformed_matrix,

normalizeFunc = "quantile")

After quantile or median normalization, you can easily check if the global pattern improved by generating
mean or boxplots and comparing them side by side. Here are the mean plots before and after normalization
of the log transformed dataset.
plot_sample_mean(quantile_normalized_matrix, example_sample_annotation,

color_by_batch = TRUE, ylimits = c(12, 16),
color_scheme = color_list[[batch_col]])

10

1213141516050100150200orderAverage_IntensityMS_batchBatch_1Batch_2Batch_3Batch_43.3 Diagnostics of batch eﬀects in normalized data

Now is the time to diagnose for batch eﬀects and evaluate to what extent technical variance still exists in
the normalized data matrix. The positive eﬀect of normalization is sometimes not suﬃcient to control for
peptide and protein-speciﬁc biases associated with a certain batch source. These biases can be identiﬁed via
diagnostic plots. Here, we describe our essential toolbox of batch eﬀect diagnostic approaches. Note that
sample annotation and/or peptide annotation are necessary for the implementation of these plots.

3.3.1 Hierarchical clustering

Hierarchical clustering is an algorithm that groups similar samples into a tree-like structure called dendrogram.
Similar samples cluster together and the driving force of this similarity can be visualized by coloring the
leaves of the dendrogram by technical and biological variables.

Our package provides plot_sample_clustering() and plot_heatmap() to plot the dendrogram by itself or
with a heatmap. You can easily color annotations on the leaves of the dendrograms or heatmaps to identify
what is the driving force of the clustering.

Once your color annotation is ready, for the speciﬁc covariates of interest, you can subset the color dataset
and feed it into the clustering functions.
color_annotation <- color_scheme$color_df
selected_annotations <- c("MS_batch",
#select only a subset of samples for plotting
color_annotation <- color_annotation %>% select(one_of(selected_annotations))

"digestion_batch", "Diet")

#Plot clustering between samples
plot_hierarchical_clustering(quantile_normalized_matrix, color_annotation,

distance = "euclidean", agglomeration = 'complete',
label_samples = FALSE)

Similarly, you can plot a heatmap by supplementing the color list. You decide whether to show anno-
tations in the column, row or both by specifying the required covariates with sample_annotation_col,
sample_annoation_row, or both.

11

10203040hclust (*, "complete")dist_matrixHeightMS_batchdigestion_batchDietplot_heatmap(quantile_normalized_matrix, example_sample_annotation,

sample_annotation_col = selected_annotations,
cluster_cols = TRUE,
annotation_color_list = color_scheme$list_of_colors,
show_rownames = FALSE, show_colnames = FALSE)

From the clustering analysis, we can clearly see that the driving force behind the sample clustering is the MS
batch.

12

MS_batchdigestion_batchDietDietCDHFdigestion_batch1234MS_batchBatch_1Batch_2Batch_3Batch_45101520MS_batchdigestion_batchDietDietCDHFdigestion_batch1234MS_batchBatch_1Batch_2Batch_3Batch_451015203.3.2 Principal component analysis (PCA)

PCA is a technique that identiﬁes the leading directions of variation, known as principal components. The
projection of data on two principal components allows to visualize sample proximity. This technique is
particularly convenient to assess replicate similarity.

You can identify the covariate leading the direction of variations by coloring potential candidates.
plot_PCA(quantile_normalized_matrix, example_sample_annotation, color_by = 'MS_batch',

plot_title = "MS batch", colors_for_factor = color_list[[batch_col]])

plot_PCA(quantile_normalized_matrix, example_sample_annotation, color_by = "digestion_batch",
plot_title = "Digestion batch", colors_for_factor = color_list[["digestion_batch"]])

plot_PCA(quantile_normalized_matrix, example_sample_annotation, color_by = "Diet",
plot_title = "Diet", colors_for_factor = color_list[["Diet"]])

By plotting the ﬁrst two principal components and applying diﬀerent color overlaps, we see once again that
the clusters overlap nicely with the MS batches.

13

−0.10−0.050.000.050.10−0.10−0.050.000.050.10PC1 (18.94%)PC2 (13.95%)MS_batchBatch_1Batch_2Batch_3Batch_4MS batch−0.10−0.050.000.050.10−0.10−0.050.000.050.10PC1 (18.94%)PC2 (13.95%)digestion_batch1234Digestion batch−0.10−0.050.000.050.10−0.10−0.050.000.050.10PC1 (18.94%)PC2 (13.95%)DietCDHFDiet3.3.3 Principal variance component analysis (PVCA)

The main advantage of this approach is the quantiﬁcation of the variance, associated with both technical
and biological covariates. Brieﬂy, principal variance component analysis uses a linear model to match each
principal component to the sources of variation and weighs the variance of each covariate by the eigenvalue of
the PC [7]. Thus, the resulting value reﬂects the variance explained by that covariate.

NB: PVCA calculation is a computationally demanding procedure. For a data matrix of several hundred
samples and several thousands of peptides it can easily take several hours. So it is generally a good idea to
run this analysis as a stand-alone script on a powerful machine.
pvca <- plot_PVCA(quantile_normalized_matrix, example_sample_annotation,

technical_covariates = c('MS_batch', 'digestion_batch'),
biological_covariates = c(biological_covariates, biospecimen_id_col))

The biggest proportion of variance in the peptide measurement was derived from mass spectrometry batches.
In a typical experiment, the overall magnitude of variances coming from biological factors should be high
while technical variance should be kept at minimum1.

1Application of hierarchical clustering, PCA and PVCA in their classical implementation is not possible if missing values are
present in the matrix. It has been noticed previously that missing values can be associated with technical bias [8], and most
commonly, it is suggested that missing values need to be imputed [8-9]. However, we would like to suggest to use missing value
imputation with extreme caution. First of all, missing value imputation alters the sample proximity. Additionally, imputed
missing values, which can be obtained for SWATH data, can alter the correction of the batches.

14

3.3.4 Peptide-level diagnostics and spike-ins

Feature-level diagnostics are very informative for batch eﬀect correction. To assess the bias in the data, one
can choose a feature (peptide, protein, gene), the quantitative behaviour of which is known. In our package,
plot_peptides_of_one_protein() allows plotting peptides of interest e.g. from biologically well understood
protein. If spike-in proteins or peptides have been added to the mixture, one can use the plot_spike_ins()
function instead. In most DIA datasets iRT peptides [10] are added in controlled quantities and can be
visualized with the plot_iRT() function.

In mass-spectrometry, also the trends associated with this order can be assessed for a few representative
peptides, thus the order column is also important for this diagnostics.
quantile_normalized_long <- matrix_to_long(quantile_normalized_matrix, example_sample_annotation)
plot_spike_in(quantile_normalized_long, example_sample_annotation,

peptide_annotation = generated_peptide_annotation,
protein_col = 'Gene', spike_ins = "BOVINE_A1ag",
plot_title = 'Spike-in BOVINE protein peptides',
color_by_batch = TRUE, color_scheme = color_list[[batch_col]])

It is clear that while the pre-determined quantities of spike-ins or peptides of known biology have their
expected intensities, the trend is dominated by mass spectrometry signal drift. After conﬁrming either
continuous or discrete batch eﬀects exist in a dataset, by one or more of these methods, proceed by selecting
a batch correction method.

15

61657_VESDREHFVDLLLSK_4656_AIQAAFFYLEPR_2657_AIQAAFFYLEPR_37190_KEFLDVIK_23102_EHFVDLLLSK_33803_EYQTIEDK_246213_NVGVSFYADKPEVTQEQK_246215_NVGVSFYADKPEVTQEQKK_41724_DAC(UniMod:4)GPLEK_222679_HAEDKLITR_22972_EFLDVIK_23101_EHFVDLLLSK_210062_NVGVSFYADKPEVTQEQK_310063_NVGVSFYADKPEVTQEQKK_313104_VESDREHFVDLLLSK_314265_WFYIGSAFR_205010015020005010015020005010015020005010015020015.017.520.022.5151617181617181915.015.516.016.517.018.519.019.520.019.520.020.521.021.51516171817.017.518.018.519.016171819912151818192020.521.021.522.01920211819201516171818.018.519.019.520.0orderIntensityMS_batchBatch_1Batch_2Batch_3Batch_4Spike−in BOVINE protein peptides3.4 Correction of batch eﬀects

Depending on the type of batch eﬀects, diﬀerent batch correction methods should be implemented. In most
cases, batch-speciﬁc signal shift needs to be corrected. For this case, feature median-centering can be applied,
or, to use across-feature information in a Bayesian framework, the ComBat approach can be used. If there is
continuous drift in the data, one has to start from continuous drift correction.

3.4.1 Continuous drift correction

Continuous drifts are speciﬁc to mass-spectrometry, thus, the user-friendly methods for its correction have
not been implemented before. In this package, we suggest a novel procedure to correct for MS signal drift.
We developed a procedure based on nonlinear LOESS ﬁtting. For each peptide and each batch, a non-linear
trend is ﬁtted to the normalized data and this trend is subtracted to correct for within-batch variation. Note,
that the resulting data are not batch-free as within-batch means and variances are batch-dependent. However,
now the batches are discrete and thus can be corrected using discrete methods such as median-centering or
ComBat.
loess_fit <- adjust_batch_trend(quantile_normalized_matrix, example_sample_annotation)
loess_fit_matrix <- loess_fit$data_matrix

One important parameter in LOESS ﬁtting is span, which determines the degree of smoothing. The LOESS
span ranges from 0 to 1: the greater the value of span, the smoother is the ﬁtted curve. Since we want the
curve to reﬂect signal drift, we want to avoid overﬁtting but be sensitive to ﬁt the trend accurately. Currently,
we suggest to evaluate several peptides to determine the best smoothing degree for a given dataset.
loess_fit_30 <- adjust_batch_trend(quantile_normalized_matrix, example_sample_annotation, span = 0.3)

quantile_normalized_long <- matrix_to_long(quantile_normalized_matrix)
plot_with_fitting_curve(pep_name = "10231_QDVDVWLWQQEGSSK_2",

df_long = quantile_normalized_long, example_sample_annotation,
color_by_batch = TRUE, color_scheme = color_list[[batch_col]],
fit_df = loess_fit_30$fit_df, plot_title = "Span = 30%")

loess_fit_70 <- adjust_batch_trend(quantile_normalized_matrix, example_sample_annotation, span = 0.7)
plot_with_fitting_curve(pep_name = "10231_QDVDVWLWQQEGSSK_2",

df_long = quantile_normalized_long, example_sample_annotation,
color_by_batch = TRUE, color_scheme = color_list[[batch_col]],
fit_df = loess_fit_70$fit_df, plot_title = "Span = 70%")

16

15.015.516.016.5050100150200orderIntensityMS_batchBatch_1Batch_2Batch_3Batch_4Span = 30%Curve ﬁtting is largely dependent on the number of consecutive measurements. In proteomics, missing values
are not uncommon. If too many points are missing, a curve cannot be ﬁt accurately. This is especially
common for small batches. In this case, we suggest to not ﬁt the curve to the speciﬁc peptide within the
speciﬁc batch, and proceed directly to discrete correction methods. To identify such peptides, absolute and
relative thresholds (abs.threshold and pct.threshold) on the number of missing values for each peptide
can be passed as parameters to normalize_custom_fit().

3.4.2 Discrete batch correction: combat or peptide-level median centering

Once the data are normalized and corrected for continuous drift, only discrete batch eﬀects is left to be
corrected.

Currently, both batch correction procedures accept long format of the data:
loess_fit_df <- matrix_to_long(loess_fit_matrix)

3.4.2.1 Feature-level median centering

Feature-level median centering is the simplest approach for batch eﬀects correction. However, if the variance
is diﬀerent between batches, other approaches need to be used.
peptide_median_df <- center_peptide_batch_medians(loess_fit_df, example_sample_annotation)
plot_single_feature(pep_name = "10231_QDVDVWLWQQEGSSK_2", df_long = peptide_median_df,

example_sample_annotation, color_by_col = NULL, measure_col = 'Intensity_normalized',
plot_title = "Feature-level Median Centered")

17

15.015.516.016.5050100150200orderIntensityMS_batchBatch_1Batch_2Batch_3Batch_4Span = 70%15.015.516.016.5050100150200orderIntensity_normalizedFeature−level Median Centered3.4.2.2 ComBat

ComBat is well-suited for batches with distinct distributions, but restricted to peptides that don’t have
missing batch measurements. ComBat, uses parametric and non-parametric empirical Bayes framework for
adjusting data for batch eﬀects [11]. The function correct_with_ComBat() can incorporate several covariates
and make data comparable across batches.
comBat_matrix <- correct_with_ComBat(loess_fit_matrix, example_sample_annotation)
#> Standardizing Data across genes

To illustrate the correction we use the “10231_QDVDVWLWQQEGSSK_2” spike-in peptide.
combat_df <- matrix_to_long(comBat_matrix)
plot_single_feature (pep_name = "10231_QDVDVWLWQQEGSSK_2", loess_fit_df,

example_sample_annotation, plot_title = "Loess Fitted", color_by_col = NULL)

plot_single_feature (pep_name = "10231_QDVDVWLWQQEGSSK_2", combat_df,

example_sample_annotation, plot_title = "ComBat corrected", color_by_col = NULL)

ComBat ﬁxed the discrete batch eﬀects and also made the distributions between batches similar to one
another.

3.4.3 Correct batch eﬀects: universal function

We provide a convenient all-in-one function for batch correction. The function correct_batch_effects()
corrects MS signal drift and discrete shift in a single function call. Simply specify which discrete correction
method is preferred at discreteFunc either “ComBat” or “MedianCentering” and supplement other arguments
such as span, abs.threshold or pct.threshold as in normalize_custom_fit().
batch_corrected_matrix <- correct_batch_effects(data_matrix = quantile_normalized_matrix,

example_sample_annotation, discreteFunc = 'ComBat',
abs.threshold = 5, pct.threshold = 0.20)

#> Standardizing Data across genes

18

15.015.516.016.5050100150200orderIntensityLoess Fitted15.516.016.5050100150200orderIntensityComBat corrected3.5 Quality control on batch-corrected data matrix

In most cases, the batch eﬀects correction method is evaluated by its ability to remove technical confounding,
visible on hierarchical clustering or PCA. However, it is rarely shown whether the biological signal is not
destroyed, or, better even, improved. Often, and increase in the number of diﬀerentially expressed genes is
presented as an improvement. However, every reasonably designed experiment has replicates that can serve
as an excellent control. In addition, peptides within a given protein should behave similarly and correlation
of these peptides should improve after batch correction.

3.5.1 Heatmap of selected replicate samples

In this study, 10 samples were run in the same order before and after the tuning of the mass-spectrometer,
which marks the boundary between batches 2 and 3. The correlation between these replicates can be illustrated
by corrplot (flavor = 'corrplot') or by “pretty heatmap”, of “pheatmap” (flavor = 'pheatmap')

First, we specify, which samples we want to correlate
earTags <- c("ET1524", "ET2078", "ET1322", "ET1566", "ET1354", "ET1420", "ET2154",
"ET1515", "ET1506", "ET2577", "ET1681", "ET1585", "ET1518", "ET1906")

# Prepare color annotation
factors_to_show = c("MS_batch", "EarTag")
replicate_annotation <- example_sample_annotation %>%

filter(MS_batch == 'Batch_2' | MS_batch == "Batch_3") %>%
filter(EarTag %in% earTags) %>%
remove_rownames() %>%
column_to_rownames(var="FullRunName") %>%
select(factors_to_show) # Annotate MS_batch and EarTag on pheatmap

# sample ID of biological replicates
replicate_filenames = replicate_annotation %>%

rownames()

breaksList <- seq(0.7, 1, by = 0.01) # color scale of pheatmap
heatmap_colors = colorRampPalette(

rev(RColorBrewer::brewer.pal(n = 7, name = "RdYlBu")))(length(breaksList))

# Plot the heatmap
plot_sample_corr_heatmap(quantile_normalized_matrix, samples_to_plot = replicate_filenames,

flavor = 'pheatmap', plot_title = 'Quantile Normalized',
annotation_colors = color_list[factors_to_show],
annotation_col = replicate_annotation,
color = heatmap_colors, breaks = breaksList,
cluster_rows= FALSE, cluster_cols=FALSE,fontsize = 4,
annotation_names_col = TRUE, annotation_legend = FALSE,
show_colnames = FALSE)

plot_sample_corr_heatmap(batch_corrected_matrix, samples_to_plot = replicate_filenames,

flavor = 'pheatmap', plot_title = 'Batch Corrected',
annotation_colors = color_list[factors_to_show],
annotation_col = replicate_annotation,
color = heatmap_colors, breaks = breaksList,
cluster_rows=FALSE, cluster_cols=FALSE,fontsize = 4,
annotation_names_col = TRUE, annotation_legend = FALSE,

19

show_colnames = FALSE)

Before the correction, samples from one batch correlate better and of ten higher than the replicates. However,
after the correction, the correlation between replicates becomes higher than the correlation between non-related
samples regardless of the batch.

3.5.2 Correlation distribution of samples

For example, in the mice aging experiment, biological replicates, ET1506 and ET1524, were injected every
30-40 MS runs. The correlation between these biological replicates should improve after normalization and
batch correction.

The plot_sample_corr_distribution() function plots correlation distribution between biological replicates
and non-replicates in the same or diﬀerent batches by plot_param = 'batch_replicate'. Alternatively,
you can compute the correlation between diﬀerent batches by plot_param = 'batches'.

It should be noted, however, that the comparison of sample correlation should not be approached by
evaluating the individual examples of within-replicate vs within-batch corrections, but rather by comparing
the distribution. Unless these examples are shown in the context of the whole distribution structure, they can
lead to erroneous conclusion. The sample correlation is often used to prove the quality of the measurement, as
it is typically very high (examples of the replicate correlation above .95 are common for mass spectrometry).
sample_cor_norm <- plot_sample_corr_distribution(quantile_normalized_matrix,
example_sample_annotation,
batch_col = 'MS_batch',
biospecimen_id_col = "EarTag",
plot_title = 'Quantile normalized',
plot_param = 'batch_replicate')

sample_cor_norm + theme(axis.text.x = element_text(angle = 45, hjust = 1)) + ylim(0.7,1)

sample_cor_batchCor <- plot_sample_corr_distribution(batch_corrected_matrix,

example_sample_annotation,
batch_col = 'MS_batch',
plot_title = 'Batch corrected',
plot_param = 'batch_replicate')

sample_cor_batchCor + theme(axis.text.x = element_text(angle = 45, hjust = 1)) + ylim(0.7, 1)

20

Quantile NormalizedI171016_BXD89_CD_ET2078_Run115I171016_BXD39_CD_ET1322_Run116I171016_BXD95_CD_ET1566_Run117I171016_BXD99_CD_ET1354_Run118I171016_BXD101_HF_ET1420_Run119I171016_BXD43_CD_ET2154_Run120I171016_BXD51_HF_ET1515_Run121I171016_BXD73_HF_ET1506_Run122I171016_BXD9_CD_ET2577_Run123I171016_C57BL6J_HF_ET1681_Run124I171016_C57BL6J_CD_ET1585_Run125I171016_BXD51_CD_ET1518_Run126I171016_BXD73_CD_ET1906_Run128I171016_Run131_BXD98_CD_ET1524_CTRLI171022_Run132_BXD98_CD_ET1524_CTRLI171022_Run133_BXD89_CD_ET2078I171022_Run134_BXD39_CD_ET1322I171022_Run135_BXD95_CD_ET1566I171022_Run136_BXD99_CD_ET1354I171022_Run137_BXD101_HF_ET1420I171022_Run138_BXD43_CD_ET2154I171022_Run139_BXD51_HF_ET1515I171022_Run140_BXD73_HF_ET1506I171022_Run141_BXD9_CD_ET2577I171022_Run142_C57BL6J_HF_ET1681I171022_Run143_C57BL6J_CD_ET1585I171022_Run144_BXD51_CD_ET1518I171022_Run146_BXD73_CD_ET1906I171022_Run166_BXD98_CD_ET1524_CTRLI171025_Run200_BXD98_CD_ET1524MS_batchEarTag0.70.750.80.850.90.951Batch CorrectedI171016_BXD89_CD_ET2078_Run115I171016_BXD39_CD_ET1322_Run116I171016_BXD95_CD_ET1566_Run117I171016_BXD99_CD_ET1354_Run118I171016_BXD101_HF_ET1420_Run119I171016_BXD43_CD_ET2154_Run120I171016_BXD51_HF_ET1515_Run121I171016_BXD73_HF_ET1506_Run122I171016_BXD9_CD_ET2577_Run123I171016_C57BL6J_HF_ET1681_Run124I171016_C57BL6J_CD_ET1585_Run125I171016_BXD51_CD_ET1518_Run126I171016_BXD73_CD_ET1906_Run128I171016_Run131_BXD98_CD_ET1524_CTRLI171022_Run132_BXD98_CD_ET1524_CTRLI171022_Run133_BXD89_CD_ET2078I171022_Run134_BXD39_CD_ET1322I171022_Run135_BXD95_CD_ET1566I171022_Run136_BXD99_CD_ET1354I171022_Run137_BXD101_HF_ET1420I171022_Run138_BXD43_CD_ET2154I171022_Run139_BXD51_HF_ET1515I171022_Run140_BXD73_HF_ET1506I171022_Run141_BXD9_CD_ET2577I171022_Run142_C57BL6J_HF_ET1681I171022_Run143_C57BL6J_CD_ET1585I171022_Run144_BXD51_CD_ET1518I171022_Run146_BXD73_CD_ET1906I171022_Run166_BXD98_CD_ET1524_CTRLI171025_Run200_BXD98_CD_ET1524MS_batchEarTag0.70.750.80.850.90.9513.5.3 Correlation of peptide distributions within and between proteins

Peptides of the same protein are likely to correlate. Therefore, we can compare within- vs between-protein
peptide correlation before and after batch correction to check if the correlation of peptides between the same
proteins increases while that of diﬀerent proteins stays the same.

NB: For a data matrix containing several thousands of peptides, calculation of peptide correlation is a
computationally demanding procedure. It can easily take several hours. Therefore, it is generally recommended
to run this analysis as a stand-alone script on a powerful machine.

The plot_peptide_corr_distribution() function plots correlation distribution between peptides of the
same protein. However, an improvement of peptide correlation may not be clearly exhibited for a reduced
dataset.
peptide_cor_norm <- plot_peptide_corr_distribution(quantile_normalized_matrix,

generated_peptide_annotation, protein_col = 'Gene', plot_title = 'Quantile normalized')

peptide_cor_norm + geom_hline(yintercept=0, linetype="dashed", color = "grey")

peptide_cor_batchCor <- plot_peptide_corr_distribution(batch_corrected_matrix,

generated_peptide_annotation, protein_col = 'Gene', plot_title = 'Batch corrected')

peptide_cor_batchCor + geom_hline(yintercept=0, linetype="dashed", color = "grey")

21

0.70.80.91.0diff_batchdiff_biospecimensame_batchdiff_biospecimensame_batchsame_biospecimensame_biospecimendiff_batchbatch_replicatecorrelationQuantile normalized0.70.80.91.0diff_batchdiff_biospecimensame_batchdiff_biospecimensame_batchsame_biospecimensame_biospecimendiff_batchbatch_replicatecorrelationBatch correctedHere shows peptide correlation distribution generated from a complete dataset of the BXD mouse aging
study:

4 SessionInfo

sessionInfo()
#> R version 3.6.0 (2019-04-26)
#> Platform: x86_64-pc-linux-gnu (64-bit)
#> Running under: Ubuntu 18.04.2 LTS
#>
#> Matrix products: default
#> BLAS:
#> LAPACK: /home/biocbuild/bbs-3.9-bioc/R/lib/libRlapack.so
#>
#> locale:
#> [1] LC_CTYPE=en_US.UTF-8

/home/biocbuild/bbs-3.9-bioc/R/lib/libRblas.so

LC_NUMERIC=C

22

datasets

methods

base

tibble_2.1.1

LC_COLLATE=C
LC_MESSAGES=en_US.UTF-8
LC_NAME=C
LC_TELEPHONE=C

graphics

grDevices utils

proBatch_1.0.0 ggplot2_3.1.1

bitops_1.0-6
robust_0.4-18
doParallel_1.0.14

[1] nlme_3.1-139
[4] lubridate_1.7.4
[7] bit64_0.9-7

#> [3] LC_TIME=en_US.UTF-8
#> [5] LC_MONETARY=en_US.UTF-8
#> [7] LC_PAPER=en_US.UTF-8
#> [9] LC_ADDRESS=C
#> [11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C
#>
#> attached base packages:
#> [1] stats
#>
#> other attached packages:
#> [1] knitr_1.22
#> [5] dplyr_0.8.0.1
#>
#> loaded via a namespace (and not attached):
#>
#>
#>
#> [10] dynamicTreeCut_1.63-1 tools_3.6.0
#> [13] R6_2.4.0
#> [16] Hmisc_4.2-0
#> [19] BiocGenerics_0.30.0
#> [22] withr_2.1.2
#> [25] bit_1.1-14
#> [28] WGCNA_1.67
#> [31] labeling_0.3
#> [34] DEoptimR_1.0-8
#> [37] genefilter_1.66.0
#> [40] digest_0.6.18
#> [43] rrcov_1.4-7
#> [46] htmltools_0.3.6
#> [49] htmlwidgets_1.3
#> [52] RSQLite_2.1.1
#> [55] acepack_1.4.1
#> [58] GO.db_3.8.2
#> [61] Rcpp_1.0.1
#> [64] viridis_0.5.1
#> [67] MASS_7.3-51.4
#> [70] blob_1.1.1
#> [73] lattice_0.20-38
#> [76] hms_0.4.2
#> [79] reshape2_1.4.3
#> [82] XML_3.98-1.19
#> [85] latticeExtra_0.6-28
#> [88] foreach_1.4.4
#> [91] tidyr_0.8.3
#> [94] xtable_1.8-4
#> [97] viridisLite_0.3.0
#> [100] AnnotationDbi_1.46.0
#> [103] cluster_2.0.9
#> [106] ggfortify_0.4.6

rpart_4.1-15
DBI_1.0.0
colorspace_1.4-1
tidyselect_0.2.5
compiler_3.6.0
Biobase_2.44.0
scales_1.0.0
mvtnorm_1.0-10
readr_1.3.1
foreign_0.8-71
base64enc_0.1-3
limma_3.40.0
rlang_0.3.4
impute_1.58.0
RCurl_1.95-4.12
Formula_1.2-3
munsell_0.5.0
stringi_1.4.3
plyr_1.8.4
parallel_3.6.0
splines_3.6.0
pillar_1.3.1
codetools_0.2-16
glue_1.3.1
data.table_1.12.2
gtable_0.3.0
assertthat_0.2.1
survival_2.44-1.1
pheatmap_1.0.12
memoise_1.1.0
corrplot_0.84

matrixStats_0.54.0
fit.models_0.5-14
RColorBrewer_1.1-2
backports_1.1.4
mgcv_1.8-28
lazyeval_0.2.2
nnet_7.3-12
gridExtra_2.3
preprocessCore_1.46.0
htmlTable_1.13.1
checkmate_1.9.1
robustbase_0.93-4
stringr_1.4.0
rmarkdown_1.12
pkgconfig_2.0.2
highr_0.8
rstudioapi_0.10
BiocParallel_1.18.0
magrittr_1.5
Matrix_1.2-17
S4Vectors_0.22.0
yaml_2.2.0
grid_3.6.0
crayon_1.3.4
annotate_1.62.0
fastcluster_1.1.25
stats4_3.6.0
evaluate_0.13
png_0.1-7
purrr_0.3.2
xfun_0.6
pcaPP_1.9-73
iterators_1.0.10
IRanges_2.18.0
sva_3.32.0

23

Cuklina J., Lee C.H., Williams E.G., Collins B., Sajic T.,
Pedrioli P., Rodriguez-Martinez M., Aebersold R. Chapter 3:
Systematic overview of batch effects in proteomics Doctoral
thesis, ETH Zurich, 2018
https://doi.org/10.3929/ethz-b-000307772

5 Citation

To cite this package, please use:
citation('proBatch')
#>
#> To cite proBatch in publications use:
#>
#>
#>
#>
#>
#>
#>
#> A BibTeX entry for LaTeX users is
#>
#>
#>
#>
#>
#>
#>
#>

@PhdThesis{,

}

title = {Computational challenges in biomarker discovery from high-throughput proteomic data},
author = {Jelena Cuklina and Chloe H. Lee and Evan G. Willams and Ben Collins and Tatjana Sajic and Patrick Pedrioli and Maria Rodriguez-Martinez and Ruedi Aebersold},
url = {https://doi.org/10.3929/ethz-b-000307772},
school = {ETH Zurich},
year = {2018},

24

6 References

[1] O. T. Schubert, H. L. Röst, B. C. Collins, G.Rosenberger, and R. Aebersold. «Quantitative proteomics:
challenges and opportunities in basic and applied research». Nature Protocols 12:7 (2017), pp. 1289–1294.

[2] E. G. Williams, Y. Wu, P. Jha et al. «Systems proteomics of liver mitochondria function». Science
352:6291 (2016), aad0189.

[3] Y. Liu, A. Buil, B. C. Collins et al. «Quantitative variability of 342 plasma proteins in a human twin
population». Molecular Systems Biology 11:2 (2015), pp. 786–786.

[4] H. L. Rost, G. Rosenberger, P. Navarro et al. «OpenSWATH enables automated, targeted analysis of
data-independent acquisition MS data.» Nature biotechnology 32:3 (2014), pp. 219–23.

[5] P. G. Pedrioli, «Trans-Proteomic Pipeline: A Pipeline for Proteomic Analysis.» Methods in Molecular
Biology Proteome Bioinformatics, May 2009, pp. 213–238.

[6] G. Rosenberger et al. «Statistical control of peptide and protein error rates in large-scale targeted
data-independent acquisition analysis.» Nature Methods 14:9 (2017), pp. 921–927.

[7] P. R. Bushel. pvca: Principal Variance Component Analysis (PVCA). Package version 1.18.0. 2013.

[8] Y. V. Karpievitch, A. R. Dabney, and R. D. Smith. «Normalization and missing value imputation for
label-free LC-MS analysis». BMC Bioinformatics 13:Suppl 16 (2012), S5.

[9] S. Tyanova, T. Temu, P. Sinitcyn et al. «The Perseus computational platform for comprehensive analysis
of (prote)omics data». Nat Methods 13:9 (2016), pp. 731–740.

[10] C. Escher, L. Reiter, B. Maclean et al. «Using iRT, a normalized retention time for more targeted
measurement of peptides». Proteomics 12:8 (2012), pp. 1111–1121.

[11] A. W. B. Johnston, Y. Li, and L. Ogilvie. «Metagenomic marine nitrogen ﬁxation–feast or famine?»
Trends in microbiology 13:9 (2005), pp. 416–20.

25

