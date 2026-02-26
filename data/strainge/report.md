# strainge CWL Generation Report

## strainge_kmerize

### Tool Description
K-merize a given reference sequence or a sample read dataset.

### Metadata
- **Docker Image**: quay.io/biocontainers/strainge:1.3.9--py38h737be40_0
- **Homepage**: The package home page
- **Package**: https://anaconda.org/channels/bioconda/packages/strainge/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/strainge/overview
- **Total Downloads**: 24.4K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/broadinstitute/strainge
- **Stars**: N/A
### Original Help Text
```text
usage: strainge kmerize [-h] [-k K] -o OUTPUT [-f FINGERPRINT_FRACTION] [-F]
                        [-l LIMIT] [-p PRUNE]
                        sequences [sequences ...]

K-merize a given reference sequence or a sample read dataset.

positional arguments:
  sequences             Input sequence files (fasta or fastq by default;
                        optionally compressed with gz or bz2)

optional arguments:
  -h, --help            show this help message and exit
  -k K, --k K           K-mer size (default 23)
  -o OUTPUT, --output OUTPUT
                        Filename of the output HDF5.
  -f FINGERPRINT_FRACTION, --fingerprint-fraction FINGERPRINT_FRACTION
                        Fraction of k-mers to keep for a minhash sketch.
                        Default: 0.01. No fingerprint will be created if set
                        to zero.
  -F, --filter          Filter output kmers based on kmer spectrum (to prune
                        sequencing errors)
  -l LIMIT, --limit LIMIT
                        Only process about this many kmers (can have suffix of
                        M or G)
  -p PRUNE, --prune PRUNE
                        Prune singletons after accumulating this (can have
                        suffix of M or G)
```


## strainge_kmersim

### Tool Description
Compare k-mer sets with each other. Both all-vs-all and one-vs-all is supported.

### Metadata
- **Docker Image**: quay.io/biocontainers/strainge:1.3.9--py38h737be40_0
- **Homepage**: The package home page
- **Package**: https://anaconda.org/channels/bioconda/packages/strainge/overview
- **Validation**: PASS

### Original Help Text
```text
usage: strainge kmersim [-h] (-a | -s FILE) [-f]
                        [-S {jaccard,minsize,meansize,maxsize,subset,reference}]
                        [-t THREADS] [-o FILE]
                        strains [strains ...]

Compare k-mer sets with each other. Both all-vs-all and one-vs-all is
supported.

positional arguments:
  strains               Filenames of k-mer set HDF5 files.

optional arguments:
  -h, --help            show this help message and exit
  -a, --all-vs-all      Perform all-vs-all comparisons for the given k-mer
                        sets. Either --all-vs-all is required or --sample.
  -s FILE, --sample FILE
                        Perform one-vs-all comparisons with the given filename
                        as sample. Either --all-vs-all is required or
                        --sample.
  -f, --full-db         Use full k-mer set instead of min-hash fingerprint.
  -S {jaccard,minsize,meansize,maxsize,subset,reference}, --scoring {jaccard,minsize,meansize,maxsize,subset,reference}
                        The scoring metric to use (default: jaccard). Can be
                        used multiple times to include multiple scoring
                        metrics. Choices: jaccard, minsize, meansize, maxsize,
                        subset, reference.
  -t THREADS, --threads THREADS
                        Use multiple processes the compute the similarity
                        scores (default 1).
  -o FILE, --output FILE
                        File to write the results (default: standard output).
```


## strainge_and

### Tool Description
A command-line tool for analyzing and manipulating k-mer databases.

### Metadata
- **Docker Image**: quay.io/biocontainers/strainge:1.3.9--py38h737be40_0
- **Homepage**: The package home page
- **Package**: https://anaconda.org/channels/bioconda/packages/strainge/overview
- **Validation**: PASS

### Original Help Text
```text
usage: strainge [-h] [--version] [-v]
                {kmerize,kmersim,cluster,createdb,search,call,view,compare,tree,stats,plot}
                ...
strainge: error: invalid choice: 'and' (choose from 'kmerize', 'kmersim', 'cluster', 'createdb', 'search', 'call', 'view', 'compare', 'tree', 'stats', 'plot')
```


## strainge_cluster

### Tool Description
Group k-mer sets that are very similar to each other together.

### Metadata
- **Docker Image**: quay.io/biocontainers/strainge:1.3.9--py38h737be40_0
- **Homepage**: The package home page
- **Package**: https://anaconda.org/channels/bioconda/packages/strainge/overview
- **Validation**: PASS

### Original Help Text
```text
usage: strainge cluster [-h] [-c CUTOFF] [-i FILE] [-d] [-C CONTAINED_CUTOFF]
                        [-w ANI] [-p FILE] [-o FILE] [--clusters-out FILE]
                        kmerset [kmerset ...]

Group k-mer sets that are very similar to each other together.

positional arguments:
  kmerset               The list of HDF5 filenames of k-mer sets to cluster.

optional arguments:
  -h, --help            show this help message and exit
  -c CUTOFF, --cutoff CUTOFF
                        Minimum similarity between two sets to group them
                        together.
  -i FILE, --similarity-scores FILE
                        The file with the similarity scores between kmersets
                        (the output of 'strainge compare --all-vs-all').
                        Defaults to standard input.
  -d, --discard-contained
                        Discard k-mersets that are a subset of another
                        k-merset. Requires 'subset' scoring metric in the
                        similarity scores TSV files.
  -C CONTAINED_CUTOFF, --contained-cutoff CONTAINED_CUTOFF
                        Minimum fraction of kmers to be present in another
                        genome to discard it.
  -w ANI, --warn-too-distant ANI
                        Warn when including references that that seem too
                        distantly related, which could indicate a mislabeled
                        reference genome. Default: 85% ANI.
  -p FILE, --priorities FILE
                        An optional TSV file where the first column represents
                        the ID of a reference kmerset, and the second an
                        integer indicating the priority for clustering.
                        References with higher priority get precedence over
                        references with lower priority in the same cluster.
  -o FILE, --output FILE
                        The file where the list of kmersets to keep after
                        clustering gets written. Defaults to standard output.
  --clusters-out FILE   Output an optional tab separated file with all
                        clusters and their entries.
```


## strainge_createdb

### Tool Description
Create pan-genome database in HDF5 format from a list of k-merized strains.

### Metadata
- **Docker Image**: quay.io/biocontainers/strainge:1.3.9--py38h737be40_0
- **Homepage**: The package home page
- **Package**: https://anaconda.org/channels/bioconda/packages/strainge/overview
- **Validation**: PASS

### Original Help Text
```text
usage: strainge createdb [-h] [-o OUTPUT] [-f FILE] [kmerset [kmerset ...]]

Create pan-genome database in HDF5 format from a list of k-merized
strains.

positional arguments:
  kmerset               The HDF5 filenames of the kmerized reference strains.

optional arguments:
  -h, --help            show this help message and exit
  -o OUTPUT, --output OUTPUT
                        Pan-genome database output HDF5 file.
  -f FILE, --from-file FILE
                        Read list of HDF5 filenames to include in the database
                        from a given file (use '-' to denote standard input).
                        This is in addition to any k-merset given as
                        positional argument.
```


## strainge_of

### Tool Description
A toolkit for analyzing k-mer profiles of sequencing data.

### Metadata
- **Docker Image**: quay.io/biocontainers/strainge:1.3.9--py38h737be40_0
- **Homepage**: The package home page
- **Package**: https://anaconda.org/channels/bioconda/packages/strainge/overview
- **Validation**: PASS

### Original Help Text
```text
usage: strainge [-h] [--version] [-v]
                {kmerize,kmersim,cluster,createdb,search,call,view,compare,tree,stats,plot}
                ...
strainge: error: invalid choice: 'of' (choose from 'kmerize', 'kmersim', 'cluster', 'createdb', 'search', 'call', 'view', 'compare', 'tree', 'stats', 'plot')
```


## strainge_reference

### Tool Description
A toolkit for analyzing microbial genomes and metagenomes.

### Metadata
- **Docker Image**: quay.io/biocontainers/strainge:1.3.9--py38h737be40_0
- **Homepage**: The package home page
- **Package**: https://anaconda.org/channels/bioconda/packages/strainge/overview
- **Validation**: PASS

### Original Help Text
```text
usage: strainge [-h] [--version] [-v]
                {kmerize,kmersim,cluster,createdb,search,call,view,compare,tree,stats,plot}
                ...
strainge: error: invalid choice: 'reference' (choose from 'kmerize', 'kmersim', 'cluster', 'createdb', 'search', 'call', 'view', 'compare', 'tree', 'stats', 'plot')
```


## strainge_samples

### Tool Description
A toolkit for analyzing and comparing k-mer profiles of sequencing data.

### Metadata
- **Docker Image**: quay.io/biocontainers/strainge:1.3.9--py38h737be40_0
- **Homepage**: The package home page
- **Package**: https://anaconda.org/channels/bioconda/packages/strainge/overview
- **Validation**: PASS

### Original Help Text
```text
usage: strainge [-h] [--version] [-v]
                {kmerize,kmersim,cluster,createdb,search,call,view,compare,tree,stats,plot}
                ...
strainge: error: invalid choice: 'samples' (choose from 'kmerize', 'kmersim', 'cluster', 'createdb', 'search', 'call', 'view', 'compare', 'tree', 'stats', 'plot')
```


## strainge_view

### Tool Description
View call statistics stored in a HDF5 file and output results to different file formats

### Metadata
- **Docker Image**: quay.io/biocontainers/strainge:1.3.9--py38h737be40_0
- **Homepage**: The package home page
- **Package**: https://anaconda.org/channels/bioconda/packages/strainge/overview
- **Validation**: PASS

### Original Help Text
```text
usage: strainge view [-h] [-s FILE] [-t TRACKS] [-p PATH]
                     [--track-min-size TRACK_MIN_SIZE] [-G MIN_GAP] [-V FILE]
                     [--verbose-vcf LEVEL]
                     hdf5

View call statistics stored in a HDF5 file and output results to
different file formats

positional arguments:
  hdf5                  HDF5 file with StrainGR call statistics.

optional arguments:
  -h, --help            show this help message and exit
  -s FILE, --summary FILE
                        Output a TSV with a summary of variant calling
                        statistics to the given file.
  -t TRACKS, --tracks TRACKS
                        Write track files that can be visualized in a genome
                        viewer, use this option multiple times to generate
                        multiple track types. Use 'all' to generate all
                        tracks. Available track types: coverage, callable,
                        multimapped, lowmq, bad, high_coverage, gaps
  -p PATH, --track-prefix PATH
                        Specifiy filename prefix for all track files. By
                        default it will use the path of the HDF5 file without
                        the '.hdf5' extension.
  --track-min-size TRACK_MIN_SIZE
                        For all --track-* options above, only include features
                        (regions) of at least the given size. Default: 1.
  -G MIN_GAP, --min-gap MIN_GAP
                        Minimum size of gap to be considered as such. If not
                        set, will use the value used in the original `straingr
                        call` run. If set, gaps will need to be at least the
                        given size to be reported. Will be scaled depending on
                        coverage.
  -V FILE, --vcf FILE   Output a VCF file with SNP's. Please be aware that we
                        do not have a good insertion/deletion calling
                        mechanism, but some information on possible indels is
                        written to the VCF file.
  --verbose-vcf LEVEL   To be used with --vcf. Increase the verboseness of the
                        generated VCF. By default it only outputs strong SNPs.
                        A value of 1 will also output any weak calls.
```


## strainge_results

### Tool Description
A toolkit for analyzing genomic sequences using k-mer based methods.

### Metadata
- **Docker Image**: quay.io/biocontainers/strainge:1.3.9--py38h737be40_0
- **Homepage**: The package home page
- **Package**: https://anaconda.org/channels/bioconda/packages/strainge/overview
- **Validation**: PASS

### Original Help Text
```text
usage: strainge [-h] [--version] [-v]
                {kmerize,kmersim,cluster,createdb,search,call,view,compare,tree,stats,plot}
                ...
strainge: error: invalid choice: 'results' (choose from 'kmerize', 'kmersim', 'cluster', 'createdb', 'search', 'call', 'view', 'compare', 'tree', 'stats', 'plot')
```


## strainge_compare

### Tool Description
Compare strains and variant calls in two different samples. Reads of both samples must be aligned to the same reference.

It's possible to generate a TSV with summary stats as well as a file with more detailed information on which alleles are called at what positions.

### Metadata
- **Docker Image**: quay.io/biocontainers/strainge:1.3.9--py38h737be40_0
- **Homepage**: The package home page
- **Package**: https://anaconda.org/channels/bioconda/packages/strainge/overview
- **Validation**: PASS

### Original Help Text
```text
usage: strainge compare [-h] [-o SUMMARY_OUT] [-d DETAILS_OUT] [-V] [-G SIZE]
                        [-a | -b BASELINE] [-D OUTPUT_DIR]
                        SAMPLE_HDF5 [SAMPLE_HDF5 ...]

Compare strains and variant calls in two different samples. Reads of
both samples must be aligned to the same reference.

It's possible to generate a TSV with summary stats as well as a file
with more detailed information on which alleles are called at what
positions.

positional arguments:
  SAMPLE_HDF5           HDF5 files with variant calling data for each sample.
                        Number of samples should be exactly two, except when
                        used with --baseline.

optional arguments:
  -h, --help            show this help message and exit
  -o SUMMARY_OUT, --summary-out SUMMARY_OUT
                        Output file for summary statistics. Defaults to
                        stdout.
  -d DETAILS_OUT, --details-out DETAILS_OUT
                        Output file for detailed base level differences
                        between samples (optional).
  -V, --verbose-details
                        Output detailed information for every position in the
                        genome instead of only for positions where alleles
                        differ.
  -G SIZE, --min-gap SIZE
                        Only compare gaps larger than the given size.
  -a, --all-vs-all      Perform all-vs-all pairwise comparisons between the
                        given samples. Can't be used together with --baseline.
  -b BASELINE, --baseline BASELINE
                        Path to a sample to use as baseline, and compare all
                        other given samples to this one. Outputs a shell
                        script that runs all individual pairwise comparisons.
                        Can't be used together with --all-vs-all.
  -D OUTPUT_DIR, --output-dir OUTPUT_DIR
                        The output directory of all comparison files when
                        using --baseline or --all-vs-all.
```


## strainge_same

### Tool Description
A tool for analyzing and comparing k-mer profiles of genomic sequences.

### Metadata
- **Docker Image**: quay.io/biocontainers/strainge:1.3.9--py38h737be40_0
- **Homepage**: The package home page
- **Package**: https://anaconda.org/channels/bioconda/packages/strainge/overview
- **Validation**: PASS

### Original Help Text
```text
usage: strainge [-h] [--version] [-v]
                {kmerize,kmersim,cluster,createdb,search,call,view,compare,tree,stats,plot}
                ...
strainge: error: invalid choice: 'same' (choose from 'kmerize', 'kmersim', 'cluster', 'createdb', 'search', 'call', 'view', 'compare', 'tree', 'stats', 'plot')
```


## strainge_tree

### Tool Description
Build an approximate phylogenetic tree based on a given distance matrix, using neighbour joining.
Because our pairwise distances are pretty rough (especially at lower coverages), the triangle inequality may not hold, and the resulting tree may not be accurate.

### Metadata
- **Docker Image**: quay.io/biocontainers/strainge:1.3.9--py38h737be40_0
- **Homepage**: The package home page
- **Package**: https://anaconda.org/channels/bioconda/packages/strainge/overview
- **Validation**: PASS

### Original Help Text
```text
usage: strainge tree [-h] [-o OUTPUT] distance_matrix

Build an approximate phylogenetic tree based on a given distance matrix,
using neighbour joining.

Because our pairwise distances are pretty rough (especially at lower
coverages), the triangle inequality may not hold, and the resulting tree
may not be accurate.

positional arguments:
  distance_matrix       The path to the distance matrix TSV, as created by
                        `straingr dist`.

optional arguments:
  -h, --help            show this help message and exit
  -o OUTPUT, --output OUTPUT
                        Output filename. Defaults to stdout.
```


## strainge_given

### Tool Description
A command-line tool for analyzing genomic sequences.

### Metadata
- **Docker Image**: quay.io/biocontainers/strainge:1.3.9--py38h737be40_0
- **Homepage**: The package home page
- **Package**: https://anaconda.org/channels/bioconda/packages/strainge/overview
- **Validation**: PASS

### Original Help Text
```text
usage: strainge [-h] [--version] [-v]
                {kmerize,kmersim,cluster,createdb,search,call,view,compare,tree,stats,plot}
                ...
strainge: error: invalid choice: 'given' (choose from 'kmerize', 'kmersim', 'cluster', 'createdb', 'search', 'call', 'view', 'compare', 'tree', 'stats', 'plot')
```


## strainge_stats

### Tool Description
Obtain statistics about a given k-mer set.

### Metadata
- **Docker Image**: quay.io/biocontainers/strainge:1.3.9--py38h737be40_0
- **Homepage**: The package home page
- **Package**: https://anaconda.org/channels/bioconda/packages/strainge/overview
- **Validation**: PASS

### Original Help Text
```text
usage: strainge stats [-h] [-k] [-c] [-H] [-e] [-o OUTPUT] kmerset

Obtain statistics about a given k-mer set.

positional arguments:
  kmerset               The K-mer set to load

optional arguments:
  -h, --help            show this help message and exit
  -k                    Output k-mer size.
  -c, --counts          Output the list of k-mers in this set with
                        corresponding counts.
  -H, --histogram       Write the k-mer frequency histogram to output.
  -e, --entropy         Calculate Shannon entropy in bases and write to
                        output.
  -o OUTPUT, --output OUTPUT
                        Output file, defaults to standard output.
```


## strainge_plot

### Tool Description
Generate plots for a given k-mer set.

### Metadata
- **Docker Image**: quay.io/biocontainers/strainge:1.3.9--py38h737be40_0
- **Homepage**: The package home page
- **Package**: https://anaconda.org/channels/bioconda/packages/strainge/overview
- **Validation**: PASS

### Original Help Text
```text
usage: strainge plot [-h] [-o OUTPUT] [-t {spectrum}] kmerset

Generate plots for a given k-mer set.

positional arguments:
  kmerset               The k-mer set to load

optional arguments:
  -h, --help            show this help message and exit
  -o OUTPUT, --output OUTPUT
                        Output filename (PNG preferred).
  -t {spectrum}, --plot-type {spectrum}
                        The kind of plot to generate.
```

