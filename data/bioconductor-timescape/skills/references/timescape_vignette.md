# TimeScape vignette

TimeScape is a visualization tool for temporal clonal evolution.

# Installation

To install TimeScape, type the following commands in R:

```
# try http:// if https:// URLs are not supported
if (!requireNamespace("BiocManager", quietly=TRUE))
    install.packages("BiocManager")
BiocManager::install("timescape")
```

# Examples

Run the examples by:

```
example("timescape")
```

The following visualizations will appear in your browser (optimized for Chrome):

The first visualization is of the acute myeloid leukemia patient from Ding et al., 2012. The second visualization is of the metastatic ovarian cancer patient 7 from McPherson and Roth et al., 2016.

# Required parameters

The required parameters for TimeScape are as follows:

\(clonal\\_prev\) is a data frame consisting of clonal prevalences for each clone at each time point. The columns in this data frame are:

1. character() \(timepoint\) - time point
2. character() \(clone\\_id\) - clone id
3. numeric() \(clonal\\_prev\) - clonal prevalence.

\(tree\\_edges\) is a data frame describing the edges of a rooted clonal phylogeny. The columns in this data frame are:

1. character() \(source\) - source node id
2. character() \(target\) - target node id.

# Optional parameters

## Mutations

\(mutations\) is a data frame consisting of the mutations originating in each clone. The columns in this data frame are:

1. character() \(chrom\) - chromosome number
2. numeric() \(coord\) - coordinate of mutation on chromosome
3. character() \(clone\\_id\) - clone id
4. character() \(timepoint\) - time point
5. numeric() \(VAF\) - variant allele frequency of the mutation in the corresponding timepoint.

If this parameter is provided, a mutation table will appear at the bottom of the view.

## Clone colours

Clone colours may be changed using the \(clone\\_colours\) parameter, for instance, compare the default colours :

with specified custom colours:

## Alpha value

The alpha value of each colour may be tweaked in the \(alpha\) parameter (a numeric value between [0, 100]). Compare alpha of 10:

with the alpha value of 90:

## Titles

The x-axis, y-axis and phylogeny titles may be changed using the \(xaxis\\_title\), \(yaxis\\_title\) and \(phylogeny\\_title\) parameters, which take in a character string.

Here are some custom titles:

## Genotype position

The position of each genotype with respect to its ancestor can be altered. The “stack” layout is the default layout. It stacks genotypes one on top of another to clearly display genotype prevalences at each time point. The “space” layout uses the same stacking method while maintaining (where possible) a minimum amount of space between each genotype. The “centre” layout centers genotypes with respect to their ancestors. Here we’ll see an example of each:

### Stacked

### Spaced

### Centered

## Perturbation events

Perturbation events may be added to the TimeScape using the \(perturbations\) parameter. Adding perturbations will simply add a label along the x-axis where the perturbation occurs. The \(perturbations\) parameter is a data frame consisting of the following columns:

1. character() \(pert\\_name\) - the perturbation name
2. character() \(prev\\_tp\) - the time point (as labelled in clonal prevalence data) BEFORE perturbation.

### Without perturbation

### With perturbation

# Obtaining the data

E-scape takes as input a clonal phylogeny and clonal prevalences per clone per sample. At the time of submission many methods have been proposed for obtaining these values, and accurate estimation of these quantities is the focus of ongoing research. We describe a method for estimating clonal phylogenies and clonal prevalence using PyClone (Roth et al., 2014; source code available at <https://bitbucket.org/aroth85/pyclone/wiki/Home>) and citup (Malikic et al., 2016; source code available at <https://github.com/sfu-compbio/citup>). In brief, PyClone inputs are prepared by processing fastq files resulting from a targeted deep sequencing experiment. Using samtools mpileup (<http://samtools.sourceforge.net/mpileup.shtml>), the number of nucleotides matching the reference and non-reference are counted for each targeted SNV. Copy number is also required for each SNV. We recommend inferring copy number from whole genome or whole exome sequencing of samples taken from the same anatomic location / timepoint as the samples to which targeted deep sequencing was applied. Copy number can be inferred using Titan (Ha et al., 2014; source code available at <https://github.com/gavinha/TitanCNA>). Sample specific SNV information is compiled into a set of TSV files, one per sample. The tables includes mutation id, reference and variant read counts, normal copy number, and major and minor tumour copy number (see PyClone readme). PyClone is run on these files using the `PyClone run_analysis_pipeline` subcommand, and produces the `tables/cluster.tsv` in the working directory. Citup can be used to infer a clonal phylogeny and clone prevalences from the cellular prevalences produced by PyClone. The `tables/cluster.tsv` file contains per sample, per SNV cluster estimates of cellular prevalence. The table is reshaped into a TSV file of cellular prevalences with rows as clusters and columns as samples, and the `mean` of each cluster taken from `tables/cluster.tsv` for the values of the table. The iterative version of citup is run on the table of cellular frequencies, producing an hdf5 output results file. Within the hdf5 results, the `/results/optimal` can be used to identify the id of the optimal tree solution. The clonal phylogeny as an adjacency list is then the `/trees/{tree_solution}/adjacency_list` entry and the clone frequencies are the `/trees/{tree_solution}/clone_freq` entry in the hdf5 file. The adjacency list can be written as a TSV with the column names `source`, `target` to be input into E-scape, and the clone frequencies should be reshaped such that each row represents a clonal frequency in a specific sample for a specific clone, with the columns representing the time or space ID, the clone ID, and the clonal prevalence.

# Interactivity

Interactive components:

1. Mouseover any clone to view its (i) clone ID and (ii) clonal prevalence at each time point.
2. Click the view switch button to switch from the traditional timescape view to the clonal trajectory view, where each clone changes prevalence on its own track.
3. Click the download buttons to download a PNG or SVG of the view.
4. If a mutation table is present, click a clone in the phylogeny to filter the mutation table by the selected clone.

# Documentation

To view the documentation for TimeScape, type the following command in R:

```
?timescape
```

or:

```
browseVignettes("timescape")
```

# References

TimeScape was developed at the Shah Lab for Computational Cancer Biology at the BC Cancer Research Centre.

References:

Ding, Li, et al. “Clonal evolution in relapsed acute myeloid leukaemia revealed by whole-genome sequencing.” Nature 481.7382 (2012): 506-510.

Ha, Gavin, et al. “TITAN: inference of copy number architectures in clonal cell populations from tumor whole-genome sequence data.” Genome research 24.11 (2014): 1881-1893.

Malikic, Salem, et al. “Clonality inference in multiple tumor samples using phylogeny.” Bioinformatics 31.9 (2015): 1349-1356.

McPherson, Andrew, et al. “Divergent modes of clonal spread and intraperitoneal mixing in high-grade serous ovarian cancer.” Nature genetics (2016).

Roth, Andrew, et al. “PyClone: statistical inference of clonal population structure in cancer.” Nature methods 11.4 (2014): 396-398.