|  |  |
| --- | --- |
| plot {siggenes} | R Documentation |

## SAM specific plot method

### Description

Plots an object of class SAM. Generates either a SAM plot or a Delta plot

### Usage

```
   plot(x, y, pos.stats = NULL, sig.col = 3, xlim = NULL, ylim = NULL, main = NULL,
	xlab = NULL, ylab = NULL,´pty = "s", lab = c(10, 10, 7), pch = NULL, sig.cex = 1,
	helplines = FALSE, ...)
```

### Arguments

|  |  |
| --- | --- |
| `x` | an object of class SAM |
| `y` | the delta value(s), i.e. either a numeric value or vector. If y is a numeric value, a SAM Plot for this delta value will be generated. If NULL or a vector, the Delta plots, i.e. a visualization of the table created by `summary` or `print`, are generated |
| `pos.stats` | an integer between 0 and 2. If `pos.stats=1`, general information as the number of significant genes and the estimated FDR for the specified value of `y` will be plotted in the upper left corner of the plot. If `pos.stats=2`, these information will be plotted in the lower right corner. If `pos.stats=0`, no information will be plotted. By default, `pos.stats=1` if the expression score *d* can be both positive and negative, and `pos.stats=2` if *d* can only take positive values. Will be ignored when `y` is NULL or a vector |
| `sig.col` | a specification of the color of the significant genes. If `sig.col` has length 1, all the points corresponding to significant genes are marked in the color specified by `sig.col`. If `length(sig.col)==2`, the down-regulated genes, i.e. the genes with negative expression score *d*, are marked in the color specified by `sig.col`[1], and the up-regulated genes, i.e. the genes with positive *d*, are marked in the color specified by `sig.col`[2]. For a description of how colors are specified, see `?par`. Will be ignored if `y` is NULL or a vector |
| `xlim` | a numeric vector of length 2 specifying the x limits (minimum and maximum) of the plot. Only used when `y` is a numeric value, i.e. when a SAM plot is generated |
| `ylim` | a numeric vector of length 2 specifying the y limits of the plot. Only used when `y` is a numeric value |
| `main` | a character string naming the main title of the plot. Ignored if `y` is NULL or a vector |
| `xlab` | a character string naming the label of the x axis. Ignored if `y` is NULL or a vector |
| `ylab` | a character string naming the label of the y axis. Ignored if `y` is NULL or a vector |
| `pty` | a character specifying the type of plot region to be used. `"s"` (default) generates a square plotting region, and `"m"` the maximal plotting region. Ignored if `y` is NULL or a vector |
| `lab` | a numeric vector of length 3 specifying the approximate number of tickmarks on the x axis and on the y axis and the label size. Ignored if `y` is NULL or a vector |
| `pch` | either an integer specifying a symbol or a single character to be used as the default in plotting points. For a description of how `pch` can be specified, see `?par`. Ignored if `y` is NULL or a vector |
| `sig.cex` | a numerical value giving the amount by which the symbols of the significant genes should be scaled relative to the default. Ignored if `y` is NULL or a vector |
| `helplines` | logical specifying if help lines should be drawn into the Delta plots. Ignored if `y` is a numeric value |
| `...` | further graphical parameters for the SAM plot. See `?plot.default` and `?par`. Ignored if `y` is NULL or a vector |

### Value

a SAM plot or a Delta plot

### Note

SAM was deveoped by Tusher et al. (2001).

!!! There is a patent pending for the SAM technology at Stanford University. !!!

### Author(s)

Holger Schwender, holger.schw@gmx.de

### References

Tusher, V.G., Tibshirani, R., and Chu, G. (2001). Significance analysis of microarrays
applied to the ionizing radiation response. *PNAS*, 98, 5116-5121.

### See Also

`sam.plot2`, `delta.plot`, `sam`, `SAM-class`

### Examples

```
## Not run:
  # Load the package multtest and the data of Golub et al. (1999)
  # contained in multtest.
  library(multtest)
  data(golub)

  # Perform a SAM analysis for the two class unpaired case assuming
  # unequal variances.
  sam.out<-sam(golub,golub.cl,B=100,rand=123)

  # Generate a SAM plot for Delta = 2
  sam.plot2(sam.out,2)

  # Alternatively way of generating the same SAM plot
  plot(sam.out,2)

  # Generate the Delta plots for the default set of Deltas computed by sam.
  delta.plot(sam.out)

  # Another way of generating the same plot.
  plot(sam.out)

  # Generate the Delta plots for Delta = 0.2, 0.4, ..., 2.
  plot(sam.out,seq(0.2,2,0.2))
## End(Not run)
```