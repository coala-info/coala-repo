# Stratified Histograms

Nikos Ignatiadis

#### 4 November 2025

#### Package

IHWpaper 1.38.0

# Contents

* [1 Old example](#old-example)
* [2 Examples for Figure 1 of paper](#examples-for-figure-1-of-paper)
  + [2.1 Figure 1 of paper](#figure-1-of-paper)

Vignette generating examples for stratified histograms.

```
library("ggplot2")
library("cowplot")
```

# 1 Old example

```
set.seed(1)

m <- 10000
binwidth <- 0.025

# generic function to add some properties to gg histograms
gg_hist_aesthetic <-  function(gg_obj, ylim_max=650) {
    gg_obj +
             scale_x_continuous(expand = c(0.02, 0)) +
             scale_y_continuous(expand = c(0.02, 0), limits=c(0,ylim_max)) +
             xlab("p-value")+
             ylab("Counts")+
             theme(axis.title = element_text(face="bold",size=rel(0.1)) )
}
```

```
pv_unif <- data.frame(pvalue=runif(m))
gg_unif <- ggplot(pv_unif, aes(x=pvalue)) +
            geom_histogram(binwidth = binwidth, boundary = 0, colour="lightgrey", fill="#939598") +
            geom_hline(yintercept=m*binwidth, size=2, col="darkblue")
gg_unif <- gg_hist_aesthetic(gg_unif)

gg_unif
```

![](data:image/png;base64...)

```
ggsave(plot=gg_unif, file="stratified_histograms_unif.pdf", width=4, height=3)
```

```
pv_beta_1 <- data.frame(pvalue=c(runif(9000), rbeta(1000,0.5,7)))

gg_beta_1 <- ggplot(pv_beta_1, aes(x=pvalue)) +
              geom_histogram(binwidth = binwidth, boundary = 0, colour="lightgrey", fill="#939598") +
              geom_hline(yintercept=9000*binwidth, size=1.3, col="darkblue")
gg_beta_1 <- gg_hist_aesthetic(gg_beta_1)
gg_beta_1
```

![](data:image/png;base64...)

```
ggsave(plot=gg_beta_1, file="stratified_histograms_beta1.pdf", width=4, height=3)
```

```
pv_beta_2 <- data.frame(pvalue=c(runif(5500), rbeta(4500,1,4)))

gg_beta_2 <- ggplot(pv_beta_2, aes(x=pvalue)) +
              geom_histogram(binwidth = binwidth, boundary = 0, colour="lightgrey", fill="#939598") +
              geom_hline(yintercept=5500*binwidth, size=1.3, col="darkblue")
gg_beta_2 <- gg_hist_aesthetic(gg_beta_2)
gg_beta_2
```

![](data:image/png;base64...)

```
ggsave(plot=gg_beta_2, file="stratified_histograms_beta2.pdf", width=4, height=3)
```

```
gg_stratified <- plot_grid(gg_unif, gg_beta_1, gg_beta_2,
                         nrow=1,
                         labels=c("a)", "b)", "c)"))
gg_stratified
```

![](data:image/png;base64...)

```
ggsave(plot=gg_stratified, file="stratified_histograms.pdf", width=12, height=4)
```

# 2 Examples for Figure 1 of paper

```
set.seed(1)

m <- 10000
binwidth <- 0.05
grey <- "grey41"
# generic function to add some properties to gg histograms
gg_hist_aesthetic <-  function(gg_obj, ylim_max=6) {
    gg_obj +
             aes(y=..density..)+
             scale_x_continuous(expand = c(0.02, 0), breaks=c(0,0.5,1)) +
             scale_y_continuous(expand = c(0.02, 0), limits=c(0,ylim_max)) +
             xlab("p-value")+
             ylab("Density")+
             theme(axis.title = element_text(face="bold",size=rel(0.7)))
}
```

```
pv_unif <- data.frame(pvalue=runif(m))
gg_unif <- ggplot(pv_unif, aes(x=pvalue)) +
            geom_histogram(binwidth = binwidth, boundary = 0, colour=grey, fill="lightgrey")
gg_unif <- gg_hist_aesthetic(gg_unif)

gg_unif
```

![](data:image/png;base64...)

```
pv_beta_a <- data.frame(pvalue=c(runif(9000), rbeta(1000,0.5,4)))

gg_beta_a <- ggplot(pv_beta_a, aes(x=pvalue)) +
              geom_histogram(binwidth = binwidth, boundary = 0, colour=grey, fill="lightgrey")
gg_beta_a <- gg_hist_aesthetic(gg_beta_a)
gg_beta_a
```

![](data:image/png;base64...)

```
pv_beta_b <- data.frame(pvalue=c(runif(8000), rbeta(2000,0.5,11)))

gg_beta_b <- ggplot(pv_beta_b, aes(x=pvalue)) +
              geom_histogram(binwidth = binwidth, boundary = 0, colour=grey, fill="lightgrey")

gg_beta_b <- gg_hist_aesthetic(gg_beta_b, ylim_max=5.5)
gg_beta_b
```

![](data:image/png;base64...)

```
pv_all <- rbind(pv_unif, pv_beta_b, pv_beta_a)
gg_all <- ggplot(pv_all, aes(x=pvalue)) +
              geom_histogram(binwidth = binwidth, boundary = 0, colour=grey, fill="lightgrey")
gg_all <- gg_hist_aesthetic(gg_all)
gg_all
```

![](data:image/png;base64...)

## 2.1 Figure 1 of paper

```
gg_stratified <- plot_grid(gg_all, gg_beta_b, gg_beta_a, gg_unif,
                         nrow=1,
                         labels=c("a)", "b)", "c)","d)"))
gg_stratified
```

![](data:image/png;base64...)

```
ggsave(plot=gg_stratified, file="stratified_histograms.pdf", width=6, height=2)
```