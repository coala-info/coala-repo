# kast CWL Generation Report

## kast

### Tool Description
Perform Alignment-free k-tuple frequency comparisons from sequences. This can be in the form of two input files (e.g. a reference and a query) or a single file for pairwise comparisons to be made.

### Metadata
- **Docker Image**: biocontainers/kast:1.0.1_cv1
- **Homepage**: https://github.com/DelphiWorlds/Kastri
- **Package**: Not found
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/kast/overview
- **Total Downloads**: N/A
- **Last updated**: N/A
- **GitHub**: https://github.com/DelphiWorlds/Kastri
- **Stars**: N/A
### Original Help Text
```text
You have not specifed any input file. See kast -h for details.
kast - Kmer Alignment-free Search Tool.
=======================================

SYNOPSIS
    kast -q query.fasta -r reference.fasta -o results.txt [OPTIONS]
    kast -p mydata.fasta -o results.txt [OPTIONS]

DESCRIPTION
    Perform Alignment-free k-tuple frequency comparisons from sequences. This
    can be in the form of two input files (e.g. a reference and a query) or a
    single file for pairwise comparisons to be made.

OPTIONS
    -h, --help
          Display the help message.
    -k, --klen INTEGER
          Kmer Length. Default: 3.
    -d, --debug
          Debug Messages.
    -q, --query-file INPUT_FILE
          Path to the file containing your query sequence data.
    -r, --reference-file INPUT_FILE
          Path to the file containing your reference sequence data.
    -p, --pairwise-file INPUT_FILE
          Path to the file containing your sequence data which you will
          perform pairwise comparison on.
    -i, --interleaved-file INPUT_FILE
          Path to the file containing your sequence data which is interleaved.
    -m, --markov-order INTEGER
          Markov Order Default: 0.
    -o, --output-file OUTPUT_FILE
          Output file.
    -n, --num-hits INTEGER
          Number of top hits to return when running a Ref/Query search. If you
          want all the result, enter 0. Default: 10.
    -t, --distance-type STRING
          The method of calculating the distance between two sequences. For
          descriptions of distance please refer to the wiki. One of d2,
          euclid, d2s, d2star, manhattan, chebyshev, dai, bc, ngd, all,
          canberra, normalised_canberra, and cosine. Default: d2.
    -sc, --score-cutoff DOUBLE
          Score Cutoff for search mode.
    -s, --sequence-type STRING
          Define the type of sequence data to work with. One of dna, aa, and
          raa. Default: dna.
    -f, --output-format STRING
          For Reference/query based usage you can select your output type. One
          of default, tabular, and blastlike. Default: default.
    -nr, --no-reverse
          Do not use reverse compliment.
    -gc, --calc-gc
          Calculate GC content of query/ref in search mode.
    -nh, --no-header
          Do not print header when performing search mode.
    -mask, --skip-mer List of STRING's
          Specify binary masks where a zero indicates skipping that base and
          one keeps it. e.g. 01110.
    -c, --num-cores INTEGER
          Number of Cores. Default: 1.
    -fp, --filter-percent DOUBLE
          In search mode, only match those results where the query and ref
          sequence lengths are within +/- percentage of oneanother.
    -fb, --filter-bp INT64
          In search mode, only match those results where the query and ref
          sequence lengths are within +/- bp of oneanother.
    --version
          Display version information.

VERSION
    Last update: June 2022
    kast version: 1.0.1
    SeqAn version: 2.4.0
```


## Metadata
- **Skill**: generated
