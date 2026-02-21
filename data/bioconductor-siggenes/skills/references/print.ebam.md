|  |  |
| --- | --- |
| print {siggenes} | R Documentation |

## EBAM specific print method

### Description

Prints the numbers of differentially expressed genes and the estimated FDRs for
a set of values of `delta` when performing an Empirical Bayes Analysis of
Microarrays.

### Usage

```
  print(x, delta = NULL, n.digits = 4)
```

### Arguments

|  |  |
| --- | --- |
| `x` | an EBAM object |
| `delta` | a numeric value or vector between 0 and 1 specifying the minimum posterior probabilities for a gene to be called differentially expressed. If `NULL`, the values of `delta` are used that have been specified when generating the EBAM object specified by `x` |
| `n.digits` | an integer specifying the number of decimal places in the output |

### Author(s)

Holger Schwender, holger.schw@gmx.de

### References

Efron, B., Tibshirani, R., Storey, J.D. and Tusher, V. (2001). Empirical Bayes Analysis
of a Microarray Experiment, *JASA*, 96, 1151-1160.

Schwender, H., Krause, A. and Ickstadt, K. (2003). Comparison of
the Empirical Bayes and the Significance Analysis of Microarrays.
*Technical Report*, SFB 475, University of Dortmund, Germany.