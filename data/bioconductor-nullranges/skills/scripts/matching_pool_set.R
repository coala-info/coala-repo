# Code example from 'matching_pool_set' vignette. See references/ for full tutorial.

## ----message=FALSE, warning=FALSE---------------------------------------------
library(AnnotationHub)
ah <- AnnotationHub()

dnase <- ah[["AH30743"]]
junPeaks <- ah[["AH22814"]]

dnase

## ----message=FALSE, warning=FALSE---------------------------------------------
library(plyranges)
dnase <- dnase |>
  mutate(log10_signal = log10(signalValue + 1),
         log10_length = log10(width(dnase) + 1))

## ----message=FALSE, warning=FALSE---------------------------------------------
## Define focal and pool
focal <- dnase |>
  filter_by_overlaps(junPeaks)

pool <- dnase |>
  filter_by_non_overlaps(junPeaks)


## ----message=FALSE, warning=FALSE---------------------------------------------
length(focal)
length(pool)

length(pool)/length(focal)

## ----message=FALSE, warning=FALSE---------------------------------------------
## Before matching, focal shows higher
## signalValue than pool
library(tidyr)
library(ggplot2)
bind_ranges(focal=focal,
            pool=pool,
            .id="set") |>
  as.data.frame() |>
  pivot_longer(cols=c("log10_length", "log10_signal"),
               names_to="features",
               values_to="values") |>
  ggplot(aes(values, color=set)) +
  facet_wrap(~features) +
  stat_density(geom='line', position='identity') +
  ggtitle("DNase sites") +
  theme_bw() +
  theme(plot.title=element_text(hjust=0.5))

## ----message=FALSE, warning=FALSE---------------------------------------------
library(nullranges)
set.seed(123)
mgr <- matchRanges(focal=focal,
                   pool=pool,
                   covar=~log10_length + log10_signal,
                   method='rejection',
                   replace=FALSE)

mgr

## ----message=FALSE, warning=FALSE---------------------------------------------
library(patchwork)
lapply(covariates(mgr),
       plotCovariate,
       x=mgr,
       sets=c('f', 'm', 'p')) |>
  Reduce('+', x=_) +
  plot_layout(guides="collect") +
  plot_annotation(title="DNase sites",
                  theme=theme(plot.title=element_text(hjust=0.40)))

## ----message=FALSE, warning=FALSE---------------------------------------------
library(cobalt)
res <- bal.tab(f.build("set", covariates(mgr)),
               data=matchedData(mgr)[!set %in% 'unmatched'],
               distance="ps",
               focal="focal",
               which.treat="focal",
               s.d.denom="all")

res

plot(res) + xlim(c(-2, 2))


