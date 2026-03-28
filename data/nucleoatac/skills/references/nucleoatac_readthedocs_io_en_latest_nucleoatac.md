[NucleoATAC](..)

* * [Home](..)
  * * * [Installation](../installation/)
      * * * [nucleoatac](./)
            + [Necessary Files](#necessary-files)
            + [run](#run)
            + [occ](#occ)
            + [vprocess](#vprocess)
            + [nuc](#nuc)
            + [merge](#merge)
            + [nfr](#nfr)
          * * * [pyatac](../pyatac/)
              * * * [FAQ](../faq/)

[NucleoATAC](..)

* [Docs](..) »
* nucleoatac

---

The nucleoatac command line function contains several subcommands used for calling nucleosomes. The "run" subcommand is a wrapper for the other three using standard options-- for more flexibility, run "occ" then "vprocess" then "nuc". For each subcommand, options can be viewed as `nucleoatac subcommand --help`.

### Necessary Files

Prior to using nucleoatac to call nucleosomes, you will need at least three types of files:

1) Bam file with aligned reads. These generally will be filtered for reads not mapping to mitochondria & reads with high mapping quality.

2) Fasta file with genome used in alignment. This file must be indexed (using [samtools](http://www.htslib.org/) faidx)

3) Sorted bed file with regions for which nucleosome analysis is to be performed. These regions will generally be broad open-chromatin regions (i.e. regions called by MACS2 with the --broad flag). It is potentially advisable to extend these regions a bit (e.g. using bedtools slop). Regions should not overlap so it is advisable to use bedtools merge on these regions.

### run

For calling nucleosomes with mostly default parameters, use

```
nucleoatac run --bed <bedfile> --bam <bamfile> --fasta <fastafile> --out <output_basename>
```

Outputs:

See outputs for occ, vprocess, and nuc

### occ

```
nucleoatac occ --bed <bedfile> --bam <bamfile> --out <output_basename>
```

Outputs:

* *output\_basename.occ.bedgraph.gz*: Bedgraph track with nucleosome occupancy score
* *output\_basename.occ.lower\_bound.bedgraph.gz*: Bedgraph track with lower bound estimate for nucleosome occupancy score
* *output\_basename.occ.upper\_bound.bedgraph.gz*: Bedgraph track with upper bound estimate nucleosome occupancy score
* *output\_basename.nuc\_dist.txt* and *output\_basename.nuc\_dist.eps*: text file and EPS plot with estimate of fragment size at nucleosomes
* *output\_basename.fragmentsizes.txt*: Text file with fragment size distribution within input peaks
* *output\_basename.occ\_fit.txt* and *output\_basename.occ\_fit.eps*: text file and EPS plot of model for NFR and nucleosomal distributions
* *output\_basename.occpeaks.bed.gz*: Peaks from nucleosome occupancy track -- low resolution nucleosome calls. Columns are (1) chrom (2) dyad position (0-based) (3) dyad position (1-based) (4) occupancy (5) occupancy lower bound (6) occupancy upper bound (7) # of reads in 121 bp window

### vprocess

```
nucleoatac vprocess --sizes <sizes_file> --out <output_basename>
```

The  will generally be the output\_basename.nuc\_dist.txt output from `occ`.

Outputs:

* *output\_basename.VMat*: text file with normalized V-plot for cross-correlation

### nuc

```
nucleotac nuc
```

* *output\_basename.nucpos.bed.gz*: Nucleosome dyad calls text file. Columns are: (1) chrom, (2) dyad position (0-based), (3) dyad position(1-based), (4) z-score, (5) nucleosome occupancy estimate (6) lower bound for nucleosome occupancy estimate, (7) upper bound for nucleosome occupancy estimate (8) log likelihood ratio, (9) normalied nucleoatac signal value, (10) cross-correlation signal value before normalization, (11) number of potentially nucleosome-sized fragments, (12) number of fragments smaller than nucleosome sized, (13) "fuzziness" (measure of how wide signal peak is)
* *output\_basename.nucpos.redundant.bed.gz*: Includes nucleosome position calls that were within the minimum separation for non-redundant calls.
* *output\_basename.nucleoatac\_signal.bedgraph.gz*: Bedgraph track with normalized cross-correlation signal
* *output\_basename.nucleoatac\_signal.smooth.bedgraph.gz*: Smoothed version of output\_basename.nucleoatac\_signal.bedgraph.gz
  Also includes only positive signal
* *output\_basename.occ.bedgraph.gz*: Bedgraph track with nucleosome occupancy score

### merge

```
nucleoatac merge
```

* *output\_basename.nucmap\_combined.bed.gz*: Combines low resolution nucleosome calls from occ function and higher resolution calls from nuc to create more comprehensive map

### nfr

```
nucleoatac nfr
```

* *output\_basename.nfrpos.bed.gz*: NFR positions. Columns are (1) chrom, (2) left boundary (0-based), (3) right boundary (1-based), (4) mean occupancy, (5) minimum upper bound occupancy, (6) insertion density, (7) bias density

[Next](../pyatac/ "pyatac")
 [Previous](../installation/ "Installation")

---

Built with [MkDocs](http://www.mkdocs.org) using a [theme](https://github.com/snide/sphinx_rtd_theme) provided by [Read the Docs](https://readthedocs.org).