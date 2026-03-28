[hicstuff](../index.html)

latest

* [Installation](../quickstart.html)
* [Quickstart](../quickstart.html#id1)
* hicstuff command line interface demo
  + [Getting started](#Getting-started)
    - [Using an indexed genome](#Using-an-indexed-genome)
    - [Setting the binning](#Setting-the-binning)
    - [Temporary files](#Temporary-files)
    - [Additional options](#Additional-options)
  + [Advanced usage](#Advanced-usage)
    - [Starting from intermediate files](#Starting-from-intermediate-files)
  + [Generating the distance law](#Generating-the-distance-law)
  + [Operations on Hi-C matrices](#Operations-on-Hi-C-matrices)
    - [Visualizing the matrix](#Visualizing-the-matrix)
    - [Converting between formats](#Converting-between-formats)
    - [Rebinning existing matrices](#Rebinning-existing-matrices)
    - [Subsampling contacts](#Subsampling-contacts)
* [hicstuff API demo](demo_api.html)

* [hicstuff package](../api/hicstuff.html)

[hicstuff](../index.html)

* [Docs](../index.html) »
* hicstuff command line interface demo
* [Edit on GitHub](https://github.com/koszullab/hicstuff/blob/master/doc/notebooks/demo_cli.ipynb)

---

# hicstuff command line interface demo[¶](#hicstuff-command-line-interface-demo "Permalink to this headline")

## Getting started[¶](#Getting-started "Permalink to this headline")

The easiest way to generate matrices is to use `hicstuff pipeline`. By default the command only requires two fastq files (forward and reverse reads) and a genome in fasta format.

The pipeline command can be used to generate the Hi-C contact map from the input reads.

```
hicstuff pipeline --genome genome.fa \
                  --outdir results \
                  forward.fq \
                  reverse.fq
```

For instance, this will create a directory named “results”, containing three output text files with tab-separated columns.

* `abs_fragments_contacts_weighter.txt`: Sparse matrix file with 3 columns the rows, column and values of nonzero pixels. The first row contains the shape and total number of nonzero pixels in the matrix.
* `fragments_list.txt`: Contains genomic coordinates of the matrix bins (row/columns).
* `info_contigs.txt`: Contains chromosome names, theirs length and number of bins.

### Using an indexed genome[¶](#Using-an-indexed-genome "Permalink to this headline")

When given a genome in fasta format, hicstuff regenerates the index everytime unless it finds an index starting by the genome filename. For example using bowtie2, you can index the genome like this:

```
bowtie2-build genome.fa genome.fa
```

And when running hicstuff with `--genome=genome.fa`, it will automatically find the index files and not regenerate it.

### Setting the binning[¶](#Setting-the-binning "Permalink to this headline")

By default, matrices generated are binned at 5kb. You can change this using the `--enzyme` option. This option allows to specify either a bin size, or an enzyme. For example if you set `--enzyme='DpnII'`, the matrix will be at restriction fragments resolution.

### Temporary files[¶](#Temporary-files "Permalink to this headline")

By default temporary files are removed when the pipeline finishes. They can be kept by adding the `--no-cleanup` flag. For example, if you run:

```
hicstuff pipeline -g genome.fa --no-cleanup --prefix demo
```

The `--prefix` option used here gives a common prefix to all output files, overriding the default output file names as follows:

* `abs_fragments_contacts_weighted.txt` -> `demo.mat.tsv`
* `fragments_list.txt` -> `demo.frags.tsv`
* `info_contigs.txt` -> `demo.chr.tsv`

And the output folder should now contain a `tmp/` subfolder and look like this:

```
output
├── demo.chr.tsv
├── demo.frags.tsv
├── demo.hicstuff_20190423185220.log
├── demo.mat.tsv
├── demo.distance_law.txt
├── plots
│   ├── event_distance.pdf
│   ├── event_distribution.pdf
│   └── frags_hist.pdf
└── tmp
    ├── demo.for.bam
    ├── demo.genome.fasta
    ├── demo.rev.bam
    ├── demo.valid_idx_filtered.pairs
    ├── demo.valid_idx.pairs
    └── demo.valid.pairs
```

### Additional options[¶](#Additional-options "Permalink to this headline")

The `hicstuff pipeline` command has additional options allowing to tweak various parameters and change the output files or their format. You can always consult `hicstuff pipeline --help` to get a comprehensive description of those options, but here are a few of them:

* `--filter`: Filters out spurious 3C events, such as self religations or undigested fragments. This is only really useful at very fine resolutions (1-2kb) and not needed most of the time. This option is only meaningful when `--enzyme` is given a restriction enzyme and not a bin size.
* `--duplicates`: Removes PCR duplicates, defined as sets of pairs having identical mapping positions for both reads.
* `--matfmt`: allows to specify what file format should be used for the matrix. Available formats are bg2 (bedgraph2d), graal (the text format described above) and cool, [a binary format](https://cooler.readthedocs.io) that is probably the most appropriate for large genomes.
* `--distance-law`: Computes the distance-law table (i.e. the probability of contacts as a function of genomic distance).
* `--plot`: Enables plotting. When used in conjunction with `--filter` or `--distance-law`, this will generate figures showing properties of your Hi-C data.

## Advanced usage[¶](#Advanced-usage "Permalink to this headline")

### Starting from intermediate files[¶](#Starting-from-intermediate-files "Permalink to this headline")

If your hicstuff run was interrupted, or you wish to align the reads separately, the `--start-stage` option allows the `hicstuff pipeline` command to take intermediate files as input. For example to skip the alignment step and start from aligned reads:

```
hicstuff pipeline --start-stage bam --genome genome.fa forward.bam reverse.bam
```

Or if you already have a pairs file:

```
hicstuff pipeline --start-stage pairs --genome genome.fa valid.pairs
```

## Generating the distance law[¶](#Generating-the-distance-law "Permalink to this headline")

The distance law is the probability of contact of two fragments in function of the distance between these fragments. There are two ways to compute it with hicstuff. The first one using the full pipeline with the option `--distance-law`, as done above. It’s possible to add an option `--centromeres` if you want to compute the distance law on separate arms. The output of this command will be a raw table of the distance without any treatment of the data. It will be then possible with the command
distancelaw to process this table.

The second way is to use the command distancelaw with the pairs file as input:

```
hicstuff distancelaw --average \
                     --big-arm-only \
                     --centromeres centromeres.txt \
                     --frags output/demo.frags.tsv \
                     --inf 3000 \
                     --outputfile-img output/demo_distance_law.svg \
                     --labels labels.txt \
                     --sup 500000 \
                     --pairs output/tmp/demo.valid_idx_filtered.pairs
```

For instance, this will create an image with the distance law generated from the pairs file given in input. The distance law will be the average between all the distance laws of the arms bigger than 500kb. The logspace used to plot it will have a base 1.1 by default. The limits of the x axis will be 3kb and 500kb.

Note that if `hicstuff pipeline` was given the `--distance-law` option, the output folder should contain a file named `distance_law.txt` containing the precomputed interaction frequencies. This file can be provided to the `hicstuff distancelaw` command using `--dist-tbl distance_law.txt` instead of the pairs file.

## Operations on Hi-C matrices[¶](#Operations-on-Hi-C-matrices "Permalink to this headline")

All commands described below can take the output of hicstuff as input. They will accept either a bg2 matrix, a cool matrix or a graal matrix. Note that when using a graal matrix, you will usually need to specify the fragments file using `--frags` since genomic coordinates are not encoded in this matrix format.

### Visualizing the matrix[¶](#Visualizing-the-matrix "Permalink to this headline")

Below are example commands that can be used to visualise Hi-C matrices with hicstuff.

```
# Viewing a normalized (=balanced) matrix in graal format at 5kb resolution
hicstuff view --binning 5kb --normalize --frags output/demo.frags.tsv output/demo.mat.tsv
# Viewing a log ratio of 2 matrices in cool format
hicstuff view sample1.cool sample2.cool
# Viewing a raw matrix in bedgraph2 format at 500bp resolution with log transformed contacts
hicstuff view --binning 500bp --transform log high_res.bg2
```

This will show an interactive heatmap using matplotlib. In order to save the matrix to a file instead, one could add `--output output/demo.png`

Note there are others options allowing to process the matrix which are documented in the help message.

### Converting between formats[¶](#Converting-between-formats "Permalink to this headline")

Output files from `hicstuff pipeline` can be converted between different format using the command `hicstuff convert`. For example to generate the file `cool_output/demo.cool` from files in the default hicstuff format:

```
hicstuff convert --frags output/demo.frags.tsv \
                 --chroms output/demo.chr.tsv \
                 --to cool \
                 output/demo.mat.tsv
                 output/demo
```

Notice that the command takes 2 positional arguments, the first one is the matrix file and the second is the prefix to give for output files, to which the extension will be added depending on the output format chosen. Input format is inferred automatically from the input matrix.

### Rebinning existing matrices[¶](#Rebinning-existing-matrices "Permalink to this headline")

Files previously produced by hicstuff pipeline can be rebinned at a lower resolutions using the `hicstuff rebin` command. This will generate a new matrix, a new fragments\_list.txt and a new info\_contigs.txt, all with updated number of bins:

```
hicstuff rebin -f output/demo.frags.tsv \
               -c output/demo.chr.tsv \
               --binning 1kb \
               output/demo.mat.tsv \
               rebin_1kb
```

When working with cool or bedgraph2 files, the command is simpler as we don’t need fragments and contig files:

```
# Rebins demo.cool at 10kb and saves the results to rebinned.cool
hicstuff rebin --binning 10kb demo.cool rebinned
```

### Subsampling contacts[¶](#Subsampling-contacts "Permalink to this headline")

For many applications, differences in sequencing coverage will impact results. To avoid this, one can subsample contacts from Hi-C matrices to ensure the different samples to be compared have comparable signal. This functionality is implemented in the `hicstuff subsample` command, which allows to keep a fixed number of contacts from a matrix, or to extract a fraction of contacts:

```
# Keep 30% contacts in matrix.cool and save the results to subsamples_30.cool
hicstuff subsample --prop 0.5 matrix.cool subsample_30
# Keep 1 million contacts in matrix.bg2 and save the result in subsample_1M.bg2
hicstuff subsample --prop 1000000 matrix.bg2 subsample_1M
```

[Next](demo_api.html "hicstuff API demo")
 [Previous](../quickstart.html "Installation")

---

© Copyright 2018, Cyril Matthey-Doret
Revision `b44fbed8`.

Built with [Sphinx](http://sphinx-doc.org/) using a [theme](https://github.com/rtfd/sphinx_rtd_theme) provided by [Read the Docs](https://readthedocs.org).