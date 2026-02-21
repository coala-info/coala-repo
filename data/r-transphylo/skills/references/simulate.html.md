Toggle navigation

[TransPhylo](../index.html)
1.4.10

* [Get started](../articles/TransPhylo.html)
* [Reference](../reference/index.html)
* Articles
  + [Simulation of outbreak data](../articles/simulate.html)
  + [Inference of transmission tree from a dated phylogeny](../articles/infer.html)
  + [Simultaneous Inference of Multiple Transmission Trees](../articles/multitree.html)

# Simulation of outbreak data

#### Xavier Didelot

#### 2023-09-26

`simulate.rmd`

If you want to reproduce exactly the same results as the ones shown in this tutorial, you need to set the seed of your random number generator to zero:

```
library(TransPhylo)
set.seed(0)
```

A pathogen has an effective within-host population size of \(N\_e=100\) and a generation time \(g=1\) day, so that \(N\_e g=100/365\) year. The offspring distribution is negative binomial with mean equal to the basic reproduction number \(R=5\). Both the generation time and the sampling time are Gamma distributed with parameters (10,0.1) which has a mean of 1 year. The density of sampling is \(\pi=0.25\). The following commands specify these parameters:

```
neg=100/365
off.r=5
w.shape=10
w.scale=0.1
pi=0.25
```

We simulate an outbreak that starts in 2005 and which and is observed up to 2008:

```
simu <- simulateOutbreak(neg=neg,pi=pi,off.r=off.r,w.shape=w.shape,
                         w.scale=w.scale,dateStartOutbreak=2005,dateT=2008)
```

This simulation contains both the transmission tree between infected hosts and the within-host phylogenetic tree of each host. This can be visualised as a colored phlogenetic tree, where each host is represented by a unique color:

```
plot(simu)
```

![](simulate_files/figure-html/unnamed-chunk-5-1.png)

The transmission tree can be extracted and plotted separately from the phylogeny:

```
ttree<-extractTTree(simu)
plot(ttree)
```

![](simulate_files/figure-html/unnamed-chunk-6-1.png)

A more detailed plot can be displayed as follows:

```
plot(ttree,type='detailed',w.shape,w.scale)
```

![](simulate_files/figure-html/unnamed-chunk-7-1.png)

The phylogenetic tree can be extracted and plotted separately from the transmission tree:

```
ptree<-extractPTree(simu)
plot(ptree)
```

![](simulate_files/figure-html/unnamed-chunk-8-1.png)

The extracted phylogenetic tree can also be converted into a phylo object from the ape package:

```
library(ape)
p<-phyloFromPTree(ptree)
plot(p)
axisPhylo(backward = F)
```

![](simulate_files/figure-html/unnamed-chunk-9-1.png)

You can save this tree into a Newick file for further analysis. This is the tree that is used as the starting poit of the tutorial on inference of a transmission tree from a dated phylogeny.

```
write.tree(p,'tree.nwk')
```

The content of this Newick file is:

```
write.tree(p,'')
```

```
## [1] "((4:1.257652937,(1:1.231048819,5:1.519248672):0.303038892):0.784065883,(3:1.643413444,(6:0.656820028,2:0.007344035611):0.7562780805):1.293120815);"
```

This phylogeny is scaled in years, but time is measured only relatively to the date of the last sample which is at 0 on the x-axis of the figure above. To use this tree again we also need to know exactly when was the last sample taken:

```
dateLastSample(simu)
```

```
## [1] 2007.964
```

Developed by Xavier Didelot.

Site built with [pkgdown](https://pkgdown.r-lib.org/) 2.0.7.