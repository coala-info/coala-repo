# Package venn

This package produces Venn diagrams for up to seven sets, using any
Boolean union of set intersections.

## Installation

Install the stable version from CRAN:

```
install.packages("venn")
```

## Examples

A simple Venn diagram with 3 sets

```
venn(3)
```

![](man/figures/fig01.svg)

With a vector of counts: 1 for “000”, 2 for “001” etc.

```
venn(3, counts = 1:8)
```

![](man/figures/fig02.svg)

Display the first whole set

```
venn("1--")
```

![](man/figures/fig03.svg)

Same with

```
venn("A", snames = "A, B, C")
```

![](man/figures/fig03.svg)

An equivalent command, from the union of all intersections

```
venn("100 + 110 + 101 + 111")
```

![](man/figures/fig03.svg)

Same with

```
venn("A~B~C + AB~C + A~BC + ABC")
```

![](man/figures/fig03.svg)

Adding the labels for the intersections

```
venn("1--", ilabels = TRUE)
```

![](man/figures/fig04.svg)

Using different parameters for the borders

```
venn(4, lty = 5, col = "navyblue")
```

![](man/figures/fig05.svg)

Using ellipses

```
venn(4, lty = 5, col = "navyblue", ellipse = TRUE)
```

![](man/figures/fig06.svg)

A 5 sets Venn diagram

```
venn(5)
```

![](man/figures/fig07.svg)

A 5 sets Venn diagram using ellipses

```
venn(5, ellipse = TRUE)
```

![](man/figures/fig08.svg)

A 5 sets Venn diagram with intersection labels

```
venn(5, ilabels = TRUE)
```

![](man/figures/fig09.svg)

And a predefined color style

```
venn(5, ilabels = TRUE, zcolor = "style")
```

![](man/figures/fig10.svg)

A union of two sets

```
venn("1---- + ----1")
```

![](man/figures/fig11.svg)

Same with

```
venn("A + E", snames = "A, B, C, D, E")
```

![](man/figures/fig11.svg)

With different colors

```
venn("1---- , ----1", zcolor = "red, blue")
```

![](man/figures/fig12.svg)

Same using SOP - sum of products notation

```
venn("A, E", snames = "A, B, C, D, E", zcolor = "red, blue")
```

![](man/figures/fig12.svg)

Same colors for the borders

```
venn("1---- , ----1", zcolor = "red, blue", col = "red, blue")
```

![](man/figures/fig13.svg)

A 6 sets diagram

```
venn(6)
```

![](man/figures/fig14.svg)

Seven sets “Adelaide”

```
venn(7)
```

![](man/figures/fig15.svg)

Artistic version

```
venn(c("1000000", "0100000", "0010000", "0001000",
       "0000100", "0000010", "0000001", "1111111"))
```

![](man/figures/fig16.svg)

Without all borders

```
venn(c("1000000", "0100000", "0010000", "0001000",
       "0000100", "0000010", "0000001", "1111111"),
     borders = FALSE)
```

![](man/figures/fig17.svg)

Using SOP - sum of products notation

```
venn("A + B~C", snames = "A, B, C, D")
```

![](man/figures/fig18.svg)

The input can be a list

```
set.seed(12345)
x <- list(First = 1:20, Second = 10:30, Third = sample(25:50, 15))
venn(x, ilabels = "counts")
```

![](man/figures/fig19.svg)

Or a dataframe

```
set.seed(12345)
x <- as.data.frame(matrix(sample(0:1, 150, replace = TRUE), ncol = 5))
venn(x, ilabels = "counts")
```

![](man/figures/fig20.svg)

Using ggplot2 graphics

```
venn(x, ilabels = "counts", ggplot = TRUE)
```

![](man/figures/fig21.svg)

Increasing the border size

```
venn(x, ilabels = "counts", ggplot = TRUE, size = 1.5)
```

![](man/figures/fig22.svg)

With dashed lines

```
venn(x, ilabels = "counts", ggplot = TRUE, linetype = "dashed")
```

![](man/figures/fig23.svg)

Venn diagrams for QCA objects

```
library(QCA)

data(CVF)
obj <- truthTable(CVF, "PROTEST", incl.cut = 0.85)

venn(obj)
```

![](man/figures/fig24.svg)

Custom labels for intersections

```
pCVF <- minimize(obj, include = "?")
venn(pCVF$solution[[1]], zcol = "#ffdd77, #bb2020, #1188cc")
cases <- paste(c("HungariansRom", "CatholicsNIreland", "AlbaniansFYROM",
                 "RussiansEstonia"), collapse = "\n")
coords <- unlist(getCentroid(getZones(pCVF$solution[[1]][2])))
text(coords[1], coords[2], labels = cases, cex = 0.85)
```

![](man/figures/fig25.svg)