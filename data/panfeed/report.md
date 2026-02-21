# panfeed CWL Generation Report

## panfeed

### Tool Description
Get gene cluster specific k-mers from a set of bacterial genomes

### Metadata
- **Docker Image**: quay.io/biocontainers/panfeed:1.7.2--pyhdfd78af_0
- **Homepage**: https://github.com/microbial-pangenomes-lab/panfeed
- **Package**: https://anaconda.org/channels/bioconda/packages/panfeed/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/panfeed/overview
- **Total Downloads**: 6.3K
- **Last updated**: 2025-12-16
- **GitHub**: https://github.com/microbial-pangenomes-lab/panfeed
- **Stars**: N/A
### Original Help Text
```text
usage: panfeed [-h] -g GFF -p PRESENCE_ABSENCE [--targets TARGETS]
               [--genes GENES] [-o OUTPUT] [-f FASTA] [-k KMER_LENGTH]
               [--maf MAF] [--upstream UPSTREAM] [--downstream DOWNSTREAM]
               [--downstream-start-codon] [--non-canonical] [--no-filter]
               [--consider-missing] [--multiple-files] [--compress]
               [--cores CORES] [-ql QUEUE_LIMIT] [--stop-on-missing] [-v]
               [--version]

Get gene cluster specific k-mers from a set of bacterial genomes

options:
  -h, --help            show this help message and exit
  -g, --gff GFF         Directory containing all samples' GFF files, or a file
                        listing the relative path to each GFF file, one per
                        line (must contain nucleotide sequence as well unless
                        -f is used, and samples should be named in the same
                        way as in the panaroo header)
  -p, --presence-absence PRESENCE_ABSENCE
                        Gene clusters presence absence table as output by
                        panaroo
  --targets TARGETS     File indicating for which samples k-mer positions
                        should be logged (one sample name per line, default:
                        no samples)
  --genes GENES         File indicating for which gene clusters k-mer
                        positions and patterns should be logged (one gene
                        cluster ID per line, default: all gene clusters)
  -o, --output OUTPUT   Output directory to store outputs (will cause an error
                        if already present)
  -f, --fasta FASTA     Directory containing all samples' nucleotide fasta
                        files, or a file listing the relative path to each
                        fasta file, one per line (extension either .fasta or
                        .fna, samples should be named in the same way as in
                        the panaroo header)
  -k, --kmer-length KMER_LENGTH
                        K-mer length (default: 31)
  --maf MAF             Minor allele frequency threshold; patterns whose
                        frequency is below this value or above 1-MAF are
                        excluded (default: 0.01, does not apply to the
                        kmers.tsv file)
  --upstream UPSTREAM   How many bases to include upstream of the actual gene
                        sequences (e.g. to include the 5' region, default: 0)
  --downstream DOWNSTREAM
                        How many bases to include downstream of the actual
                        gene sequences (e.g. to include the 3' region,
                        default: 0)
  --downstream-start-codon
                        Center the --downstream argument at the start codon
                        (default is stop codon)
  --non-canonical       Compute non-canonical k-mers (default is canonical)
  --no-filter           Do not filter out k-mers with the same presence
                        absence pattern as the gene cluster itself
  --consider-missing    Output NaN for strains that do not encode for a k-mer
                        if the gene is missing (default: value is set to 0, as
                        for the gene. WARNING: slows down execution)
  --multiple-files      Generate one set of outputs for each gene cluster
                        (default: one set of outputs)
  --compress            Compress output files with gzip (default: plain text)
  --cores CORES         Threads (default: 1, at least 3 are needed for
                        parallelization)
  -ql, --queue-limit QUEUE_LIMIT
                        limit on items that may be put into the readingand
                        writing queues. (default: 3)this option is only
                        relevant for cores > 1reading queue limit = ql *
                        coreswriting queue limit = ql
  --stop-on-missing     Crash if samples/chromosomes/genes are not found
                        (default: throw warnings)
  -v                    Increase verbosity level
  --version             show program's version number and exit
```


## Metadata
- **Skill**: generated

## panfeed_panfeed-get-clusters

### Tool Description
Indicate which genes clusters have significantly associated patterns

### Metadata
- **Docker Image**: quay.io/biocontainers/panfeed:1.7.2--pyhdfd78af_0
- **Homepage**: https://github.com/microbial-pangenomes-lab/panfeed
- **Package**: https://anaconda.org/channels/bioconda/packages/panfeed/overview
- **Validation**: PASS
### Original Help Text
```text
usage: panfeed-get-clusters [-h] -a ASSOCIATIONS -p KMERS_TO_HASHES
                            [-t THRESHOLD] [-c COLUMN] [-o OUTPUT] [-v]
                            [--version]

Indicate which genes clusters have significantly associated patterns

options:
  -h, --help            show this help message and exit
  -a, --associations ASSOCIATIONS
                        TSV file containing hashes and their significance
                        (e.g. pyseer output; tab-delimited, should have a
                        header, first column contains the hash, and another
                        column - by default 'lrt-pvalue' - contains the
                        association p-value, which can be used to filter the
                        table)
  -p, --kmers-to-hashes KMERS_TO_HASHES
                        TSV file relating gene clusters, kmers, and their
                        hashes (i.e. panfeed's kmers_to_hases.tsv file)
  -t, --threshold THRESHOLD
                        Association p-value threshold (default 1.00)
  -c, --column COLUMN   P-value column in the associations file (default lrt-
                        pvalue)
  -o, --output OUTPUT   Filename to save filtered associations table (not
                        saved by default)
  -v                    Increase verbosity level
  --version             show program's version number and exit
```

## panfeed_panfeed-get-kmers

### Tool Description
Annotate association results with positional information

### Metadata
- **Docker Image**: quay.io/biocontainers/panfeed:1.7.2--pyhdfd78af_0
- **Homepage**: https://github.com/microbial-pangenomes-lab/panfeed
- **Package**: https://anaconda.org/channels/bioconda/packages/panfeed/overview
- **Validation**: PASS
### Original Help Text
```text
usage: panfeed-get-kmers [-h] -a ASSOCIATIONS -p KMERS_TO_HASHES -k KMERS
                         [-t THRESHOLD] [-c COLUMN] [-o OUTPUT]
                         [--only-passing]
                         [--clusters-per-iteration CLUSTERS_PER_ITERATION]
                         [-v] [--version]

Annotate association results with positional information

options:
  -h, --help            show this help message and exit
  -a, --associations ASSOCIATIONS
                        TSV file containing hashes and their significance
                        (e.g. pyseer output; tab-delimited, should have a
                        header, first column contains the hash, and another
                        column - by default 'lrt-pvalue' - contains the
                        association p-value, which can be used to filter the
                        table)
  -p, --kmers-to-hashes KMERS_TO_HASHES
                        TSV file relating gene clusters, kmers, and their
                        hashes (i.e. panfeed's kmers_to_hases.tsv file)
  -k, --kmers KMERS     TSV file with positional information of individual
                        k-mers (i.e. panfeed's kmers.tsv file)
  -t, --threshold THRESHOLD
                        Association p-value threshold (default 1.00)
  -c, --column COLUMN   P-value column in the associations file (default lrt-
                        pvalue)
  -o, --output OUTPUT   Filename to save filtered associations table (not
                        saved by default)
  --only-passing        Only output passing k-mers (default is all)
  --clusters-per-iteration CLUSTERS_PER_ITERATION
                        Number of clusters to be considered in each iteration,
                        a higher number means faster execution but higher
                        memory usage (default 15)
  -v                    Increase verbosity level
  --version             show program's version number and exit
```

## panfeed_panfeed-plot

### Tool Description
Plot association results from panfeed

### Metadata
- **Docker Image**: quay.io/biocontainers/panfeed:1.7.2--pyhdfd78af_0
- **Homepage**: https://github.com/microbial-pangenomes-lab/panfeed
- **Package**: https://anaconda.org/channels/bioconda/packages/panfeed/overview
- **Validation**: PASS
### Original Help Text
```text
usage: panfeed-plot [-h] -k KMERS [-c COLUMN] [-t THRESHOLD] -p PHENOTYPE
                    [--phenotype-column PHENOTYPE_COLUMN] [--sample SAMPLE]
                    [--start START] [--stop STOP]
                    [--format {png,tiff,pdf,svg}]
                    [--output-directory OUTPUT_DIRECTORY] [--dpi DPI]
                    [--minimum-pvalue MINIMUM_PVALUE] [--nucleotides]
                    [--alpha ALPHA] [--xticks XTICKS] [--height HEIGHT]
                    [--width WIDTH] [-v] [--version]

Plot association results from panfeed

options:
  -h, --help            show this help message and exit
  -k, --kmers KMERS     TSV file containing the output of panfeed-get-kmers
  -c, --column COLUMN   P-value column in the associations file (default lrt-
                        pvalue)
  -t, --threshold THRESHOLD
                        Association p-value threshold (default 1.00)
  -p, --phenotype PHENOTYPE
                        Phenotype file in TSV format, used to list all strains
  --phenotype-column PHENOTYPE_COLUMN
                        Column in phenotype TSV file for sorting (default is
                        sorting by p-values)
  --sample SAMPLE       Only show a randomly picked set of sample (a value
                        between 0 and 1 indicating the proportion to show,
                        default all)
  --start START         Relative position to start the plots (default all
                        available positions)
  --stop STOP           Relative position to end the plots (default all
                        available positions)
  --format {png,tiff,pdf,svg}
                        Output format for plots (default png)
  --output-directory OUTPUT_DIRECTORY
                        Output directory for the plots (default .)
  --dpi DPI             Output resolution (DPI, default 300)
  --minimum-pvalue MINIMUM_PVALUE
                        Minimum p-value for color and transparency (default
                        1.00e-10)
  --nucleotides         Draw nucleotide sequence on all plots (WARNING: only
                        makes sense if few samples and positions are
                        considered)
  --alpha ALPHA         Opacity for non-passing k-mers (between 0 and 1, 0
                        indicates full transparency, default 0.00)
  --xticks XTICKS       Spacing for ticks on x axis (default 200)
  --height HEIGHT       Figure height (inches, default 9.0)
  --width WIDTH         Figure width (inches, default 10.0)
  -v                    Increase verbosity level
  --version             show program's version number and exit
```

