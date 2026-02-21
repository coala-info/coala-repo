# BH explanation / visualization

Nikos Ignatiadis

#### 4 November 2025

#### Package

IHWpaper 1.38.0

# Contents

* [1 B.Sc. thesis plot (low \(\pi\_0\))](#b.sc.-thesis-plot-low-pi_0)
* [2 Bioc presentation plot (higher \(\pi\_0\))](#bioc-presentation-plot-higher-pi_0)

Below we just generate the necessary plot to explain how BH works.

```
library("ggplot2")
library("dplyr")
```

```
##
## Attaching package: 'dplyr'
```

```
## The following objects are masked from 'package:stats':
##
##     filter, lag
```

```
## The following objects are masked from 'package:base':
##
##     intersect, setdiff, setequal, union
```

```
library("wesanderson")
library("grid")
library("gridExtra")
```

```
##
## Attaching package: 'gridExtra'
```

```
## The following object is masked from 'package:dplyr':
##
##     combine
```

```
library("IHW")
```

```
##
## Attaching package: 'IHW'
```

```
## The following object is masked from 'package:ggplot2':
##
##     alpha
```

# 1 B.Sc. thesis plot (low \(\pi\_0\))

Plot as in B.Sc. thesis with very low \(\pi\_0\). (Using this so it can be clearly demonstrated that the BH threshold is an intermediate threshold between the Bonferroni threshold and the uncorrected one, also such \(\pi\_0\) allows to show all p-values in the second plot and still observe the interesting behaviour.)

```
simpleSimulation <- function(m,m1,betaA,betaB){
    pvalue <- runif(m)
    H <- rep(0,m)
    alternatives <- sample(1:m,m1)

    pvalue[alternatives] <- rbeta(m1,betaA,betaB)
    H[alternatives] <-1

    simDf <- data.frame(pvalue = pvalue, group=runif(m), filterstat = runif(m), H=H)
    return(simDf)
}

set.seed(1)
sim <- simpleSimulation(1000, 700, 0.3, 8)
sim$rank <- rank(sim$pvalue)

histogram_plot <- ggplot(sim, aes(x=pvalue)) +
                    geom_histogram(binwidth=0.1, fill = wes_palette("Chevalier1")[4]) +
                    xlab("p-value") +
                    theme_bw()

bh_threshold <- get_bh_threshold(sim$pvalue, .1)

bh_plot <- ggplot(sim, aes(x=rank, y=pvalue)) +
  geom_step(col=wes_palette("Chevalier1")[4]) +
  ylim(c(0,0.2)) +
  geom_abline(intercept=0, slope= 0.1/1000, col = wes_palette("Chevalier1")[2]) +
  geom_hline(yintercept=bh_threshold, linetype=2) +
  annotate("text",x=250, y=0.065, label="BH testing") +
  geom_hline(yintercept = 0.1, linetype=2) +
  annotate("text",x=250, y=0.11, label="uncorrected testing") +
  geom_hline(yintercept = 0.1/1000, linetype=2) +
  annotate("text",x=850, y=0.1/1000+0.01, label="Bonferroni testing") +
  ylab("p-value") + xlab("rank of p-value") +
  theme_bw() + scale_colour_manual(values=wes_palette("Chevalier1")[c(3,4)])
```

```
grid.arrange(histogram_plot, bh_plot, nrow=1)
```

![](data:image/png;base64...)

```
pdf(file="bh_explanation.pdf", width=11, height=5)
grid.arrange(histogram_plot, bh_plot, nrow=1)
dev.off()
```

# 2 Bioc presentation plot (higher \(\pi\_0\))

For ddhw presentation, remake above plot with higher \(\pi\_0\).

```
set.seed(1)
sim <- simpleSimulation(10000, 2000, 0.3, 8)
sim$rank <- rank(sim$pvalue)

histogram_plot <- ggplot(sim, aes(x=pvalue)) +
                    geom_histogram(binwidth=0.1, fill = wes_palette("Chevalier1")[4]) +
                    xlab("p-value") +
                    theme_bw(14)

bh_threshold <- get_bh_threshold(sim$pvalue, .1)

bh_plot <- ggplot(sim, aes(x=rank, y=pvalue)) +
  geom_step(col=wes_palette("Chevalier1")[4], size=1.2) +
  scale_x_continuous(limits=c(0,2000),expand = c(0, 0))+
  scale_y_continuous(limit=c(0,0.06), expand=c(0,0)) +
  geom_abline(intercept=0, slope= 0.1/10000, col = wes_palette("Chevalier1")[2], size=1.2) +
  annotate("text",x=500, y=1.3*bh_threshold, label="BH rejection threshold") +
  geom_hline(yintercept=bh_threshold, linetype=2, size=1.2) +
  ylab("p-value") + xlab("rank of p-value") +
  theme_bw() + scale_colour_manual(values=wes_palette("Chevalier1")[c(3,4)])
```

```
## Warning: Using `size` aesthetic for lines was deprecated in ggplot2 3.4.0.
## ℹ Please use `linewidth` instead.
## This warning is displayed once every 8 hours.
## Call `lifecycle::last_lifecycle_warnings()` to see where this warning was
## generated.
```

```
grid.arrange(histogram_plot, bh_plot, nrow=1)
```

```
## Warning: Removed 4 rows containing missing values or values outside the scale range
## (`geom_step()`).
```

![](data:image/png;base64...)

```
pdf(file="bh_explanation_high_pi0.pdf", width=11, height=5)
grid.arrange(histogram_plot, bh_plot, nrow=1)
dev.off()
```