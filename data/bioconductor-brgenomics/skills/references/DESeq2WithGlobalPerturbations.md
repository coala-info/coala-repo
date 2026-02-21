# DESeq2 with Global Perturbations

#### 28 August 2020

#### Package

BRGenomics 1.0.3

# 1 Using DESeq2 for Pairwise Differential Expression

## 1.1 Rationale

DESeq2’s default treatment of data relies on the assumption that genewise
estimates of dispersion are largely unchanged across samples. While this
assumption holds for a typical RNA-seq data, it can be violated if there are
samples within the `DESeqDataSet` object for which there are meaningful signal
changes across a majority of regions of interest.

The BRGenomics functions `getDESeqDataSet()` and `getDESeqResults()` are simple
and flexible wrappers for making pairwise comparisons between individual
samples, without relying on the assumption of globally-similar dispersion
estimates. In particular, `getDESeqResults()` follows the logic that the
presence of a dataset \(X\) within the `DESeqDataSet` object will not affect the
comparison of datasets \(Y\) and \(Z\).

While the intuition above is appealing, users should note that if the
globally-similar dispersions assumption *does* hold, then DESeq2’s default
behavior should be more sensitive in its estimates of genewise dispersion. In
this case, users can still take advantage of the convenience of the BRGenomics
function `getDESeqDataSet()`, but they should subsequently call
`DESeq2::DESeq()` and `DESeq2::results()` directly.

If the globally-similar dispersions assumption is violated, but something beyond
simple pairwise comparisons is desired (e.g. group comparisons or additional
model terms), we note that, with some prying, DESeq2 can be used without “blind
dispersion estimation” (see the DESeq2 manual).

## 1.2 Formatting Data for DESeq2

Just like the functions that generate batch-normalized spike-in normalization
factors, the DESeq-oriented functions require that the names of the input
datasets end in `"rep1"`, `"rep2"`, etc.

Let’s first make a toy list of multiple datasets to compare:

```
library(BRGenomics)
data("PROseq")
```

```
ps_list <- lapply(1:6, function(i) PROseq[seq(i, length(PROseq), 6)])
names(ps_list) <- c("A_rep1", "A_rep2",
                    "B_rep1", "B_rep2",
                    "C_rep1", "C_rep2")
```

```
ps_list[1:2]
```

```
## $A_rep1
## GRanges object with 7897 ranges and 1 metadata column:
##          seqnames    ranges strand |     score
##             <Rle> <IRanges>  <Rle> | <integer>
##      [1]     chr4      1295      + |         1
##      [2]     chr4     42595      + |         1
##      [3]     chr4     42622      + |         2
##      [4]     chr4     42718      + |         1
##      [5]     chr4     42789      + |         1
##      ...      ...       ...    ... .       ...
##   [7893]     chr4   1295277      - |         1
##   [7894]     chr4   1306500      - |         1
##   [7895]     chr4   1306889      - |         1
##   [7896]     chr4   1307122      - |         1
##   [7897]     chr4   1316537      - |         1
##   -------
##   seqinfo: 7 sequences from an unspecified genome
##
## $A_rep2
## GRanges object with 7897 ranges and 1 metadata column:
##          seqnames    ranges strand |     score
##             <Rle> <IRanges>  <Rle> | <integer>
##      [1]     chr4     41428      + |         1
##      [2]     chr4     42596      + |         1
##      [3]     chr4     42652      + |         3
##      [4]     chr4     42733      + |         1
##      [5]     chr4     42794      + |         2
##      ...      ...       ...    ... .       ...
##   [7893]     chr4   1305972      - |         1
##   [7894]     chr4   1306514      - |         1
##   [7895]     chr4   1307032      - |         1
##   [7896]     chr4   1307126      - |         1
##   [7897]     chr4   1318960      - |         1
##   -------
##   seqinfo: 7 sequences from an unspecified genome
```

```
names(ps_list)
```

```
## [1] "A_rep1" "A_rep2" "B_rep1" "B_rep2" "C_rep1" "C_rep2"
```

As you can see, the names all end in “repX”, where X indicates the replicate.
Replicates will be grouped by anything that follows “rep”. If the sample names
do not conform to this standard, the `sample_names` argument can be used to
rename the samples within the call to `getDESeqDataSet()`.

```
data("txs_dm6_chr4")
```

```
dds <- getDESeqDataSet(ps_list, txs_dm6_chr4,
                       gene_names = txs_dm6_chr4$gene_id,
                       ncores = 1)
dds
```

```
## class: DESeqDataSet
## dim: 111 6
## metadata(1): version
## assays(1): counts
## rownames(111): FBgn0267363 FBgn0266617 ... FBgn0039924 FBgn0027101
## rowData names(2): tx_name gene_id
## colnames(6): A_rep1 A_rep2 ... C_rep1 C_rep2
## colData names(2): condition replicate
```

Notice that the `dim` attribute of the `DESeqDataSet` object is `c(111, 6)`.
There are 6 samples, but `length(txs_dm6_chr4)` is not 111. This is because we
provided gene names to `getDESeqDataSet()`, which were non-unique. The feature
being exploited here is for use with **discontinuous gene regions**, *not for
multiple overlapping transcript isoforms*.

---

**By default, `getDESeqDataSet()` will combine counts across all ranges
belonging to a gene, but if they overlap, they will be counted twice. For
addressing issues related to overlaps, see the `reduceByGene()` and
`intersectByGene()` functions.**

---

We could have added normalization factors, which DESeq2 calls “size factors”, in
the call to `getDESeqDataSet()`, or we can supply them to `getDESeqResults()`
below. (Supplying them twice will overwrite the previous size factors).

*Important note on normalization factors:* DESeq2 “size factors” are the
*inverse* of BRGenomics normalization factors. So if you calculate normalization
factors with `NF <- getSpikeInNFs(...)`, set `sizeFactors <- 1/NF`.

## 1.3 Getting DESeq2 Results

Generating DESeq2 results is simple:

```
getDESeqResults(dds, contrast.numer = "B", contrast.denom = "A",
                quiet = TRUE, ncores = 1)
```

```
## log2 fold change (MLE): condition B vs A
## Wald test p-value: condition B vs A
## DataFrame with 111 rows and 6 columns
##                baseMean log2FoldChange     lfcSE       stat    pvalue      padj
##               <numeric>      <numeric> <numeric>  <numeric> <numeric> <numeric>
## FBgn0267363    0.252443     -1.4201507  4.997269 -0.2841853  0.776268  0.990374
## FBgn0266617    9.648855     -0.4357749  0.983164 -0.4432374  0.657594  0.990374
## FBgn0265633    2.291440      0.3467829  1.882149  0.1842484  0.853819  0.990374
## FBgn0264617   67.131764      0.0245325  0.451334  0.0543556  0.956652  0.990374
## FBgn0085432 4688.232636     -0.0469812  0.270431 -0.1737268  0.862080  0.990374
## ...                 ...            ...       ...        ...       ...       ...
## FBgn0039928     653.783    -0.00994936  0.262637 -0.0378825  0.969781  0.990374
## FBgn0052017     114.906     0.02350299  0.369082  0.0636796  0.949225  0.990374
## FBgn0002521     168.778     0.05777885  0.347249  0.1663903  0.867850  0.990374
## FBgn0039924     170.213    -0.20850730  0.409865 -0.5087219  0.610947  0.990374
## FBgn0027101     343.009    -0.21151750  0.290061 -0.7292177  0.465868  0.990374
```

We can also make multiple pairwise-comparisons by ignoring the `contrast.numer`
and `contrast.denom` arguments, and instead using the `comparisons` argument.
The resulting list of results is named according to the comparisons:

```
comparison_list <- list(c("B", "A"),
                        c("C", "A"),
                        c("C", "B"))
dsres <- getDESeqResults(dds, comparisons = comparison_list,
                         quiet = TRUE, ncores = 1)
names(dsres)
```

```
## [1] "B_vs_A" "C_vs_A" "C_vs_B"
```

```
dsres$C_vs_B
```

```
## log2 fold change (MLE): condition C vs B
## Wald test p-value: condition C vs B
## DataFrame with 111 rows and 6 columns
##               baseMean log2FoldChange     lfcSE       stat    pvalue      padj
##              <numeric>      <numeric> <numeric>  <numeric> <numeric> <numeric>
## FBgn0267363    0.00000             NA        NA         NA        NA        NA
## FBgn0266617    9.38822      0.3938871  0.901764   0.436796  0.662259  0.998692
## FBgn0265633    2.28968     -0.3206785  1.718554  -0.186598  0.851976  0.998692
## FBgn0264617   65.30695     -0.0773192  0.415908  -0.185905  0.852520  0.998692
## FBgn0085432 4281.29059     -0.1902162  0.229704  -0.828094  0.407617  0.998692
## ...                ...            ...       ...        ...       ...       ...
## FBgn0039928    696.482      0.2150507  0.248408  0.8657159  0.386646  0.998692
## FBgn0052017    133.743      0.4160583  0.333948  1.2458762  0.212810  0.998692
## FBgn0002521    171.141      0.0159143  0.323995  0.0491188  0.960825  0.998692
## FBgn0039924    138.749     -0.3685073  0.327200 -1.1262461  0.260061  0.998692
## FBgn0027101    347.104      0.2699312  0.271542  0.9940675  0.320190  0.998692
```