|  |  |
| --- | --- |
| plot {siggenes} | R Documentation |

## EBAM specific plot method

### Description

Generates a plot of the posterior probabilities given by an object of class EBAM.

### Usage

```
   plot(x, y, pos.stats = 2, sig.col = 3, sig.cex = 1, pch = NULL, stats.cex = 0.8,
        main = NULL, xlab = NULL, ylab = NULL, y.intersp = 1.3, ...)
```

### Arguments

|  |  |
| --- | --- |
| `x` | an object of class EBAM |
| `y` | the delta value, i.e. the minimum probability for a gene to be called differentially expressed |
| `pos.stats` | an integer between 0 and 4. If `pos.stats=1`, general information as the number of significant genes and the estimated FDR for the specified value of `y` will be plotted in the upper center of the plot. If `pos.stats=2`, these information will be plotted in the bottom right corner, if `pos.stats=3` in the bottom left corner, and if `pos.stats=4` in the upper left corner. If `pos.stats=0`, no information will be plotted |
| `sig.col` | a specification of the color of the significant genes. For a description of how colors are specified, see the help of `par` |
| `sig.cex` | a numeric value giving the amount by which the symbols of the significant genes should be scaled relative to the default |
| `pch` | either an integer specifying a symbol or a single character to be used as the default in plotting points. For a description of how `pch` can be specified, see the help of `par` |
| `stats.cex` | the size of the statistics printed in the plot relative to the default size |
| `main` | a character string naming the main title of the plot |
| `xlab` | a character string naming the label of the x axis |
| `ylab` | a character string naming the label of the y axis |
| `y.intersp` | a numeric value specifying the space between the rows in which the statistics are plotted |
| `...` | further graphical parameters for the EBAM plot. See the help pages of `plot.default` and `par` |

### Value

a plot of the posterior probabilities of the genes for a specified value of
`delta`

### Author(s)

Holger Schwender, holger.schw@gmx.de

### References

Efron, B., Tibshirani, R., Storey, J.D. and Tusher, V. (2001). Empirical Bayes Analysis
of a Microarray Experiment, *JASA*, 96, 1151-1160.

Schwender, H., Krause, A. and Ickstadt, K. (2003). Comparison of
the Empirical Bayes and the Significance Analysis of Microarrays.
*Technical Report*, SFB 475, University of Dortmund, Germany.