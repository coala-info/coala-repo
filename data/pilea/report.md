# pilea CWL Generation Report

## pilea_index

### Tool Description
Index fasta files for Pilea.

### Metadata
- **Docker Image**: quay.io/biocontainers/pilea:1.3.7--py312h4711d71_0
- **Homepage**: https://github.com/xinehc/pilea
- **Package**: https://anaconda.org/channels/bioconda/packages/pilea/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/pilea/overview
- **Total Downloads**: 19.1K
- **Last updated**: 2026-01-26
- **GitHub**: https://github.com/xinehc/pilea
- **Stars**: N/A
### Original Help Text
```text
Usage: pilea index -o DIR [--compress] [-d DIR] [-a FILE] [-t INT] [-k INT]
                   [-s INT] [-w INT]
                   file [file ...]

Positional Arguments:
  file                  Input fasta <*.fa|*.fna|*.fasta> file(s), gzip
                        optional <*.gz>, file list optional <.txt>.

Required Arguments:
  -o, --outdir DIR      Output directory. (default: None)

Optional Arguments:
  --compress            Compress the database by creating a tar archive.
                        (default: False)
  -d, --database DIR    Database directory. If given then extend it, otherwise
                        build a new one. (default: None)
  -a, --taxonomy FILE   Path to GTDB-Tk's <gtdbtk.bac120.summary.tsv> or
                        GTDB's <bac120_taxonomy.tsv>. If not given then ignore
                        taxonomy mapping. (default: None)
  -t, --threads INT     Number of threads. (default: 20)

Additional Arguments - Sketching:
  -k, --kmer INT        K-mer size. (default: 31)
  -s, --scale INT       Scale for downsampling. (default: 250)
  -w, --window INT      Window size for k-mer grouping. (default: 25000)
```


## pilea_new

### Tool Description
pilea: error: argument {index,fetch,profile,rebuild}: invalid choice: 'new' (choose from index, fetch, profile, rebuild)

### Metadata
- **Docker Image**: quay.io/biocontainers/pilea:1.3.7--py312h4711d71_0
- **Homepage**: https://github.com/xinehc/pilea
- **Package**: https://anaconda.org/channels/bioconda/packages/pilea/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: pilea [-h] [-v] {index,fetch,profile,rebuild} ...
pilea: error: argument {index,fetch,profile,rebuild}: invalid choice: 'new' (choose from index, fetch, profile, rebuild)
```


## pilea_fetch

### Tool Description
Fetch data from Pilea.

### Metadata
- **Docker Image**: quay.io/biocontainers/pilea:1.3.7--py312h4711d71_0
- **Homepage**: https://github.com/xinehc/pilea
- **Package**: https://anaconda.org/channels/bioconda/packages/pilea/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: pilea fetch -o DIR [-t INT]

Required Arguments:
  -o, --outdir DIR      Output directory. (default: None)

Optional Arguments:
  -t, --threads INT     Number of threads. (default: 20)
```


## pilea_profile

### Tool Description
Profile genomes from fasta or fastq files.

### Metadata
- **Docker Image**: quay.io/biocontainers/pilea:1.3.7--py312h4711d71_0
- **Homepage**: https://github.com/xinehc/pilea
- **Package**: https://anaconda.org/channels/bioconda/packages/pilea/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: pilea profile -o DIR -d DIR [--force] [--single] [-t INT] [-x FLOAT]
                     [-y FLOAT] [-z FLOAT] [-c FLOAT] [-n INT] [-i INT]
                     [-e FLOAT]
                     file [file ...]

Positional Arguments:
  file                  Input fasta <*.fa|*.fasta> or fastq <*.fq|*.fastq>
                        file(s), gzip optional <*.gz>.

Required Arguments:
  -o, --outdir DIR      Output directory. (default: None)
  -d, --database DIR    Database directory. (default: None)

Optional Arguments:
  --force               Force counting. (default: False)
  --single              Files are single-end. If not given then merge
                        forward|reward files with <_(1|2)>, <_(R1|R2)> or
                        <_(fwd|rev)>. (default: False)
  -t, --threads INT     Number of threads. (default: 20)

Additional Arguments - Parsing:
  -x, --min-cove FLOAT  Min. median per-window coverage of k-mers. (default:
                        5)
  -y, --max-disp FLOAT  Max. median per-window dispersion of k-mers' counts.
                        (default: inf)
  -z, --min-frac FLOAT  Min. fraction of reference genomes' windows covered by
                        k-mers. (default: 0.75)
  -c, --min-cont FLOAT  Min. containment of reference genomes' sketches after
                        reassignment of shared k-mers. (default: 0.25)

Additional Arguments - Fitting:
  -n, --components INT  Number of mixture components. (default: 5)
  -i, --max-iter INT    Terminal condition for EM - max. number of iterations.
                        (default: inf)
  -e, --tol FLOAT       Terminal condition for EM - tolerance. (default:
                        1e-05)
```


## pilea_rebuild

### Tool Description
Rebuilds a sketch database.

### Metadata
- **Docker Image**: quay.io/biocontainers/pilea:1.3.7--py312h4711d71_0
- **Homepage**: https://github.com/xinehc/pilea
- **Package**: https://anaconda.org/channels/bioconda/packages/pilea/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: pilea rebuild -o DIR [-t INT] [-k INT] [-s INT] [-w INT]

Required Arguments:
  -o, --outdir DIR      Output directory. (default: None)

Optional Arguments:
  -t, --threads INT     Number of threads. (default: 20)

Additional Arguments - Sketching:
  -k, --kmer INT        K-mer size. (default: 31)
  -s, --scale INT       Scale for downsampling. (default: 250)
  -w, --window INT      Window size for k-mer grouping. (default: 25000)
```


## pilea_bacterial

### Tool Description
pilea: error: argument {index,fetch,profile,rebuild}: invalid choice: 'bacterial' (choose from index, fetch, profile, rebuild)

### Metadata
- **Docker Image**: quay.io/biocontainers/pilea:1.3.7--py312h4711d71_0
- **Homepage**: https://github.com/xinehc/pilea
- **Package**: https://anaconda.org/channels/bioconda/packages/pilea/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: pilea [-h] [-v] {index,fetch,profile,rebuild} ...
pilea: error: argument {index,fetch,profile,rebuild}: invalid choice: 'bacterial' (choose from index, fetch, profile, rebuild)
```


## Metadata
- **Skill**: generated
