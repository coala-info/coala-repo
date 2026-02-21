# 3. PAT-Seq alternative polyadenylation example

Paul Harrison

#### 2025-10-30

# Contents

* [1 Shift score definition](#shift-score-definition)
* [2 Load files](#load-files)
* [3 Exploratory analysis](#exploratory-analysis)
  + [3.1 Components of variation](#components-of-variation)
  + [3.2 Calibration](#calibration)
  + [3.3 Using the calibrated weitrix with weitrix\_confects](#using-the-calibrated-weitrix-with-weitrix_confects)
    - [3.3.1 Gene loadings for C1](#gene-loadings-for-c1)
    - [3.3.2 Gene loadings for C2](#gene-loadings-for-c2)
    - [3.3.3 Gene loadings for C3](#gene-loadings-for-c3)
    - [3.3.4 Gene loadings for C4](#gene-loadings-for-c4)
  + [3.4 Genes with high variability](#genes-with-high-variability)
  + [3.5 Examine individual genes](#examine-individual-genes)
* [4 Alternative calibration method](#alternative-calibration-method)

APA sites can be detected using the [PAT-Seq protocol](https://rnajournal.cshlp.org/content/21/8/1502.long). This protocol produces 3’-end focussed reads. We examine [GSE83162](https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE83162). This is a time-series experiment in which two strains of yeast are released into synchronized cell cycling and observed through two cycles. Yeast are treated with \(\alpha\)-factor, which causes them to stop dividing in antici… pation of a chance to mate. When the \(\alpha\)-factor is washed away, they resume cycling.

# 1 Shift score definition

Each gene has several APA sites, ordered from furthest upstrand to furthest downstrand. For each sample, we have a read count at each site.

For each gene:

We define the “shift” of a particular sample relative to all reads from all samples.

A “shift” score is first assigned to each site, being the proportion of all reads upstrand of the site minus the proportion of all reads downstrand of it (i.e. an average over all reads where upstrand reads are 1, downstrand reads are -1 and reads from the site itself are 0). The measurement for each sample is then an average over the site score for each read. The weight is the number of reads.

Shifts scores range from -1 to 1, and summarize whether upstrand (more negative) or downstrand (more positive) sites are being favoured. The weighted average score is zero.

The weights are the number of reads, however for a randomly chosen read we can estimate its variance based on the number of reads at each site and the site scores. (This estimate of variance includes any biological signal, so it’s not exactly a residual variance.) This is stored in the `rowData()` of the weitrix, and can be used to further calibrate weights. We prefer to defer this sort of calibration until after we’ve discoverd components of variation, as it tends to give high weight to genes with little APA. There are clearly some alternative choices to how weighting could be performed, and we hope the weitrix package gives you basic building blocks with which you can experiment!

# 2 Load files

```
library(tidyverse)    # ggplot2, dplyr, etc
library(patchwork)    # side-by-side ggplots
library(reshape2)     # melt()
library(weitrix)      # Matrices with precision weights

# Produce consistent results
set.seed(12345)

# BiocParallel supports multiple backends.
# If the default hangs or errors, try others.
# The most reliable backed is to use serial processing
BiocParallel::register( BiocParallel::SerialParam() )
```

```
peaks <- system.file("GSE83162", "peaks.csv.gz", package="weitrix") %>%
    read.csv(check.names=FALSE)

counts <- system.file("GSE83162", "peak_count.csv.gz", package="weitrix") %>%
    read.csv(check.names=FALSE) %>%
    column_to_rownames("name") %>%
    as.matrix()

genes <- system.file("GSE83162", "genes.csv.gz", package="weitrix") %>%
    read.csv(check.names=FALSE) %>%
    column_to_rownames("name")

samples <- data.frame(sample=I(colnames(counts))) %>%
    extract(sample, c("strain","time"), c("(.+)-(.+)"), remove=FALSE) %>%
    mutate(
        strain=factor(strain,unique(strain)),
        time=factor(time,unique(time)))
rownames(samples) <- samples$sample

groups <- dplyr::select(peaks, group=gene_name, name=name)
# Note the order of this data frame is important
```

```
samples
```

```
##                          sample    strain  time
## WT-tpre                 WT-tpre        WT  tpre
## WT-t0m                   WT-t0m        WT   t0m
## WT-t15m                 WT-t15m        WT  t15m
## WT-t30m                 WT-t30m        WT  t30m
## WT-t45m                 WT-t45m        WT  t45m
## WT-t60m                 WT-t60m        WT  t60m
## WT-t75m                 WT-t75m        WT  t75m
## WT-t90m                 WT-t90m        WT  t90m
## WT-t105m               WT-t105m        WT t105m
## WT-t120m               WT-t120m        WT t120m
## DeltaSet1-tpre   DeltaSet1-tpre DeltaSet1  tpre
## DeltaSet1-t0m     DeltaSet1-t0m DeltaSet1   t0m
## DeltaSet1-t15m   DeltaSet1-t15m DeltaSet1  t15m
## DeltaSet1-t30m   DeltaSet1-t30m DeltaSet1  t30m
## DeltaSet1-t45m   DeltaSet1-t45m DeltaSet1  t45m
## DeltaSet1-t60m   DeltaSet1-t60m DeltaSet1  t60m
## DeltaSet1-t75m   DeltaSet1-t75m DeltaSet1  t75m
## DeltaSet1-t90m   DeltaSet1-t90m DeltaSet1  t90m
## DeltaSet1-t105m DeltaSet1-t105m DeltaSet1 t105m
## DeltaSet1-t120m DeltaSet1-t120m DeltaSet1 t120m
```

```
head(groups, 10)
```

```
##        group     name
## 1    YDR533C peak1653
## 2    YDR533C peak1652
## 3    YDR529C peak1648
## 4    YDR529C peak1647
## 5      snR84 peak1646
## 6      snR84 peak1645
## 7      snR84 peak1644
## 8  YDR524C-B peak1643
## 9  YDR524C-B peak1642
## 10   YDR500C peak1629
```

```
counts[1:10,1:5]
```

```
##          WT-tpre WT-t0m WT-t15m WT-t30m WT-t45m
## peak3910      58     24      46      54      41
## peak3911      25      9      24      28      18
## peak3912       7      9      10      13      18
## peak4139      30      4       7      12      13
## peak4140       8      1       1       8       2
## peak4141      55      7      13      19      20
## peak8533      37     35      42      64      47
## peak8534      38     50      44      53      36
## peak5235      16      4       2       7       4
## peak5236      14      5       2       5       4
```

A “shift” weitrix is constructed based on a matrix of site-level counts, plus a data frame grouping sites into genes. The order of this data frame is important, earlier sites are considered upstrand of later sites.

```
wei <- counts_shift(counts, groups)
```

```
## Calculating shifts in 1 blocks
```

```
colData(wei) <- cbind(colData(wei), samples)
rowData(wei)$symbol <- genes$symbol[match(rownames(wei), rownames(genes))]
```

Having obtained a weitrix, everthing discussed for the [poly(A) tail length example](2_tail_length.html) is applicable here as well. We will only perform a brief exploratory analysis here.

# 3 Exploratory analysis

## 3.1 Components of variation

We can look for components of variation.

```
comp_seq <- weitrix_components_seq(wei, p=6, design=~0)
```

```
components_seq_screeplot(comp_seq)
```

```
## Ignoring unknown labels:
## • colour : "Threshold guidance"
```

![](data:image/png;base64...)

Pushing a point somewhat, we examine four components.

```
comp <- comp_seq[[4]]

matrix_long(comp$col, row_info=samples, varnames=c("sample","component")) %>%
    ggplot(aes(x=time, y=value, color=strain, group=strain)) +
    geom_hline(yintercept=0) +
    geom_line() +
    geom_point(alpha=0.75, size=3) +
    facet_grid(component ~ .) +
    labs(title="Sample scores for each component", y="Sample score", x="Time", color="Strain")
```

![](data:image/png;base64...)

## 3.2 Calibration

Weights can be calibrated. Ideally the weights should be 1 over the residual variance. We will fit a gamma GLM with log link function to the squared residuals, and use the predictions from this to produce better weights. This model uses the `per_read_var` information present in the rowData, as well as applying a non-linear transformation to the existing weights.

```
cal <- weitrix_calibrate_all(
    wei,
    design = comp,
    trend_formula = ~log(per_read_var)+well_knotted_spline(log2(weight),3))
```

```
## log2(weight) range  0.00000 19.70383 knots  4.863982  7.206426 10.386132
```

```
metadata(cal)$weitrix$all_coef
```

```
##                           (Intercept)                     log(per_read_var)
##                             0.2096519                             1.1853604
## well_knotted_spline(log2(weight), 3)1 well_knotted_spline(log2(weight), 3)2
##                            -4.6927533                            -5.2339368
## well_knotted_spline(log2(weight), 3)3 well_knotted_spline(log2(weight), 3)4
##                            -9.2618654                            -6.3998552
```

A mean-variance trend is visible in the uncalibrated weighted residuals. Calibration has removed this, by making use of the information in `per_read_var`.

```
(weitrix_calplot(wei, comp, covar=mu) + labs(title="Before")) +
(weitrix_calplot(cal, comp, covar=mu) + labs(title="After"))
```

![](data:image/png;base64...)

We can look at the calibration to `per_read_var` directly.

```
(weitrix_calplot(wei, comp, covar=per_read_var) + labs(title="Before")) +
(weitrix_calplot(cal, comp, covar=per_read_var) + labs(title="After"))
```

![](data:image/png;base64...)

Weights were too large for large read counts. Calibration has applied a non-linear transformation to the weights that fixes this.

```
(weitrix_calplot(wei, comp, covar=log(weitrix_weights(wei))) + labs(title="Before")) +
(weitrix_calplot(cal, comp, covar=log(weitrix_weights(wei))) + labs(title="After"))
```

![](data:image/png;base64...)

Another way of looking at this is with a “funnel” plot of 1/sqrt(weight) vs residuals. This should make a cone shape. Note how before calibration the pointy end of the cone is too wide.

```
(weitrix_calplot(wei, comp, funnel=TRUE, guides=FALSE) + labs(title="Before")) +
(weitrix_calplot(cal, comp, funnel=TRUE, guides=FALSE) + labs(title="After"))
```

![](data:image/png;base64...)

## 3.3 Using the calibrated weitrix with weitrix\_confects

We will estimate confident loadings for the different components using `weitrix_confects`.

**Treat these results with caution.** Confindence bounds take into account uncertainty in the loadings but not in the scores! What follows is best regarded as exploratory rather than a final result.

### 3.3.1 Gene loadings for C1

```
weitrix_confects(cal, comp$col, "C1", fdr=0.05)
```

```
## $table
##    confect effect se     df    fdr_zero  row_mean   typical_obs_err name
## 1  2.562   4.085  0.3274 31.87 2.143e-11 -0.0045737 0.03721         YLR058C
## 2  2.246   3.279  0.2344 31.87 1.680e-12  0.0005286 0.02569         YPR080W
## 3  1.923   2.756  0.1950 31.87 1.680e-12 -0.0102193 0.02113         YKL096W-A
## 4  1.890   2.613  0.1735 31.87 4.355e-13 -0.0038155 0.01821         YBL072C
## 5  1.811   3.216  0.3437 31.87 1.670e-08 -0.0050493 0.03766         YBR127C
## 6  1.805   2.649  0.2098 31.87 1.824e-11 -0.0064119 0.02202         YML026C
## 7  1.453   3.844  0.6028 31.87 2.927e-05 -0.0035558 0.06326         YDR342C
## 8  1.431   2.345  0.2331 31.87 4.094e-09 -0.0127900 0.02364         YKL180W
## 9  1.404   1.979  0.1482 31.87 4.893e-12 -0.0062268 0.01556         YDR524C-B
## 10 1.368   2.306  0.2444 31.87 1.570e-08 -0.0077192 0.02510         YBR249C
##    per_read_var total_reads symbol
## 1  0.18682        6958      SHM2
## 2  0.20630       72240      TEF1
## 3  0.08003      374176      CWP2
## 4  0.12048       47370      RPS8A
## 5  0.19376       21804      VMA2
## 6  0.11684       42444      RPS18B
## 7  0.16038        2866      HXT7
## 8  0.17678       57320      RPL17A
## 9  0.12464      164069      <NA>
## 10 0.16609       15246      ARO4
## ...
## 120 of 1805 non-zero contrast at FDR 0.05
## Prior df 15.9
```

### 3.3.2 Gene loadings for C2

```
weitrix_confects(cal, comp$col, "C2", fdr=0.05)
```

```
## $table
##    confect effect se     df    fdr_zero  row_mean  typical_obs_err name
## 1  5.330   6.729  0.3009 31.87 4.320e-18  0.033443 0.02523         YLL024C
## 2  4.833   6.310  0.3351 31.87 4.740e-16  0.025714 0.02964         YLR333C
## 3  4.210   4.856  0.1514 31.87 1.415e-22  0.026569 0.01384         YLR110C
## 4  3.311   5.008  0.4075 31.87 4.466e-11  0.020402 0.03681         YKL081W
## 5  3.311   5.471  0.5287 31.87 2.627e-09  0.011001 0.04884         YBR135W
## 6  2.515   4.558  0.5080 31.87 4.683e-08  0.030212 0.04419         YDR363W-A
## 7  2.319   4.600  0.5817 31.87 4.930e-07 -0.001391 0.05309         YNL098C
## 8  2.319   3.769  0.3699 31.87 3.395e-09  0.008160 0.03435         YNL067W
## 9  2.282   5.567  0.8515 31.87 1.248e-05  0.008116 0.07643         YBR269C
## 10 2.282   4.006  0.4491 31.87 4.938e-08  0.014319 0.03865         YJL111W
##    per_read_var total_reads symbol
## 1  0.1960       133748      SSA2
## 2  0.2382        46413      RPS25B
## 3  0.2070       712909      CCW12
## 4  0.2490       104942      TEF4
## 5  0.2461         3619      CKS1
## 6  0.1454        21193      SEM1
## 7  0.2405         7185      RAS2
## 8  0.2809        30030      RPL9B
## 9  0.2497         2289      SDH8
## 10 0.2001        14445      CCT7
## ...
## 164 of 1805 non-zero contrast at FDR 0.05
## Prior df 15.9
```

### 3.3.3 Gene loadings for C3

```
weitrix_confects(cal, comp$col, "C3", fdr=0.05)
```

```
## $table
##    confect effect se     df    fdr_zero  row_mean   typical_obs_err name
## 1   1.230   2.684 0.3125 31.87 1.529e-06  0.0135820 0.03443         YBR149W
## 2   1.213   3.147 0.4388 31.87 3.539e-05 -0.0180639 0.04887         YDR077W
## 3   1.164   4.218 0.7307 31.87 4.260e-04  0.0083721 0.07423         snR40
## 4   1.164   3.985 0.6773 31.87 3.811e-04  0.0018156 0.07511         YFR052C-A
## 5  -1.159  -3.766 0.6434 31.87 3.811e-04 -0.0042842 0.07054         YMR194C-B
## 6   1.159   3.130 0.4900 31.87 2.175e-04 -0.0013910 0.05309         YNL098C
## 7  -0.587  -3.637 0.7807 31.87 4.862e-03 -0.0156248 0.08990         YKL163W
## 8  -0.587  -2.536 0.5035 31.87 2.514e-03  0.0004136 0.05351         YNL130C
## 9   0.587   3.623 0.7870 31.87 5.428e-03 -0.0063790 0.08496         YGR243W
## 10 -0.587  -1.685 0.2860 31.87 3.811e-04 -0.0085628 0.03088         YLR372W
##    per_read_var total_reads symbol
## 1  0.19814       9498       ARA1
## 2  0.07946      66406       SED1
## 3  0.26488       3100       <NA>
## 4  0.14798       4967       <NA>
## 5  0.23748       2270       CMC4
## 6  0.24047       7185       RAS2
## 7  0.13916        808       PIR3
## 8  0.23029       4144       CPT1
## 9  0.23448       1172       MPC3
## 10 0.20219      20547       ELO3
## ...
## 109 of 1805 non-zero contrast at FDR 0.05
## Prior df 15.9
```

### 3.3.4 Gene loadings for C4

```
weitrix_confects(cal, comp$col, "C4", fdr=0.05)
```

```
## $table
##    confect effect se     df    fdr_zero  row_mean  typical_obs_err name
## 1   3.816   6.544 0.5879 31.87 1.982e-09  0.019197 0.06790         RDN5-1
## 2  -3.816  -6.838 0.6855 31.87 1.517e-08  0.022994 0.07322         YIL015W
## 3   1.318   4.512 0.7486 31.87 2.297e-04  0.011480 0.08344         tK(CUU)M
## 4   1.238   4.389 0.7566 31.87 3.208e-04 -0.001030 0.08340         YLR286C
## 5   1.107   3.315 0.5404 31.87 2.040e-04 -0.006542 0.06217         tK(CUU)J
## 6   1.095   2.914 0.4576 31.87 1.382e-04  0.002452 0.04978         YJL054W
## 7   1.095   4.711 0.9199 31.87 9.450e-04  0.004438 0.09981         tP(UGG)O3
## 8  -1.095  -2.335 0.3163 31.87 9.885e-06  0.001259 0.03515         YLR027C
## 9   1.063   3.116 0.5296 31.87 3.102e-04  0.018257 0.05511         YCR009C
## 10 -0.942  -2.787 0.4806 31.87 3.208e-04 -0.001391 0.05309         YNL098C
##    per_read_var total_reads symbol
## 1  0.2395        4029       <NA>
## 2  0.2090        4313       BAR1
## 3  0.2882        2843       <NA>
## 4  0.2424        1548       CTS1
## 5  0.0900        1200       <NA>
## 6  0.1756        1918       TIM54
## 7  0.2500         892       <NA>
## 8  0.2498       12186       AAT2
## 9  0.2292        5560       RVS161
## 10 0.2405        7185       RAS2
## ...
## 173 of 1805 non-zero contrast at FDR 0.05
## Prior df 15.9
```

## 3.4 Genes with high variability

Instead of looking for genes following some particular pattern, we can look for genes that simply have surprisingly high variability with `weitrix_sd_confects`.

```
weitrix_sd_confects(cal, step=0.01)
```

```
## $table
##    confect effect row_mean   typical_obs_err dispersion n_present df fdr_zero
## 1  0.18    0.2051  0.0204016 0.02667         60.117     20        19 0.00e+00
## 2  0.15    0.1793  0.0005286 0.02552         50.382     20        19 0.00e+00
## 3  0.15    0.1828  0.0257140 0.03040         37.148     20        19 0.00e+00
## 4  0.15    0.1976  0.0229944 0.05194         15.470     20        19 0.00e+00
## 5  0.15    0.1874 -0.0045737 0.03962         23.387     20        19 0.00e+00
## 6  0.14    0.1892  0.0191967 0.05425         13.164     20        19 0.00e+00
## 7  0.14    0.1700 -0.0050493 0.03110         30.879     20        19 0.00e+00
## 8  0.13    0.2445  0.0129602 0.12069          5.105     19        18 1.07e-10
## 9  0.13    0.1901  0.0081160 0.06682          9.095     20        19 0.00e+00
## 10 0.13    0.1488  0.0334434 0.02250         44.720     20        19 0.00e+00
##    name      per_read_var total_reads symbol
## 1  YKL081W   0.2490       104942      TEF4
## 2  YPR080W   0.2063        72240      TEF1
## 3  YLR333C   0.2382        46413      RPS25B
## 4  YIL015W   0.2090         4313      BAR1
## 5  YLR058C   0.1868         6958      SHM2
## 6  RDN5-1    0.2395         4029      <NA>
## 7  YBR127C   0.1938        21804      VMA2
## 8  tP(UGG)N1 0.2328          507      <NA>
## 9  YBR269C   0.2497         2289      SDH8
## 10 YLL024C   0.1960       133748      SSA2
## ...
## 470 of 1805 non-zero excess standard deviation at FDR 0.05
```

## 3.5 Examine individual genes

Let’s examine peak-level read counts for some genes we’ve identified.

```
examine <- function(gene_wanted, title) {
    peak_names <- filter(peaks, gene_name==gene_wanted)$name

    counts[peak_names,] %>% melt(value.name="reads", varnames=c("peak","sample")) %>%
        left_join(samples, by="sample") %>%
        ggplot(aes(x=factor(as.integer(peak)), y=reads)) +
        facet_grid(strain ~ time) + geom_col() +
        labs(x="Peak",y="Reads",title=title)
}

examine("YLR058C", "SHM2, from C1")
examine("YLR333C", "RPS25B, from C2")
examine("YDR077W", "SED1, from C3")
examine("YIL015W", "BAR1, from C4")
examine("tK(CUU)M", "tK(CUU)M, from C4")
examine("YKL081W", "TEF4, from weitrix_sd_confects")
examine("YPR080W", "TEF1, from weitrix_sd_confects")
```

![](data:image/png;base64...)![](data:image/png;base64...)![](data:image/png;base64...)![](data:image/png;base64...)![](data:image/png;base64...)![](data:image/png;base64...)![](data:image/png;base64...)

# 4 Alternative calibration method

For larger datasets, `weitrix_calibrate_all` may use a lot of memory. The weitrix packages also has an older version of calibration, `weitrix_calibrate_trend`. Rather than operating on weights individually, it applies a scaling to the weights of each *row*.

```
cal_trend <- weitrix_calibrate_trend(
    wei,
    design = comp,
    trend_formula = ~log(per_read_var)+well_knotted_spline(log(total_reads),3))
```

```
## log(total_reads) range  5.214936 16.049079 knots  6.749379  8.203755 10.367033
```

A mean-variance trend is visible in the uncalibrated weighted residuals. Calibration removes this, by making use of the information in `per_read_var`.

```
(weitrix_calplot(wei, comp, covar=mu) + labs(title="Before")) +
(weitrix_calplot(cal_trend, comp, covar=mu) + labs(title="After"))
```

![](data:image/png;base64...)

We can look at the calibration to `per_read_var` directly.

```
(weitrix_calplot(wei, comp, covar=per_read_var) + labs(title="Before")) +
(weitrix_calplot(cal_trend, comp, covar=per_read_var) + labs(title="After"))
```

![](data:image/png;base64...)

Weights were too large for large read counts. Calibration has applied a row-level adjustment for this based on the total number of reads for each row.

```
(weitrix_calplot(wei, comp, covar=log(weitrix_weights(wei))) + labs(title="Before")) +
(weitrix_calplot(cal_trend, comp, covar=log(weitrix_weights(wei))) + labs(title="After"))
```

![](data:image/png;base64...)