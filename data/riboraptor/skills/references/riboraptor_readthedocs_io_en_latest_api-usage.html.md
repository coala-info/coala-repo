### Navigation

* [index](genindex.html "General Index")
* [modules](py-modindex.html "Python Module Index") |
* [next](scores.html "Scores") |
* [previous](cmd-manual.html "Manual") |
* [riboraptor 0.2.2 documentation](index.html) »

## Contents

* [Installation](installation.html)
* [Example Workflow](example_workflow.html)
* [Manual](cmd-manual.html)
* API Usage
  + [Counting Fragment Lengths](#counting-fragment-lengths)
  + [Gene Coverage](#gene-coverage)
    - [Creating bedgraph](#creating-bedgraph)
    - [Creating bigwig](#creating-bigwig)
    - [Gene coverage plot](#gene-coverage-plot)
    - [Periodicity Index](#periodicity-index)
    - [5’UTR/CDS/3’UTR coverage](#utr-cds-3-utr-coverage)
* [Scores](scores.html)
* [riboraptor](modules.html)
* [History](history.html)
* [Contributing](contributing.html)
* [Credits](authors.html)

#### Previous topic

[Manual](cmd-manual.html "previous chapter")

#### Next topic

[Scores](scores.html "next chapter")

### This Page

* [Show Source](_sources/api-usage.rst.txt)

1. [Docs](index.html)
2. API Usage

# API Usage[¶](#api-usage "Permalink to this headline")

```
from riboraptor import read_length_distribution
from riboraptor import fragment_enrichment
from riboraptor.plotting import  plot_read_counts
from riboraptor.plotting import plot_fragment_dist
```

## Counting Fragment Lengths[¶](#counting-fragment-lengths "Permalink to this headline")

```
ribo_bam_f = '../data/U251_ribo.bam'
fragment_lengths = read_length_distribution(ribo_bam_f)
ax, fig = plot_fragment_dist(fragment_lengths)
```

[![fragment length distribution](_images/fragment_length_distribution_ideal.png)](_images/fragment_length_distribution_ideal.png)

Fragment length distribution of an Ideal Ribo-seq library

The abosve is a good example of an ideal Ribo-seq library where the fragment
lengths are concentrated between 28 and 31 nucelotides.

We can also “quantify” this enrichment:

```
ribo_enrichment = fragment_enrichment(ribo_bam_f)
```

```
print(ribo_enrichment)
>>> (75.19322097821424, 0.045749574004642399)
```

Let’s compare this with a RNA-Seq sample from the same sample.

```
rna_bam_f = '../data/U251_rna.bam'
fragment_lengths = read_length_distribution(rna_bam_f)
ax, fig = plot_fragment_dist(fragment_lengths)
```

[![fragment length distribution](_images/fragment_length_distribution_rna.png)](_images/fragment_length_distribution_rna.png)

Fragment length distribution of a paired-end RNA-seq library

```
rna_enrichment = fragment_enrichment(rnabam_f)
print(rna_enrichment)
>>> (2.334333862251336e-05, 1.0)
```

## Gene Coverage[¶](#gene-coverage "Permalink to this headline")

In order to visualize genewise coverage, we need to create a bigwig file first. This inturn
requires a bedgraph file.

### Creating bedgraph[¶](#creating-bedgraph "Permalink to this headline")

```
from riboraptor import create_bedgraph
create_bedgraph(ribo_bam_f, strand='both', end_type='5prime', outfile='../data/U251_ribo.bg')
```

### Creating bigwig[¶](#creating-bigwig "Permalink to this headline")

```
from riboraptor import bedgraph_to_bigwig
bedgraph_f = '../data/U251_ribo.bg'
chrom_sizes = '../data/hg38.sizes'
bedgraph_to_bigwig(bedgraph_f, chrom_sizes, '../data/U251_ribo.bw')
```

### Gene coverage plot[¶](#gene-coverage-plot "Permalink to this headline")

```
from riboraptor import gene_coverage
cds_bed = '../data/hg38.cds.bed'
bw = '../data/U251_ribo.bw'
coverage, _, _, _ = gene_coverage('ENSG00000080824', cds_bed, bw, 60)
```

The last argument 60 here specifies the number of upstream bases to count.
We visualize only the first 100 bases:

```
ax, fig, peak = plot_read_counts(coverage[range(-60,100)],
                                 majorticks=10,
                                 minorticks=5,
                                 marker='o',
                                 millify_labels=False)
```

[![Gene coverage](_images/gene_coverage_ENSG00000080824.png)](_images/gene_coverage_ENSG00000080824.png)

Gene coverage across ENSG00000080824

### Periodicity Index[¶](#periodicity-index "Permalink to this headline")

TODO

### 5’UTR/CDS/3’UTR coverage[¶](#utr-cds-3-utr-coverage "Permalink to this headline")

TODO

[Manual](cmd-manual.html "previous chapter (use the left arrow)")

[Scores](scores.html "next chapter (use the right arrow)")

### Navigation

* [index](genindex.html "General Index")
* [modules](py-modindex.html "Python Module Index") |
* [next](scores.html "Scores") |
* [previous](cmd-manual.html "Manual") |
* [riboraptor 0.2.2 documentation](index.html) »

© Copyright 2017, Saket Choudhary. Created using [Sphinx](http://sphinx.pocoo.org/).