# Introduction to nullranges

The *nullranges* package contains functions for generation of sets of genomic ranges, represented as *GRanges* objects, for exploring various null hypotheses. For example, one may want to assess the significance of the overlap of two sets of ranges, by generating statistics of what would be expected *under the null distribution of no relationship between these sets*. We note that many other test statistics are supported via the flexible framework described here, combining *nullranges* with *plyranges*. The *nullranges* package contains a number of vignettes describing different functionality, from basic to more advanced usage. For a listing of all the vignettes in the package, one can type:

```
vignette(package="nullranges")
```

## Choice of methods

The *nullranges* package has two distinct branches of functionality: *matching* or *bootstrapping* to generate null sets of genomic ranges.

In the vignette sections below we describe these two branches and give more formal definitions, where each branch has associated vignettes and man page sections (see *Reference* tab from the package website). To give a high level overview, we first provide a **decision tree** that helps to indicate the considerations when choosing between these branches of functionality.

Define **features** as a set of genomic locations of interest, these are minimally represented with a chromosome, start and width, and optionally strand and metadata (genomic ranges). Given a set of features, suppose that we wish to create an alternate set that represents a null feature set, sometimes also referred to as “background” or a “control set”. For example, we may see that our primary features are close to transcription start sites, but are they closer than we would expect compared to a reasonable choice of null features?

Additionally, define **pool** as a much larger set of genomic locations compared to the primary features, and **covariates** as pieces of metadata attached to all of the considered features (stored as `mcols(<GRanges>)`, which may be continuous, integer, factor, etc.).

Our choice of methods is informed by the following:

* Are the features defined with respect to a pool, e.g. open chromatin sites bound by a protein, defined with respect to all open chromatin in a particular cell type?
* Are there important, potentially confounding covariates, e.g. does GC content, distance to particular landmarks, expression level, LD score, etc. potentially explain distribution of features in a way that should be controlled for in downstream analysis?
* Do the primary feature set and pool have different distribution of these potential confounding covariates?
* Does the local genomic context matter (*local* defined in genomic coordinate space)? Are we asking if primary features are *near in the genome* to the gene start sites or some other genomic feature set?
* Do the features tend to be distributed in genomic coordinate space such that they are *clustered*, e.g. open chromatin sites tend to occur near each other? Or do features that are near each other in the genome tend to have similar metadata of interest to the biological question, e.g. CpG’s near each other having similar levels of methylation, which will be used in downstream computations of average methylation near gene start site? Or is there variable feature density that must be accounted for via genome segmentation?

The following decision tree then informs what methods to choose:

In summary, while *matchRanges* does not control for genomic distribution and clustering of features, *bootRanges* does not directly control for feature covariates independent of proximity and local context.

## Related work

For general considerations of generation of null feature sets or segmentation for enrichment or colocalization analysis, consider the papers of De, Pedersen, and Kechris (2014), Haiminen, Mannila, and Terzi (2007), Huen and Russell (2010), Ferkingstad, Holden, and Sandve (2015), Dozmorov (2017), Kanduri et al. (2019) (with links in references below). Other Bioconductor packages that offer randomization techniques for enrichment analysis include [LOLA](https://bioconductor.org/packages/LOLA) (Sheffield and Bock 2016) and [regioneR](https://bioconductor.org/packages/regioneR) (Gel et al. 2016). Methods implemented outside of Bioconductor include [GAT](https://github.com/AndreasHeger/gat) (Heger et al. 2013), [GSC](https://github.com/ParkerLab/encodegsc) (Bickel et al. 2010), [GREAT](http://bejerano.stanford.edu/great/public/html/) (McLean et al. 2010), [GenometriCorr](https://github.com/favorov/GenometriCorr) (Favorov et al. 2012), [ChIP-Enrich](http://chip-enrich.med.umich.edu/) (Welch et al. 2014), and [OLOGRAM](https://dputhier.github.io/pygtftk/ologram.html) (Ferré et al. 2019).

We note that our block bootstrapping approach closely follows that of [GSC](https://github.com/ParkerLab/encodegsc), while offering additional features/visualizations, and is re-implemented within R/Bioconductor with efficient vectorized code for working with *GRanges* objects (Lawrence 2013). In addition, *regioneR* and *OLOGRAM* also offer randomization schemes that can preserve e.g. inter-feature distances.

In the context of these related works, a design choice of *nullranges* is its modularity: it solely generates null or background feature sets as Bioconductor objects, such that these can be used in workflows that compute and perform inference on arbitrary statistics within the *plyranges* (Lee, Cook, and Lawrence 2019) framework. We have referred to such workflows as “fluent genomics” (Lee, Lawrence, and Love 2020), or “tidy genomics”, as these workflows build up complex operations from commonly recognized verbs (filter, mutate, join, group by, summarize, etc.) strung together with pipes (`%>%`).

## Further description of matching and bootstrapping

Suppose we want to examine the significance of overlaps of genomic sets of features \(x\) and \(y\). To test the significance of this overlap, we calculate the overlap expected under the null by generating a null feature set \(y'\) (potentially many times). The null features in \(y'\) may be characterized by:

1. Drawing from a larger pool \(z\) (\(y' \subset z\)), such that \(y\) and \(y'\) have a similar distribution over one or more covariates. This is the “matching” case. Note that the features in \(y'\) are original features, just drawn from a different pool than y. The *matchRanges* method is described in Davis et al. (2023) [doi: 10.1101/2022.08.05.502985](https://doi.org/10.1101/2022.08.05.502985).
2. Generating a new set of genomic features \(y'\), constructing them from the original set \(y\) by selecting blocks of the genome with replacement, i.e. such that features can be sampled more than once. This is the “bootstrapping” case. Note that, in this case, \(y'\) is an artificial feature set, although the re-sampled features can retain covariates such as score from the original feature set \(y\). The *bootRanges* method is described in Mu et al. (2023) [doi: 10.1101/2022.09.02.506382](https://doi.org/10.1101/2022.09.02.506382).

## In other words

1. Matching – drawing from a pool of features but controlling for certain characteristics, or *covariates*
2. Bootstrapping – placing a number of artificial features in the genome but controlling for the local dependence among features (e.g. features clustering in the genome and/or having correlated metadata)

## Options and features

We provide a number of vignettes to describe the different matching and bootstrapping use cases. In the matching case, we have implemented a number of options, including nearest neighbor matching or rejection sampling based matching. In the bootstrapping case, we have implemented options for bootstrapping across or within chromosomes, and bootstrapping only within states of a segmented genome. We also provide a function to segment the genome by density of features. For example, supposing that \(x\) is a subset of genes, we may want to generate \(y'\) from \(y\) such that features are re-sampled in blocks from segments across the genome with similar gene density. In both cases, we provide a number of functions for performing quality control via visual inspection of diagnostic plots.

## Consideration of excluded regions

Finally, we recommend to incorporate list of regions where artificial features should *not* be placed, including the ENCODE Exclusion List (Amemiya, Kundaje, and Boyle 2019). This and other excluded ranges are made available in the [excluderanges](https://dozmorovlab.github.io/excluderanges/) Bioconductor package by Mikhail Dozmorov *et al.* (Ogata et al. 2023). Use of excluded ranges is demonstrated in the segmented block bootstrap vignette.

# References

Amemiya, Haley M, Anshul Kundaje, and Alan P Boyle. 2019. “The ENCODE Blacklist: Identification of Problematic Regions of the Genome.” *Scientific Reports* 9 (1): 9354. <https://doi.org/10.1038/s41598-019-45839-z>.

Bickel, Peter J., Nathan Boley, James B. Brown, Haiyan Huang, and Nancy R. Zhang. 2010. “Subsampling Methods for Genomic Inference.” *The Annals of Applied Statistics* 4 (4): 1660–97. [https://doi.org/10.1214/10-{AOAS363}](https://doi.org/10.1214/10-%7BAOAS363%7D).

Davis, Eric S., Wancen Mu, Stuart Lee, Mikhail G. Dozmorov, Michael I. Love, and Douglas H. Phanstiel. 2023. “MatchRanges: Generating Null Hypothesis Genomic Ranges via Covariate-Matched Sampling.” *Bioinformatics*. <https://doi.org/10.1093/bioinformatics/btad197>.

De, Subhajyoti, Brent S Pedersen, and Katerina Kechris. 2014. “The Dilemma of Choosing the Ideal Permutation Strategy While Estimating Statistical Significance of Genome-Wide Enrichment.” *Briefings in Bioinformatics* 15 (6): 919–28. <https://doi.org/10.1093/bib/bbt053>.

Dozmorov, Mikhail G. 2017. “Epigenomic annotation-based interpretation of genomic data: from enrichment analysis to machine learning.” *Bioinformatics* 33 (20): 3323–30. <https://doi.org/10.1093/bioinformatics/btx414>.

Favorov, Alexander, Loris Mularoni, Leslie M Cope, Yulia Medvedeva, Andrey A Mironov, Vsevolod J Makeev, and Sarah J Wheelan. 2012. “Exploring Massive, Genome Scale Datasets with the GenometriCorr Package.” *PLoS Computational Biology* 8 (5): e1002529. <https://doi.org/10.1371/journal.pcbi.1002529>.

Ferkingstad, Egil, Lars Holden, and Geir Kjetil Sandve. 2015. “Monte Carlo Null Models for Genomic Data.” *Statistical Science* 30 (1): 59–71. <https://doi.org/10.1214/14-STS484>.

Ferré, Q, G Charbonnier, N Sadouni, F Lopez, Y Kermezli, S Spicuglia, C Capponi, B Ghattas, and D Puthier. 2019. “OLOGRAM: determining significance of total overlap length between genomic regions sets.” *Bioinformatics* 36 (6): 1920–2. <https://doi.org/10.1093/bioinformatics/btz810>.

Gel, Bernat, Anna Díez-Villanueva, Eduard Serra, Marcus Buschbeck, Miguel A Peinado, and Roberto Malinverni. 2016. “regioneR: An R/Bioconductor Package for the Association Analysis of Genomic Regions Based on Permutation Tests.” *Bioinformatics* 32 (2): 289–91. <https://doi.org/10.1093/bioinformatics/btv562>.

Haiminen, Niina, Heikki Mannila, and Evimaria Terzi. 2007. “Comparing Segmentations by Applying Randomization Techniques.” *BMC Bioinformatics* 8 (May): 171. <https://doi.org/10.1186/1471-2105-8-171>.

Heger, Andreas, Caleb Webber, Martin Goodson, Chris P Ponting, and Gerton Lunter. 2013. “GAT: A Simulation Framework for Testing the Association of Genomic Intervals.” *Bioinformatics* 29 (16): 2046–8. <https://doi.org/10.1093/bioinformatics/btt343>.

Huen, David S, and Steven Russell. 2010. “On the Use of Resampling Tests for Evaluating Statistical Significance of Binding-Site Co-Occurrence.” *BMC Bioinformatics* 11 (June): 359. <https://doi.org/10.1186/1471-2105-11-359>.

Kanduri, Chakravarthi, Christoph Bock, Sveinung Gundersen, Eivind Hovig, and Geir Kjetil Sandve. 2019. “Colocalization Analyses of Genomic Elements: Approaches, Recommendations and Challenges.” *Bioinformatics* 35 (9): 1615–24. <https://doi.org/10.1093/bioinformatics/bty835>.

Lawrence, Wolfgang AND Pagès, Michael AND Huber. 2013. “Software for Computing and Annotating Genomic Ranges.” *PLOS Computational Biology* 9 (8): 1–10. <https://doi.org/10.1371/journal.pcbi.1003118>.

Lee, S, M Lawrence, and MI Love. 2020. “Fluent Genomics with Plyranges and Tximeta [Version 1; Peer Review: 1 Approved, 2 Approved with Reservations].” *F1000Research* 9 (109). <https://doi.org/10.12688/f1000research.22259.1>.

Lee, Stuart, Dianne Cook, and Michael Lawrence. 2019. “Plyranges: A Grammar of Genomic Data Transformation.” *Genome Biology* 20 (1): 4. <https://doi.org/10.1186/s13059-018-1597-8>.

McLean, Cory Y., Dave Bristor, Michael Hiller, Shoa L. Clarke, Bruce T. Schaar, Craig B. Lowe, Aaron M. Wenger, and Gill Bejerano. 2010. “GREAT Improves Functional Interpretation of Cis-Regulatory Regions.” *Nature Biotechnology* 28 (5): 495–501. <https://doi.org/10.1038/nbt.1630>.

Mu, Wancen, Eric S. Davis, Stuart Lee, Mikhail G. Dozmorov, Douglas H. Phanstiel, and Michael I. Love. 2023. “BootRanges: Flexible Generation of Null Sets of Genomic Ranges for Hypothesis Testing.” *Bioinformatics*. <https://doi.org/10.1093/bioinformatics/btad190>.

Ogata, Jonathan D., Wancen Mu, Eric S. Davis, Bingjie Xue, J. Chuck Harrell, Nathan C. Sheffield, Douglas H. Phanstiel, Michael I. Love, and Mikhail G. Dozmorov. 2023. “Excluderanges: Exclusion Sets for T2t-Chm13, Grcm39, and Other Genome Assemblies.” *Bioinformatics*. <https://doi.org/10.1093/bioinformatics/btad198>.

Sheffield, Nathan C, and Christoph Bock. 2016. “LOLA: Enrichment Analysis for Genomic Region Sets and Regulatory Elements in R and Bioconductor.” *Bioinformatics* 32 (4): 587–89. <https://doi.org/10.1093/bioinformatics/btv612>.

Welch, Ryan P., Chee Lee, Paul M. Imbriano, Snehal Patil, Terry E. Weymouth, R. Alex Smith, Laura J. Scott, and Maureen A. Sartor. 2014. “ChIP-Enrich: gene set enrichment testing for ChIP-seq data.” *Nucleic Acids Research* 42 (13): e105–e105. <https://doi.org/10.1093/nar/gku463>.