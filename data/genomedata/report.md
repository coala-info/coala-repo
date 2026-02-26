# genomedata CWL Generation Report

## genomedata_genomedata-load-seq

### Tool Description
Start a Genomedata archive at GENOMEDATAFILE with the provided sequences.
SEQFILEs should be in fasta format, and a separate Chromosome will be created
for each definition line.

### Metadata
- **Docker Image**: quay.io/biocontainers/genomedata:1.7.4--py311h87bb1fd_0
- **Homepage**: http://genomedata.hoffmanlab.org
- **Package**: https://anaconda.org/channels/bioconda/packages/genomedata/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/genomedata/overview
- **Total Downloads**: 61.1K
- **Last updated**: 2025-09-02
- **GitHub**: https://github.com/hoffmangroup/genomedata
- **Stars**: N/A
### Original Help Text
```text
usage: genomedata-load-seq [-h] [-r ASSEMBLY-REPORT] [-n NAME_STYLE]
                           [--version] [-a] [-s] [-f] [-d] [--verbose]
                           gdarchive seqfiles [seqfiles ...]

Start a Genomedata archive at GENOMEDATAFILE with the provided sequences.
SEQFILEs should be in fasta format, and a separate Chromosome will be created
for each definition line.

positional arguments:
  gdarchive             genomedata archive
  seqfiles              sequences in FASTA format

options:
  -h, --help            show this help message and exit
  --version             show program's version number and exit
  -a, --assembly        SEQFILE contains assembly (AGP) files instead of
                        sequence
  -s, --sizes           SEQFILE contains list of sizes instead of sequence
  -f, --file-mode       If specified, the Genomedata archive will be
                        implemented as a single file, with a separate h5 group
                        for each Chromosome. This is recommended if there are
                        a large number of Chromosomes. The default behavior is
                        to use a single file if there are at least 100
                        Chromosomes being added.
  -d, --directory-mode  If specified, the Genomedata archive will be
                        implemented as a directory, with a separate file for
                        each Chromosome. This is recommended if there are a
                        small number of Chromosomes. The default behavior is
                        to use a directory if there are fewer than 100
                        Chromosomes being added.
  --verbose             Print status updates and diagnostic messages

Chromosome naming:
  -r ASSEMBLY-REPORT, --assembly-report ASSEMBLY-REPORT
                        Tab-delimited file with columnar mappings between
                        chromosome naming styles.
  -n NAME_STYLE, --name-style NAME_STYLE
                        Chromsome naming style to use based on ASSEMBLY-
                        REPORT. Default: UCSC-style-name
```


## genomedata_genomedata-load

### Tool Description
Create Genomedata archive named GENOMEDATAFILE by loading specified track data and sequences. If GENOMEDATAFILE already exists, it will be overwritten.

### Metadata
- **Docker Image**: quay.io/biocontainers/genomedata:1.7.4--py311h87bb1fd_0
- **Homepage**: http://genomedata.hoffmanlab.org
- **Package**: https://anaconda.org/channels/bioconda/packages/genomedata/overview
- **Validation**: PASS

### Original Help Text
```text
usage: genomedata-load [-h] [-r ASSEMBLY-REPORT] [-n NAME_STYLE] [--version]
                       [--verbose] -s SEQUENCE -t NAME=FILE [-m MASKFILE]
                       [--assembly | --sizes] [-f | -d]
                       GENOMEDATAFILE

Create Genomedata archive named GENOMEDATAFILE by loading
 specified track data and sequences. If GENOMEDATAFILE
 already exists, it will be overwritten.
 --track and --sequence may be repeated to specify
 multiple trackname=trackfile pairings and sequence files,
 respectively.

 Example: genomedata-load -t high=signal.high.wig -t low=signal.low.bed.gz -s chrX.fa -s chrY.fa.gz GENOMEDATAFILE

positional arguments:
  GENOMEDATAFILE        genomedata archive

options:
  -h, --help            show this help message and exit
  --version             show program's version number and exit

Chromosome naming:
  -r ASSEMBLY-REPORT, --assembly-report ASSEMBLY-REPORT
                        Tab-delimited file with columnar mappings between
                        chromosome naming styles.
  -n NAME_STYLE, --name-style NAME_STYLE
                        Chromsome naming style to use based on ASSEMBLY-
                        REPORT. Default: UCSC-style-name

Flags:
  --verbose             Print status updates and diagnostic messages

Input data:
  -s SEQUENCE, --sequence SEQUENCE
                        Add the sequence data in the specified file or files
                        (may use UNIX glob wildcard syntax)
  -t NAME=FILE, --track NAME=FILE
                        Add data from FILE as the track NAME, such as: -t
                        signal=signal.wig
  -m MASKFILE, --maskfile MASKFILE
                        A BED file containing regions to mask out from tracks
                        before loading
  --assembly            sequence files contain assembly (AGP) files instead of
                        sequence
  --sizes               sequence files contain list of sizes instead of
                        sequence

Implementation:
  -f, --file-mode       If specified, the Genomedata archive will be
                        implemented as a single file, with a separate h5 group
                        for each Chromosome. This is recommended if there are
                        a large number of Chromosomes. The default behavior is
                        to use a single file if there are at least 100
                        Chromosomes being added.
  -d, --directory-mode  If specified, the Genomedata archive will be
                        implemented as a directory, with a separate file for
                        each Chromosome. This is recommended if there are a
                        small number of Chromosomes. The default behavior is
                        to use a directory if there are fewer than 100
                        Chromosomes being added.

Citation: Hoffman MM, Buske OJ, Noble WS.
2010. The Genomedata format for storing large-scale functional genomics data.
Bioinformatics 26 (11):1458-1459.
http://dx.doi.org/10.1093/bioinformatics/btq164
```


## genomedata_genomedata-query

### Tool Description
print data from genomedata archive in specified trackname and coordinates

### Metadata
- **Docker Image**: quay.io/biocontainers/genomedata:1.7.4--py311h87bb1fd_0
- **Homepage**: http://genomedata.hoffmanlab.org
- **Package**: https://anaconda.org/channels/bioconda/packages/genomedata/overview
- **Validation**: PASS

### Original Help Text
```text
usage: genomedata-query [-h] [--version] gdarchive trackname chrom begin end

print data from genomedata archive in specified trackname and coordinates

positional arguments:
  gdarchive   genomedata archive
  trackname   track name
  chrom       chromosome name
  begin       chromosome start
  end         chromosome end

options:
  -h, --help  show this help message and exit
  --version   show program's version number and exit
```


## genomedata_genomedata-info

### Tool Description
Print information about a genomedata archive.

### Metadata
- **Docker Image**: quay.io/biocontainers/genomedata:1.7.4--py311h87bb1fd_0
- **Homepage**: http://genomedata.hoffmanlab.org
- **Package**: https://anaconda.org/channels/bioconda/packages/genomedata/overview
- **Validation**: PASS

### Original Help Text
```text
usage: genomedata-info [-h] [--version]
                       {tracknames,tracknames_continuous,contigs,sizes}
                       gdarchive

Print information about a genomedata archive.

positional arguments:
  {tracknames,tracknames_continuous,contigs,sizes}
                        available commands
  gdarchive             genomedata archive

options:
  -h, --help            show this help message and exit
  --version             show program's version number and exit
```


## genomedata_genomedata-histogram

### Tool Description
Print a histogram of values from a genomedata archive

### Metadata
- **Docker Image**: quay.io/biocontainers/genomedata:1.7.4--py311h87bb1fd_0
- **Homepage**: http://genomedata.hoffmanlab.org
- **Package**: https://anaconda.org/channels/bioconda/packages/genomedata/overview
- **Validation**: PASS

### Original Help Text
```text
usage: genomedata-histogram [-h] [--version] [--include-coords FILE] [-b BINS]
                            gdarchive trackname

Print a histogram of values from a genomedata archive

positional arguments:
  gdarchive             genomedata archive
  trackname             track name

options:
  -h, --help            show this help message and exit
  --version             show program's version number and exit
  --include-coords FILE
                        limit summary to genomic coordinates in FILE
  -b BINS, --num-bins BINS
                        use BINS bins
```


## genomedata_genomedata-close-data

### Tool Description
Compute summary statistics for data in Genomedata archive and ready for accessing.

### Metadata
- **Docker Image**: quay.io/biocontainers/genomedata:1.7.4--py311h87bb1fd_0
- **Homepage**: http://genomedata.hoffmanlab.org
- **Package**: https://anaconda.org/channels/bioconda/packages/genomedata/overview
- **Validation**: PASS

### Original Help Text
```text
usage: genomedata-close-data [-h] [--version] [--verbose] gdarchive

Compute summary statistics for data in Genomedata archive and ready for
accessing.

positional arguments:
  gdarchive   genomedata archive

options:
  -h, --help  show this help message and exit
  --version   show program's version number and exit
  --verbose   Print status updates and diagnostic messages
```

