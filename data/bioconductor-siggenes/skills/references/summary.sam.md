|  |  |
| --- | --- |
| summary {siggenes} | R Documentation |

## SAM specific summary method

### Description

Summarizes a SAM analysis. Computes either general statistics as the number of differentially
expressed genes and the estimated FDR for a vector of Delta values or gene-specific statistics
for the differentially expressed genes when just one Delta value is specified

### Usage

```
summary(object, delta = NULL, n.digits = 5, what = "both", entrez = FALSE, bonf = FALSE,
	chip = "", file = "", sep = "\t", quote = FALSE, dec=".")
```

### Arguments

|  |  |
| --- | --- |
| `object` | a SAM object |
| `delta` | a numeric value or vector specifying one or a set of Deltas. If `NULL` or a vector general statistics as the number of differentially expressed genes and the estimated FDR will be computed. If `delta` is a value not only the above statistics will be computed but also gene-specific information on the differentially expressed genes will be given -- see `what` |
| `n.digits` | an integer specifying the number of decimal places in the output |
| `what` | either "both", "stats" or "genes". If "stats" general information is shown. If "genes" gene-specific information is given. If "both" both general and gene-specific information is shown. Will be ignored if `delta` is `NULL` or a vector |
| `entrez` | logical. If `TRUE` both the Entrez links and the symbols of the genes will be added to the output |
| `bonf` | logical. If `TRUE` Bonferroni corrected p-values will be added to the output |
| `chip` | character string naming the chip type used in this analysis. Only needed if `entrez = TRUE`. If the argument `data` of `sam(data,cl,...)` has been specified by an `ExpressionSet` object `chip` need not to be specified |
| `file` | character string naming the file in which the information should be stored. By default the information is not stored but shown in the R window. Will be ignored if `delta is NULL or a vector` |
| `sep` | the field separator string used when output is stored in `file` |
| `quote` | logical indicating if character strings and factors should be surrounded by double quotes. For details see `?write.table` |
| `dec` | the string to use for decimal points |

### Value

The output of `summary consists of the following slots:

|  |  |
| --- | --- |
| row.sig.genes | a numeric vector specifying the rows of the data matrix containing the differentially expressed genes. If  is NULL or a vector, row.sig.genes> will be numeric(0) |
| mat.fdr | a numeric vector (if delta is a numeric value) or a matrix containing general information as the estimated FDR and the number of differentially expressed genes |
| mat.sig | a data frame containing gene-specific information on the differentially expressed genes |
| list.args | a list containing the arguments of summary needed for internal use |

### Note

SAM was deveoped by Tusher et al. (2001).

!!! There is a patent pending for the SAM technology at Stanford University. !!!

### Author(s)

Holger Schwender, holger.schw@gmx.de

### References

Tusher, V.G., Tibshirani, R., and Chu, G. (2001). Significance analysis of microarrays
applied to the ionizing radiation response. PNAS, 98, 5116-5121.

### See Also

sam, SAM-class, [print](print.sam.html),
sam2excel, sam2html`