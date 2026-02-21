# The *SNPhoodData* package

Christian Arnold

#### 4 November 2025

#### Abstract

This is a companion package for *SNPhood* and provides additional example datasets for the *SNPhood* package. The datasets in the *SNPhoodData* package are used in the *SNPhood* vignette and provide “real-world” examples for exploring the molecular neighbourhood of SNPs using allele- and genotype-specific analyses.

#### Package

SNPhoodData 1.40.0

# Contents

* [1 Description of the dataset and the aim of the analysis](#description-of-the-dataset-and-the-aim-of-the-analysis)
* [2 Example Workflow](#example-workflow)
* [3 References](#references)
* **Appendix**

# 1 Description of the dataset and the aim of the analysis

In a recent study we have identified thousands of quantitative trait loci (QTLs) for different histone marks using individuals from the Yoruban (YRI) population [2]. In our case, histone (h)QTLs are SNPs for which the genotype correlate with the variation of histone H3K27ac signal within a H3K27ac peak. Here we will investigate how many of these previously identified hQTLs show allele-specific binding in individuals from a different population (CEU; European).

The example dataset consists of the following files:

* 14,000 previously identified H3K27ac QTLs for individuals from the YRI population [1,2]
* H3K27ac ChIP-Seq data for two individuals (GM10847, GM12890) obtained from Kasowski et al [2] from the CEU population (two replicates each). The reads have previously been mapped to the personalized phased genomes of these individuals [2]
* Corresponding genotypes for the SNPs were obtained from the *1000 Genomes Project* [3]

# 2 Example Workflow

For an example workflow, see the workflow vignette of the *SNPhood* package.

# 3 References

# Appendix

[1] Grubert, F., Zaugg, J. B., Kasowski, M., Ursu, O., Spacek, D. V., Martin, A. R., … & Snyder, M. (2015). Genetic Control of Chromatin States in Humans Involves Local and Distal Chromosomal Interactions. Cell, 162(5), 1051-1065.

[2] Kasowski, M., Kyriazopoulou-Panagiotopoulou, S., Grubert, F., Zaugg, J. B., Kundaje, A., Liu, Y., … & Snyder, M. (2013). Extensive variation in chromatin states across humans. Science, 342(6159), 750-752.

[3] 1000 Genomes Project Consortium. (2010). A map of human genome variation from population-scale sequencing. Nature, 467(7319), 1061-1073.