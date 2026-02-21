# Grenander Estimator as applied to IHW (vs ECDF)

Nikos Ignatiadis

#### 4 November 2025

#### Package

IHWpaper 1.38.0

This vignette is meant to illustrate how the distribution function of some p-values can be approximated by the ECDF and how the ECDF compares to the Grenander estimator, i.e. the least concave majorant (LCM) of the ECDF. The advantage of the Grenander estimator is that it convexifies the underlying optimization problem of IHW

```
library("IHWpaper")
library("fdrtool")
library("ggplot2")
library("cowplot")
theme_set(theme_cowplot())
```

First we generate some p-values based on 100 independent t-tests. And calculate the ECDF and Grenander estimator.

```
sim <- du_ttest_sim(100, 0.5, 2.5 ,seed=100)

sorted_pvalues <- sort(sim$pvalue)
n  <- length(sorted_pvalues)
unique_pvalues <- unique(sorted_pvalues)
ecdf_values <- cumsum(tabulate(match(sorted_pvalues, unique_pvalues)))/n

df_ecdf <- data.frame(x=unique_pvalues,y=ecdf_values)
gren <- IHW:::presorted_grenander(sorted_pvalues)
df_gren <- data.frame(x=gren$x.knots, y=gren$y.knots)
```

Let’s plot the ECDF:

```
ggplot(df_ecdf, aes(x=x, y=y)) + geom_step(direction="hv",size=1.3) +
                  scale_x_continuous(expand=c(0,0),lim=c(0,1))+
                  scale_y_continuous(expand=c(0,0))+
                  xlab("p-value") +
                  ylab("Distribution")
```

![](data:image/png;base64...)

```
ggsave(filename="ecdf_plot.pdf", width=7,height=7)
```

Also plot the Grenander estimator:

```
ggplot(df_ecdf, aes(x=x, y=y)) + geom_step(direction="hv",size=1.3) +
  geom_line(data=df_gren, aes(x=x,y=y), color="red",size=1.3) +
                  scale_x_continuous(expand=c(0,0),lim=c(0,1))+
                  scale_y_continuous(expand=c(0,0))+
                  xlab("p-value") +
                  ylab("Distribution")
```

![](data:image/png;base64...)

```
ggsave(filename="ecdf_grenander_plot.pdf", width=7,height=7)
```