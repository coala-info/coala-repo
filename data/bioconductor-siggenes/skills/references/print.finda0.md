|  |  |
| --- | --- |
| print {siggenes} | R Documentation |

## FindA0 specific print method

### Description

Prints the numbers of differentially expressed genes and the estimated FDRs for a set
of possible values for the fudge factor in an Empirical Bayes Analysis of
Microarrays.

### Usage

```
  print(x, delta = NULL)
```

### Arguments

|  |  |
| --- | --- |
| `x` | a FindA0 object |
| `delta` | a numeric value between 0 and 1 specifying the minimum posterior probability for a gene to be called differentially expressed. If `NULL`, the value of `delta` is used that has been specified when generating the `FindA0` object specified by `x` |

### Author(s)

Holger Schwender, holger.schw@gmx.de

### References

Efron, B., Tibshirani, R., Storey, J.D. and Tusher, V. (2001). Empirical Bayes Analysis
of a Microarray Experiment, *JASA*, 96, 1151-1160.

Schwender, H., Krause, A. and Ickstadt, K. (2003). Comparison of
the Empirical Bayes and the Significance Analysis of Microarrays.
*Technical Report*, SFB 475, University of Dortmund, Germany.