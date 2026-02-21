|  |  |
| --- | --- |
| plot {siggenes} | R Documentation |

## FindA0 specific plot method

### Description

Generates a plot of the (logit-transformed) posterior probabilities for a set of values
of the fudge factor in an Empirical Bayes Analysis of Microarrays.

### Usage

```
   plot(x, y, logit = TRUE, pos.legend = NULL, legend.cex = 0.8, col = NULL,
        main = NULL, xlab = NULL, ylab = NULL, only.a0 = FALSE, lty = 1, lwd = 1,
        y.intersp = 1.1, ...)
```

### Arguments

|  |  |
| --- | --- |
| `x` | an object of class FindA0 |
| `y` | the delta value, i.e. the minimum probability for a gene to be called differentially expressed |
| `logit` | should the posterior probabilities be logit-transformed before they are plotted? |
| `pos.legend` | an integer between 0 and 4. If `pos.stats=1`, general information as the number of significant genes and the estimated FDR for the specified value of `y` will be plotted in the upper center of the plot. If `pos.stats=2`, these information will be plotted in the bottom right corner, if `pos.stats=3` in the bottom left corner, and if `pos.stats=4` in the upper left corner. If `pos.stats=0`, no information will be plotted. By default, `pos.stats=1` if the expression scores can be both positive and negative, and `pos.stats=4` if they can only take positive values |
| `legend.cex` | the size of the text in the legend relative to the default size |
| `col` | a vector specifying the colors of the lines for the different values of the fudge factor `a0`. For a description of how colors are specified, see the help of `par` |
| `main` | a character string naming the main title of the plot |
| `xlab` | a character string naming the label of the x axis |
| `ylab` | a character string naming the label of the y axis |
| `only.a0` | if `TRUE`, only the values of `a0` are shown in the legend. If `FALSE`, both the values of `a0` and the corresponding numbers of differentially expressed genes are shown |
| `lty` | a value or vector specifying the line type of the curves. For details, see the help of `par` |
| `lwd` | a numeric value specifying the width of the plotted lines. For details, see the help of `par` |
| `y.intersp` | a numeric value specifying the space between the rows in the legend |
| `...` | further graphical parameters for the plot of the posterior probabilities. See the help pages of `plot.default` and `par` |

### Value

a plot of the (logit-transformed) posterior probabilities of the genes for a
set of values of the fudge factor

### Author(s)

Holger Schwender, holger.schw@gmx.de

### References

Efron, B., Tibshirani, R., Storey, J.D. and Tusher, V. (2001). Empirical Bayes Analysis
of a Microarray Experiment, *JASA*, 96, 1151-1160.

Schwender, H., Krause, A. and Ickstadt, K. (2003). Comparison of
the Empirical Bayes and the Significance Analysis of Microarrays.
*Technical Report*, SFB 475, University of Dortmund, Germany.