|  |  |
| --- | --- |
| identify {siggenes} | R Documentation |

## SAM specific identify method

### Description

Obtaining gene-specific information on a gene by clicking on the corresponding point in the
SAM plot

### Usage

```
identify(x, showText = TRUE, getInfo = TRUE, pos = 4, cex = 0.8, add.xy = numeric(2),
	n.digits = 3, ask = FALSE, ll = FALSE, browse = FALSE, chip= "", ...)
```

### Arguments

|  |  |
| --- | --- |
| `x` | a SAM object |
| `showText` | logical indicating if the gene name should be plotted near the identified point |
| `pos` | numerical value specifying the place where the gene name is plotted. Default is `4` (to the right of the point). For details and other specifications see `?text` |
| `cex` | numerical value specifying the relative size of the plotted text. For details see `?par` |
| `add,xy` | a numerical vector of length 2. The text is plotted `add.xy[1]` units in x-direction and `add.xy[2]` units in the y-direction from the position where it is plotted by default |
| `n.digits` | integer specifying the number of decimal places in the output |
| `ask` | logical indicating if the user should be asked before the next point can be identified |
| `ll` | logical indicating if both the locus links and the symbols of the genes should be added to the output |
| `browse` | logical indicating if the NCBI webpage corresponding to the locus link of the identified point is opened. Ignored if `ll=FALSE` |
| `chip` | character string specifying the chip type used in this analysis. Ignored if `ll=FALSE`, If the argument `data` in `sam(data,cl,...)` has been specified by an `ExpressionSet` object chip need not to be specified |
| >code>... | further options such as `col for the plotted text. See ?text` |

### Note

SAM was deveoped by Tusher et al. (2001).

!!! There is a patent pending for the SAM technology at Stanford University. !!!

### Author(s)

Holger Schwender, holger.schw@gmx.de

### References

Tusher, V.G., Tibshirani, R., and Chu, G. (2001). Significance analysis of microarrays
applied to the ionizing radiation response. *PNAS*, 98, 5116-5121.

### See Also

`sam`, `SAM-class`, `[summary](summary.sam.html)`