# concoct CWL Generation Report

## concoct

### Tool Description
CONCOCT: COnditional co-Nstrained Clustering Of Transcriptomes

### Metadata
- **Docker Image**: quay.io/biocontainers/concoct:1.1.0--py312hb1d17a5_9
- **Homepage**: https://github.com/BinPro/CONCOCT
- **Package**: https://anaconda.org/channels/bioconda/packages/concoct/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/concoct/overview
- **Total Downloads**: 67.4K
- **Last updated**: 2026-02-19
- **GitHub**: https://github.com/BinPro/CONCOCT
- **Stars**: N/A
### Original Help Text
```text
usage: concoct [-h] [--coverage_file COVERAGE_FILE]
               [--composition_file COMPOSITION_FILE] [-c CLUSTERS]
               [-k KMER_LENGTH] [-t THREADS] [-l LENGTH_THRESHOLD]
               [-r READ_LENGTH] [--total_percentage_pca TOTAL_PERCENTAGE_PCA]
               [-b BASENAME] [-s SEED] [-i ITERATIONS]
               [--no_cov_normalization] [--no_total_coverage]
               [--no_original_data] [-o] [-d] [-v]

options:
  -h, --help            show this help message and exit
  --coverage_file COVERAGE_FILE
                        specify the coverage file, containing a table where
                        each row correspond to a contig, and each column
                        correspond to a sample. The values are the average
                        coverage for this contig in that sample. All values
                        are separated with tabs.
  --composition_file COMPOSITION_FILE
                        specify the composition file, containing sequences in
                        fasta format. It is named the composition file since
                        it is used to calculate the kmer composition (the
                        genomic signature) of each contig.
  -c CLUSTERS, --clusters CLUSTERS
                        specify maximal number of clusters for VGMM, default
                        400.
  -k KMER_LENGTH, --kmer_length KMER_LENGTH
                        specify kmer length, default 4.
  -t THREADS, --threads THREADS
                        Number of threads to use
  -l LENGTH_THRESHOLD, --length_threshold LENGTH_THRESHOLD
                        specify the sequence length threshold, contigs shorter
                        than this value will not be included. Defaults to
                        1000.
  -r READ_LENGTH, --read_length READ_LENGTH
                        specify read length for coverage, default 100
  --total_percentage_pca TOTAL_PERCENTAGE_PCA
                        The percentage of variance explained by the principal
                        components for the combined data.
  -b BASENAME, --basename BASENAME
                        Specify the basename for files or directory where
                        outputwill be placed. Path to existing directory or
                        basenamewith a trailing '/' will be interpreted as a
                        directory.If not provided, current directory will be
                        used.
  -s SEED, --seed SEED  Specify an integer to use as seed for clustering. 0
                        gives a random seed, 1 is the default seed and any
                        other positive integer can be used. Other values give
                        ArgumentTypeError.
  -i ITERATIONS, --iterations ITERATIONS
                        Specify maximum number of iterations for the VBGMM.
                        Default value is 500
  --no_cov_normalization
                        By default the coverage is normalized with regards to
                        samples, then normalized with regards of contigs and
                        finally log transformed. By setting this flag you skip
                        the normalization and only do log transorm of the
                        coverage.
  --no_total_coverage   By default, the total coverage is added as a new
                        column in the coverage data matrix, independently of
                        coverage normalization but previous to log
                        transformation. Use this tag to escape this behaviour.
  --no_original_data    By default the original data is saved to disk. For big
                        datasets, especially when a large k is used for
                        compositional data, this file can become very large.
                        Use this tag if you don't want to save the original
                        data.
  -o, --converge_out    Write convergence info to files.
  -d, --debug           Debug parameters.
  -v, --version         show program's version number and exit
```

