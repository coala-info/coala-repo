|  |  |
| --- | --- |
| summary {siggenes} | R Documentation |

## EBAM specific summary method

### Description

Summarizes an EBAM analysis for a given value of `delta`.
Computes both general statistics such as the number of differentially
expressed genes and the estimated FDR, and gene-specific statistics
such as the expression scores and the local FDRs for the differentially
expressed genes.

### Usage

```
summary(object, delta = NULL, n.digits = 4, what = "both", entrez = FALSE, chip = "",
	file = "", sep = "\t", quote = FALSE, dec=".")
```

### Arguments

|  |  |
| --- | --- |
| `object` | a SAM object |
| `delta` | a numeric value between 0 and 1 specifying the minimum posterior probability for a gene to be called differentially expressed |
| `n.digits` | an integer specifying the number of decimal places in the output |
| `what` | either "both", "stats" or "genes". If "stats" general information is shown. If "genes" gene-specific information is given. If "both" both general and gene-specific information is shown |
| `entrez` | logical. If `TRUE` both the Entrez links and the symbols of the genes will be added to the output |
| `chip` | character string naming the chip type used in this analysis. Only needed if `entrez = TRUE`. If the input of either `find.a0` or `ebam` is an ExpressionSet object, `chip` needs not to be specified |
| `file` | character string naming the file in which the information should be stored. By default the information is not stored, but shown in the R window |
| `sep` | the field separator string used when output is stored in `file` |
| `quote` | logical indicating if character strings and factors should be surrounded by double quotes. For details, see the help page of `write.table` |
| `dec` | the string to use for decimal points |

### Value

The output of `summary` is a `sumEBAM` object
consisting of the following slots:

|  |  |
| --- | --- |
| `row.sig.genes` | a numeric vector specifying the rows of the data matrix containing the differentially expressed genes |
| `mat.fdr` | a matrix containing general information as the estimated FDR and the number of differentially expressed genes |
| `mat.sig` | a data frame containing gene-specific information on the differentially expressed genes |
| `list.args` | a list containing the arguments of `summary` needed for internal use |

### Author(s)

Holger Schwender, holger.schw@gmx.de

### References

Efron, B., Tibshirani, R., Storey, J.D. and Tusher, V. (2001). Empirical Bayes Analysis
of a Microarray Experiment, *JASA*, 96, 1151-1160.

Schwender, H., Krause, A. and Ickstadt, K. (2003). Comparison of
the Empirical Bayes and the Significance Analysis of Microarrays.
*Technical Report*, SFB 475, University of Dortmund, Germany.