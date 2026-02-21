# SECOM Tutorial

#### Huang Lin\(^1\)

#### \(^1\)University of Maryland, College Park, MD 20742

#### October 29, 2025

```
knitr::opts_chunk$set(message = FALSE, warning = FALSE, comment = NA,
                      fig.width = 6.25, fig.height = 5)
library(ANCOMBC)
library(tidyverse)
```

```
get_upper_tri = function(cormat){
    cormat[lower.tri(cormat)] = NA
    diag(cormat) = NA
    return(cormat)
}
```

# 1. Introduction

Sparse Estimation of Correlations among Microbiomes (SECOM) (Lin, Eggesbø, and Peddada 2022) is a methodology that aims to detect both linear and nonlinear relationships between a pair of taxa within an ecosystem (e.g., gut) or across ecosystems (e.g., gut and tongue). SECOM corrects both sample-specific and taxon-specific biases and obtains a consistent estimator for the correlation matrix of microbial absolute abundances while maintaining the underlying true sparsity. For more details, please refer to the [SECOM](https://doi.org/10.1038/s41467-022-32243-x) paper.

# 2. Installation

Download package.

```
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("ANCOMBC")
```

Load the package.

```
library(ANCOMBC)
```

# 3. Example Data

The HITChip Atlas dataset contains genus-level microbiota profiling with HITChip for 1006 western adults with no reported health complications, reported in (Lahti et al. 2014). The dataset is available via the microbiome R package (Lahti et al. 2017) in phyloseq (McMurdie and Holmes 2013) format.

```
data(atlas1006, package = "microbiome")

# Subset to baseline
pseq = phyloseq::subset_samples(atlas1006, time == 0)

# Re-code the bmi group
meta_data = microbiome::meta(pseq)
meta_data$bmi = recode(meta_data$bmi_group,
                       obese = "obese",
                       severeobese = "obese",
                       morbidobese = "obese")

# Note that by default, levels of a categorical variable in R are sorted
# alphabetically. In this case, the reference level for `bmi` will be
# `lean`. To manually change the reference level, for instance, setting `obese`
# as the reference level, use:
meta_data$bmi = factor(meta_data$bmi, levels = c("obese", "overweight", "lean"))
# You can verify the change by checking:
# levels(meta_data$bmi)

# Create the region variable
meta_data$region = recode(as.character(meta_data$nationality),
                          Scandinavia = "NE", UKIE = "NE", SouthEurope = "SE",
                          CentralEurope = "CE", EasternEurope = "EE",
                          .missing = "unknown")

phyloseq::sample_data(pseq) = meta_data

# Subset to lean, overweight, and obese subjects
pseq = phyloseq::subset_samples(pseq, bmi %in% c("lean", "overweight", "obese"))
# Discard "EE" as it contains only 1 subject
# Discard subjects with missing values of region
pseq = phyloseq::subset_samples(pseq, ! region %in% c("EE", "unknown"))

print(pseq)
```

```
phyloseq-class experiment-level object
otu_table()   OTU Table:         [ 130 taxa and 873 samples ]
sample_data() Sample Data:       [ 873 samples by 12 sample variables ]
tax_table()   Taxonomy Table:    [ 130 taxa by 3 taxonomic ranks ]
```

# 4. Run SECOM on a Single Ecosystem

## 4.1 Run secom functions using the `phyloseq` object

```
set.seed(123)
# Linear relationships
res_linear = secom_linear(data = list(pseq), taxa_are_rows = TRUE,
                          tax_level = "Phylum",
                          aggregate_data = NULL, meta_data = NULL, pseudo = 0,
                          prv_cut = 0.5, lib_cut = 1000, corr_cut = 0.5,
                          wins_quant = c(0.05, 0.95), method = "pearson",
                          soft = FALSE, thresh_len = 20, n_cv = 10,
                          thresh_hard = 0.3, max_p = 0.005, n_cl = 2)

# Nonlinear relationships
res_dist = secom_dist(data = list(pseq), taxa_are_rows = TRUE,
                      tax_level = "Phylum",
                      aggregate_data = NULL, meta_data = NULL, pseudo = 0,
                      prv_cut = 0.5, lib_cut = 1000, corr_cut = 0.5,
                      wins_quant = c(0.05, 0.95), R = 1000,
                      thresh_hard = 0.3, max_p = 0.005, n_cl = 2)
```

Sparsity can be increased by adjusting the L1 penalty parameters in `alpha_grid`.

```
set.seed(123)
# Linear relationships
res_linear2 = secom_linear(data = list(pseq), taxa_are_rows = TRUE,
                           tax_level = "Phylum",
                           aggregate_data = NULL, meta_data = NULL, pseudo = 0,
                           prv_cut = 0.5, lib_cut = 1000, corr_cut = 0.5,
                           wins_quant = c(0.05, 0.95), method = "pearson",
                           soft = FALSE, alpha_grid = 0.1,
                           thresh_len = 20, n_cv = 10,
                           thresh_hard = 0.3, max_p = 0.005, n_cl = 2)
```

## 4.2 Visualizations

### Pearson correlation with thresholding

```
corr_linear = res_linear$corr_th
cooccur_linear = res_linear$mat_cooccur

# Filter by co-occurrence
overlap = 10
corr_linear[cooccur_linear < overlap] = 0

df_linear = data.frame(get_upper_tri(corr_linear)) %>%
  rownames_to_column("var1") %>%
  pivot_longer(cols = -var1, names_to = "var2", values_to = "value") %>%
  filter(!is.na(value)) %>%
  mutate(value = round(value, 2))

tax_name = sort(union(df_linear$var1, df_linear$var2))
df_linear$var1 = factor(df_linear$var1, levels = tax_name)
df_linear$var2 = factor(df_linear$var2, levels = tax_name)

heat_linear_th = df_linear %>%
  ggplot(aes(var2, var1, fill = value)) +
  geom_tile(color = "black") +
  scale_fill_gradient2(low = "blue", high = "red", mid = "white", na.value = "grey",
                       midpoint = 0, limit = c(-1,1), space = "Lab",
                       name = NULL) +
  scale_x_discrete(drop = FALSE) +
  scale_y_discrete(drop = FALSE) +
  geom_text(aes(var2, var1, label = value), color = "black", size = 4) +
  labs(x = NULL, y = NULL, title = "Pearson (Thresholding)") +
  theme_bw() +
  theme(axis.text.x = element_text(angle = 45, vjust = 1, size = 12, hjust = 1,
                                   face = "italic"),
        axis.text.y = element_text(size = 12, face = "italic"),
        strip.text.x = element_text(size = 14),
        strip.text.y = element_text(size = 14),
        legend.text = element_text(size = 12),
        plot.title = element_text(hjust = 0.5, size = 15),
        panel.grid.major = element_blank(),
        axis.ticks = element_blank(),
        legend.position = "none") +
  coord_fixed()

heat_linear_th
```

![](data:image/png;base64...)

### Pearson correlation with p-value filtering

```
corr_linear = res_linear$corr_fl
cooccur_linear = res_linear$mat_cooccur

# Filter by co-occurrence
overlap = 10
corr_linear[cooccur_linear < overlap] = 0

df_linear = data.frame(get_upper_tri(corr_linear)) %>%
  rownames_to_column("var1") %>%
  pivot_longer(cols = -var1, names_to = "var2", values_to = "value") %>%
  filter(!is.na(value)) %>%
  mutate(value = round(value, 2))

tax_name = sort(union(df_linear$var1, df_linear$var2))
df_linear$var1 = factor(df_linear$var1, levels = tax_name)
df_linear$var2 = factor(df_linear$var2, levels = tax_name)

heat_linear_fl = df_linear %>%
  ggplot(aes(var2, var1, fill = value)) +
  geom_tile(color = "black") +
  scale_fill_gradient2(low = "blue", high = "red", mid = "white", na.value = "grey",
                       midpoint = 0, limit = c(-1,1), space = "Lab",
                       name = NULL) +
  scale_x_discrete(drop = FALSE) +
  scale_y_discrete(drop = FALSE) +
  geom_text(aes(var2, var1, label = value), color = "black", size = 4) +
  labs(x = NULL, y = NULL, title = "Pearson (Filtering)") +
  theme_bw() +
  theme(axis.text.x = element_text(angle = 45, vjust = 1, size = 12, hjust = 1,
                                   face = "italic"),
        axis.text.y = element_text(size = 12, face = "italic"),
        strip.text.x = element_text(size = 14),
        strip.text.y = element_text(size = 14),
        legend.text = element_text(size = 12),
        plot.title = element_text(hjust = 0.5, size = 15),
        panel.grid.major = element_blank(),
        axis.ticks = element_blank(),
        legend.position = "none") +
  coord_fixed()

heat_linear_fl
```

![](data:image/png;base64...)

### Distance correlation with p-value filtering

```
corr_dist = res_dist$dcorr_fl
cooccur_dist = res_dist$mat_cooccur

# Filter by co-occurrence
overlap = 10
corr_dist[cooccur_dist < overlap] = 0

df_dist = data.frame(get_upper_tri(corr_dist)) %>%
  rownames_to_column("var1") %>%
  pivot_longer(cols = -var1, names_to = "var2", values_to = "value") %>%
  filter(!is.na(value)) %>%
  mutate(value = round(value, 2))

tax_name = sort(union(df_dist$var1, df_dist$var2))
df_dist$var1 = factor(df_dist$var1, levels = tax_name)
df_dist$var2 = factor(df_dist$var2, levels = tax_name)

heat_dist_fl = df_dist %>%
  ggplot(aes(var2, var1, fill = value)) +
  geom_tile(color = "black") +
  scale_fill_gradient2(low = "blue", high = "red", mid = "white", na.value = "grey",
                       midpoint = 0, limit = c(-1,1), space = "Lab",
                       name = NULL) +
  scale_x_discrete(drop = FALSE) +
  scale_y_discrete(drop = FALSE) +
  geom_text(aes(var2, var1, label = value), color = "black", size = 4) +
  labs(x = NULL, y = NULL, title = "Distance (Filtering)") +
  theme_bw() +
  theme(axis.text.x = element_text(angle = 45, vjust = 1, size = 12, hjust = 1,
                                   face = "italic"),
        axis.text.y = element_text(size = 12, face = "italic"),
        strip.text.x = element_text(size = 14),
        strip.text.y = element_text(size = 14),
        legend.text = element_text(size = 12),
        plot.title = element_text(hjust = 0.5, size = 15),
        panel.grid.major = element_blank(),
        axis.ticks = element_blank(),
        legend.position = "none") +
  coord_fixed()

heat_dist_fl
```

![](data:image/png;base64...)

## 4.3 Run secom functions using the `tse` object

One can also run SECOM function using the `TreeSummarizedExperiment` object.

```
tse = mia::makeTreeSummarizedExperimentFromPhyloseq(atlas1006)
tse = tse[, tse$time == 0]
tse$bmi = recode(tse$bmi_group,
                 obese = "obese",
                 severeobese = "obese",
                 morbidobese = "obese")
tse = tse[, tse$bmi %in% c("lean", "overweight", "obese")]
tse$bmi = factor(tse$bmi, levels = c("obese", "overweight", "lean"))
tse$region = recode(as.character(tse$nationality),
                    Scandinavia = "NE", UKIE = "NE", SouthEurope = "SE",
                    CentralEurope = "CE", EasternEurope = "EE",
                    .missing = "unknown")
tse = tse[, ! tse$region %in% c("EE", "unknown")]

set.seed(123)
# Linear relationships
res_linear = secom_linear(data = list(tse), taxa_are_rows = TRUE,
                          assay_name = "counts", tax_level = "Phylum",
                          aggregate_data = NULL, meta_data = NULL, pseudo = 0,
                          prv_cut = 0.5, lib_cut = 1000, corr_cut = 0.5,
                          wins_quant = c(0.05, 0.95), method = "pearson",
                          soft = FALSE, thresh_len = 20, n_cv = 10,
                          thresh_hard = 0.3, max_p = 0.005, n_cl = 2)

# Nonlinear relationships
res_dist = secom_dist(data = list(tse), taxa_are_rows = TRUE,
                      assay_name = "counts", tax_level = "Phylum",
                      aggregate_data = NULL, meta_data = NULL, pseudo = 0,
                      prv_cut = 0.5, lib_cut = 1000, corr_cut = 0.5,
                      wins_quant = c(0.05, 0.95), R = 1000,
                      thresh_hard = 0.3, max_p = 0.005, n_cl = 2)
```

## 4.4 Run secom functions by directly providing the abundance and metadata

Please ensure that you provide the following: 1) The abundance data at its lowest possible taxonomic level. 2) The aggregated data at the desired taxonomic level; if no aggregation is performed, it can be the same as the original abundance data. 3) The sample metadata.

```
abundance_data = microbiome::abundances(pseq)
aggregate_data = microbiome::abundances(microbiome::aggregate_taxa(pseq, "Phylum"))
meta_data = microbiome::meta(pseq)

set.seed(123)
# Linear relationships
res_linear = secom_linear(data = list(abundance_data),
                          taxa_are_rows = TRUE,
                          aggregate_data = list(aggregate_data),
                          meta_data = list(meta_data),
                          pseudo = 0,
                          prv_cut = 0.5, lib_cut = 1000, corr_cut = 0.5,
                          wins_quant = c(0.05, 0.95), method = "pearson",
                          soft = FALSE, thresh_len = 20, n_cv = 10,
                          thresh_hard = 0.3, max_p = 0.005, n_cl = 2)

# Nonlinear relationships
res_dist = secom_dist(data = list(abundance_data),
                      taxa_are_rows = TRUE,
                      aggregate_data = list(aggregate_data),
                      meta_data = list(meta_data),
                      pseudo = 0,
                      prv_cut = 0.5, lib_cut = 1000, corr_cut = 0.5,
                      wins_quant = c(0.05, 0.95), R = 1000,
                      thresh_hard = 0.3, max_p = 0.005, n_cl = 2)
```

# 5. Run SECOM on Multiple Ecosystems

## 5.1 Data manipulation

To compute correlations whithin and across different ecosystems, one needs to make sure that there are samples in common across these ecosystems.

```
# Select subjects from "CE" and "NE"
pseq1 = phyloseq::subset_samples(pseq, region == "CE")
pseq2 = phyloseq::subset_samples(pseq, region == "NE")
phyloseq::sample_names(pseq1) = paste0("Sample-", seq_len(phyloseq::nsamples(pseq1)))
phyloseq::sample_names(pseq2) = paste0("Sample-", seq_len(phyloseq::nsamples(pseq2)))

print(pseq1)
```

```
phyloseq-class experiment-level object
otu_table()   OTU Table:         [ 130 taxa and 578 samples ]
sample_data() Sample Data:       [ 578 samples by 12 sample variables ]
tax_table()   Taxonomy Table:    [ 130 taxa by 3 taxonomic ranks ]
```

```
print(pseq2)
```

```
phyloseq-class experiment-level object
otu_table()   OTU Table:         [ 130 taxa and 181 samples ]
sample_data() Sample Data:       [ 181 samples by 12 sample variables ]
tax_table()   Taxonomy Table:    [ 130 taxa by 3 taxonomic ranks ]
```

## 5.2 Run secom functions using the `phyloseq` object

```
set.seed(123)
# Linear relationships
res_linear = secom_linear(data = list(CE = pseq1, NE = pseq2),
                          taxa_are_rows = TRUE,
                          tax_level = c("Phylum", "Phylum"),
                          aggregate_data = NULL, meta_data = NULL, pseudo = 0,
                          prv_cut = 0.5, lib_cut = 1000, corr_cut = 0.5,
                          wins_quant = c(0.05, 0.95), method = "pearson",
                          soft = FALSE, thresh_len = 20, n_cv = 10,
                          thresh_hard = 0.3, max_p = 0.005, n_cl = 2)

# Nonlinear relationships
res_dist = secom_dist(data = list(CE = pseq1, NE = pseq2),
                      taxa_are_rows = TRUE,
                      tax_level = c("Phylum", "Phylum"),
                      aggregate_data = NULL, meta_data = NULL, pseudo = 0,
                      prv_cut = 0.5, lib_cut = 1000, corr_cut = 0.5,
                      wins_quant = c(0.05, 0.95), R = 1000,
                      thresh_hard = 0.3, max_p = 0.005, n_cl = 2)
```

## 5.3 Visualizations

### Pearson correlation with thresholding

```
corr_linear = res_linear$corr_th
cooccur_linear = res_linear$mat_cooccur

# Filter by co-occurrence
overlap = 10
corr_linear[cooccur_linear < overlap] = 0

df_linear = data.frame(get_upper_tri(corr_linear)) %>%
  rownames_to_column("var1") %>%
  pivot_longer(cols = -var1, names_to = "var2", values_to = "value") %>%
  filter(!is.na(value)) %>%
  mutate(var2 = gsub("\\...", " - ", var2),
         value = round(value, 2))

tax_name = sort(union(df_linear$var1, df_linear$var2))
df_linear$var1 = factor(df_linear$var1, levels = tax_name)
df_linear$var2 = factor(df_linear$var2, levels = tax_name)
txt_color = ifelse(grepl("CE", tax_name), "#1B9E77", "#D95F02")

heat_linear_th = df_linear %>%
  ggplot(aes(var2, var1, fill = value)) +
  geom_tile(color = "black") +
  scale_fill_gradient2(low = "blue", high = "red", mid = "white",
                       na.value = "grey", midpoint = 0, limit = c(-1,1),
                       space = "Lab", name = NULL) +
  scale_x_discrete(drop = FALSE) +
  scale_y_discrete(drop = FALSE) +
  geom_text(aes(var2, var1, label = value), color = "black", size = 4) +
  labs(x = NULL, y = NULL, title = "Pearson (Thresholding)") +
  theme_bw() +
  geom_vline(xintercept = 6.5, color = "blue", linetype = "dashed") +
  geom_hline(yintercept = 6.5, color = "blue", linetype = "dashed") +
  theme(axis.text.x = element_text(angle = 45, vjust = 1, size = 12, hjust = 1,
                                   face = "italic", color = txt_color),
        axis.text.y = element_text(size = 12, face = "italic",
                                   color = txt_color),
        strip.text.x = element_text(size = 14),
        strip.text.y = element_text(size = 14),
        legend.text = element_text(size = 12),
        plot.title = element_text(hjust = 0.5, size = 15),
        panel.grid.major = element_blank(),
        axis.ticks = element_blank(),
        legend.position = "none") +
  coord_fixed()

heat_linear_th
```

![](data:image/png;base64...)

### Pearson correlation with p-value filtering

```
corr_linear = res_linear$corr_th
cooccur_linear = res_linear$mat_cooccur

# Filter by co-occurrence
overlap = 10
corr_linear[cooccur_linear < overlap] = 0

df_linear = data.frame(get_upper_tri(corr_linear)) %>%
  rownames_to_column("var1") %>%
  pivot_longer(cols = -var1, names_to = "var2", values_to = "value") %>%
  filter(!is.na(value)) %>%
  mutate(var2 = gsub("\\...", " - ", var2),
         value = round(value, 2))

tax_name = sort(union(df_linear$var1, df_linear$var2))
df_linear$var1 = factor(df_linear$var1, levels = tax_name)
df_linear$var2 = factor(df_linear$var2, levels = tax_name)
txt_color = ifelse(grepl("CE", tax_name), "#1B9E77", "#D95F02")

heat_linear_fl = df_linear %>%
  ggplot(aes(var2, var1, fill = value)) +
  geom_tile(color = "black") +
  scale_fill_gradient2(low = "blue", high = "red", mid = "white",
                       na.value = "grey", midpoint = 0, limit = c(-1,1),
                       space = "Lab", name = NULL) +
  scale_x_discrete(drop = FALSE) +
  scale_y_discrete(drop = FALSE) +
  geom_text(aes(var2, var1, label = value), color = "black", size = 4) +
  labs(x = NULL, y = NULL, title = "Pearson (Filtering)") +
  theme_bw() +
  geom_vline(xintercept = 6.5, color = "blue", linetype = "dashed") +
  geom_hline(yintercept = 6.5, color = "blue", linetype = "dashed") +
  theme(axis.text.x = element_text(angle = 45, vjust = 1, size = 12, hjust = 1,
                                   face = "italic", color = txt_color),
        axis.text.y = element_text(size = 12, face = "italic",
                                   color = txt_color),
        strip.text.x = element_text(size = 14),
        strip.text.y = element_text(size = 14),
        legend.text = element_text(size = 12),
        plot.title = element_text(hjust = 0.5, size = 15),
        panel.grid.major = element_blank(),
        axis.ticks = element_blank(),
        legend.position = "none") +
  coord_fixed()

heat_linear_fl
```

![](data:image/png;base64...)

### Distance correlation with p-value filtering

```
corr_dist = res_dist$dcorr_fl
cooccur_dist = res_dist$mat_cooccur

# Filter by co-occurrence
overlap = 10
corr_dist[cooccur_dist < overlap] = 0

df_dist = data.frame(get_upper_tri(corr_dist)) %>%
  rownames_to_column("var1") %>%
  pivot_longer(cols = -var1, names_to = "var2", values_to = "value") %>%
  filter(!is.na(value)) %>%
  mutate(var2 = gsub("\\...", " - ", var2),
         value = round(value, 2))

tax_name = sort(union(df_dist$var1, df_dist$var2))
df_dist$var1 = factor(df_dist$var1, levels = tax_name)
df_dist$var2 = factor(df_dist$var2, levels = tax_name)
txt_color = ifelse(grepl("CE", tax_name), "#1B9E77", "#D95F02")

heat_dist_fl = df_dist %>%
  ggplot(aes(var2, var1, fill = value)) +
  geom_tile(color = "black") +
  scale_fill_gradient2(low = "blue", high = "red", mid = "white",
                       na.value = "grey", midpoint = 0, limit = c(-1,1),
                       space = "Lab", name = NULL) +
  scale_x_discrete(drop = FALSE) +
  scale_y_discrete(drop = FALSE) +
  geom_text(aes(var2, var1, label = value), color = "black", size = 4) +
  labs(x = NULL, y = NULL, title = "Distance (Filtering)") +
  theme_bw() +
  geom_vline(xintercept = 6.5, color = "blue", linetype = "dashed") +
  geom_hline(yintercept = 6.5, color = "blue", linetype = "dashed") +
  theme(axis.text.x = element_text(angle = 45, vjust = 1, size = 12, hjust = 1,
                                   face = "italic", color = txt_color),
        axis.text.y = element_text(size = 12, face = "italic",
                                   color = txt_color),
        strip.text.x = element_text(size = 14),
        strip.text.y = element_text(size = 14),
        legend.text = element_text(size = 12),
        plot.title = element_text(hjust = 0.5, size = 15),
        panel.grid.major = element_blank(),
        axis.ticks = element_blank(),
        legend.position = "none") +
  coord_fixed()

heat_dist_fl
```

![](data:image/png;base64...)

## 5.4 Run secom functions using the `tse` object

One can also run SECOM function using the `TreeSummarizedExperiment` object.

```
# Select subjects from "CE" and "NE"
tse1 = tse[, tse$region == "CE"]
tse2 = tse[, tse$region == "NE"]

# Rename samples to ensure there is an overlap of samples between CE and NE
colnames(tse1) = paste0("Sample-", seq_len(ncol(tse1)))
colnames(tse2) = paste0("Sample-", seq_len(ncol(tse2)))

set.seed(123)
# Linear relationships
res_linear = secom_linear(data = list(CE = tse1, NE = tse2),
                          taxa_are_rows = TRUE,
                          assay_name = c("counts", "counts"),
                          tax_level = c("Phylum", "Phylum"),
                          aggregate_data = NULL, meta_data = NULL, pseudo = 0,
                          prv_cut = 0.5, lib_cut = 1000, corr_cut = 0.5,
                          wins_quant = c(0.05, 0.95), method = "pearson",
                          soft = FALSE, thresh_len = 20, n_cv = 10,
                          thresh_hard = 0.3, max_p = 0.005, n_cl = 2)

# Nonlinear relationships
res_dist = secom_dist(data = list(CE = tse1, NE = tse2),
                      taxa_are_rows = TRUE,
                      assay_name = c("counts", "counts"),
                      tax_level = c("Phylum", "Phylum"),
                      aggregate_data = NULL, meta_data = NULL, pseudo = 0,
                      prv_cut = 0.5, lib_cut = 1000, corr_cut = 0.5,
                      wins_quant = c(0.05, 0.95), R = 1000,
                      thresh_hard = 0.3, max_p = 0.005, n_cl = 2)
```

## 5.5 Run secom functions by directly providing the abundance and metadata

Please ensure that you provide the following: 1) The abundance data at its lowest possible taxonomic level. 2) The aggregated data at the desired taxonomic level; if no aggregation is performed, it can be the same as the original abundance data. 3) The sample metadata.

```
ce_idx = which(meta_data$region == "CE")
ne_idx = which(meta_data$region == "NE")

abundance_data1 = abundance_data[, ce_idx]
abundance_data2 = abundance_data[, ne_idx]
aggregate_data1 = aggregate_data[, ce_idx]
aggregate_data2 = aggregate_data[, ne_idx]
meta_data1 = meta_data[ce_idx, ]
meta_data2 = meta_data[ne_idx, ]

sample_size1 = ncol(abundance_data1)
sample_size2 = ncol(abundance_data2)
colnames(abundance_data1) = paste0("Sample-", seq_len(sample_size1))
colnames(abundance_data2) = paste0("Sample-", seq_len(sample_size2))
rownames(meta_data1) = paste0("Sample-", seq_len(sample_size1))
rownames(meta_data2) = paste0("Sample-", seq_len(sample_size2))

set.seed(123)
# Linear relationships
res_linear = secom_linear(data = list(CE = abundance_data1, NE = abundance_data2),
                          taxa_are_rows = TRUE,
                          aggregate_data = list(aggregate_data1, aggregate_data2),
                          meta_data = list(meta_data1, meta_data2),
                          pseudo = 0,
                          prv_cut = 0.5, lib_cut = 1000, corr_cut = 0.5,
                          wins_quant = c(0.05, 0.95), method = "pearson",
                          soft = FALSE, thresh_len = 20, n_cv = 10,
                          thresh_hard = 0.3, max_p = 0.005, n_cl = 2)

# Nonlinear relationships
res_dist = secom_dist(data = list(CE = abundance_data1, NE = abundance_data2),
                      taxa_are_rows = TRUE,
                      aggregate_data = list(aggregate_data1, aggregate_data2),
                      meta_data = list(meta_data1, meta_data2),
                      pseudo = 0,
                      prv_cut = 0.5, lib_cut = 1000, corr_cut = 0.5,
                      wins_quant = c(0.05, 0.95), R = 1000,
                      thresh_hard = 0.3, max_p = 0.005, n_cl = 2)
```

# Session information

```
sessionInfo()
```

```
R version 4.5.1 Patched (2025-08-23 r88802)
Platform: x86_64-pc-linux-gnu
Running under: Ubuntu 24.04.3 LTS

Matrix products: default
BLAS:   /home/biocbuild/bbs-3.22-bioc/R/lib/libRblas.so
LAPACK: /usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.12.0  LAPACK version 3.12.0

locale:
 [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C
 [3] LC_TIME=en_GB              LC_COLLATE=C
 [5] LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8
 [7] LC_PAPER=en_US.UTF-8       LC_NAME=C
 [9] LC_ADDRESS=C               LC_TELEPHONE=C
[11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C

time zone: America/New_York
tzcode source: system (glibc)

attached base packages:
[1] stats     graphics  grDevices utils     datasets  methods   base

other attached packages:
 [1] doRNG_1.8.6.2   rngtools_1.5.2  foreach_1.5.2   DT_0.34.0
 [5] lubridate_1.9.4 forcats_1.0.1   stringr_1.5.2   dplyr_1.1.4
 [9] purrr_1.1.0     readr_2.1.5     tidyr_1.3.1     tibble_3.3.0
[13] ggplot2_4.0.0   tidyverse_2.0.0 ANCOMBC_2.12.0

loaded via a namespace (and not attached):
  [1] RColorBrewer_1.1-3  rstudioapi_0.17.1   jsonlite_2.0.0
  [4] magrittr_2.0.4      TH.data_1.1-4       farver_2.1.2
  [7] nloptr_2.2.1        rmarkdown_2.30      fs_1.6.6
 [10] vctrs_0.6.5         multtest_2.66.0     minqa_1.2.8
 [13] base64enc_0.1-3     htmltools_0.5.8.1   energy_1.7-12
 [16] haven_2.5.5         cellranger_1.1.0    Rhdf5lib_1.32.0
 [19] Formula_1.2-5       rhdf5_2.54.0        sass_0.4.10
 [22] bslib_0.9.0         htmlwidgets_1.6.4   plyr_1.8.9
 [25] sandwich_3.1-1      rootSolve_1.8.2.4   zoo_1.8-14
 [28] cachem_1.1.0        igraph_2.2.1        lifecycle_1.0.4
 [31] iterators_1.0.14    pkgconfig_2.0.3     Matrix_1.7-4
 [34] R6_2.6.1            fastmap_1.2.0       rbibutils_2.3
 [37] digest_0.6.37       Exact_3.3           numDeriv_2016.8-1.1
 [40] colorspace_2.1-2    S4Vectors_0.48.0    crosstalk_1.2.2
 [43] Hmisc_5.2-4         vegan_2.7-2         labeling_0.4.3
 [46] timechange_0.3.0    mgcv_1.9-3          httr_1.4.7
 [49] compiler_4.5.1      proxy_0.4-27        bit64_4.6.0-1
 [52] withr_3.0.2         doParallel_1.0.17   gsl_2.1-8
 [55] htmlTable_2.4.3     S7_0.2.0            backports_1.5.0
 [58] MASS_7.3-65         biomformat_1.38.0   permute_0.9-8
 [61] gtools_3.9.5        CVXR_1.0-15         gld_2.6.8
 [64] tools_4.5.1         foreign_0.8-90      ape_5.8-1
 [67] nnet_7.3-20         glue_1.8.0          nlme_3.1-168
 [70] rhdf5filters_1.22.0 grid_4.5.1          Rtsne_0.17
 [73] checkmate_2.3.3     cluster_2.1.8.1     reshape2_1.4.4
 [76] ade4_1.7-23         generics_0.1.4      microbiome_1.32.0
 [79] gtable_0.3.6        tzdb_0.5.0          class_7.3-23
 [82] data.table_1.17.8   lmom_3.2            hms_1.1.4
 [85] XVector_0.50.0      BiocGenerics_0.56.0 pillar_1.11.1
 [88] splines_4.5.1       lattice_0.22-7      survival_3.8-3
 [91] gmp_0.7-5           bit_4.6.0           tidyselect_1.2.1
 [94] Biostrings_2.78.0   knitr_1.50          reformulas_0.4.2
 [97] gridExtra_2.3       phyloseq_1.54.0     IRanges_2.44.0
[100] Seqinfo_1.0.0       stats4_4.5.1        xfun_0.53
[103] expm_1.0-0          Biobase_2.70.0      stringi_1.8.7
[106] yaml_2.3.10         boot_1.3-32         evaluate_1.0.5
[109] codetools_0.2-20    cli_3.6.5           rpart_4.1.24
[112] DescTools_0.99.60   Rdpack_2.6.4        jquerylib_0.1.4
[115] dichromat_2.0-0.1   Rcpp_1.1.0          readxl_1.4.5
[118] parallel_4.5.1      lme4_1.1-37         Rmpfr_1.1-2
[121] mvtnorm_1.3-3       lmerTest_3.1-3      scales_1.4.0
[124] e1071_1.7-16        crayon_1.5.3        rlang_1.1.6
[127] multcomp_1.4-29
```

# References

Lahti, Leo, Jarkko Salojärvi, Anne Salonen, Marten Scheffer, and Willem M De Vos. 2014. “Tipping Elements in the Human Intestinal Ecosystem.” *Nature Communications* 5 (1): 1–10.

Lahti, Leo, Sudarshan Shetty, T Blake, J Salojarvi, and others. 2017. “Tools for Microbiome Analysis in R.” *Version* 1: 10013.

Lin, Huang, Merete Eggesbø, and Shyamal Das Peddada. 2022. “Linear and Nonlinear Correlation Estimators Unveil Undescribed Taxa Interactions in Microbiome Data.” *Nature Communications* 13 (1): 1–16.

McMurdie, Paul J, and Susan Holmes. 2013. “Phyloseq: An R Package for Reproducible Interactive Analysis and Graphics of Microbiome Census Data.” *PloS One* 8 (4): e61217.