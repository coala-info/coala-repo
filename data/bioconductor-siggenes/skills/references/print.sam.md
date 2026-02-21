|  |  |
| --- | --- |
| print {siggenes} | R Documentation |

## SAM specific print method

### Description

Prints the statistics (FDR, number of differentially expressed genes etc.) for an object
of class SAM

### Usage

```
  print(x, delta = NULL, n.digits = 3)
```

### Arguments

|  |  |
| --- | --- |
| `x` | a SAM object |
| `delta` | a numeric value or vector specifying one or a set of Deltas for which statistics as the number of differentially expressed genes and the estimated FDR should be plotted. If `NULL` the Delta values of `x` will be used |
| `n.digits` | an integer specifying the number of decimal places in the output |

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