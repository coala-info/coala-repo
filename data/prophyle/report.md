# prophyle CWL Generation Report

## prophyle_download

### Tool Description
Download genomic libraries and associated data.

### Metadata
- **Docker Image**: quay.io/biocontainers/prophyle:0.3.3.2--py39h746d604_3
- **Homepage**: https://github.com/karel-brinda/prophyle
- **Package**: https://anaconda.org/channels/bioconda/packages/prophyle/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/prophyle/overview
- **Total Downloads**: 542.6K
- **Last updated**: 2025-08-04
- **GitHub**: https://github.com/karel-brinda/prophyle
- **Stars**: N/A
### Original Help Text
```text
usage: prophyle download [-h] [-d DIR] [-l STR] [-F] [-c [STR ...]]
                         <library> [<library> ...]

positional arguments:
  <library>     genomic library ['bacteria', 'viruses', 'plasmids', 'hmp',
                'all']

optional arguments:
  -h, --help    show this help message and exit
  -d DIR        directory for the tree and the sequences [~/prophyle]
  -l STR        log file
  -F            rewrite library files if they already exist
  -c [STR ...]  advanced configuration (a JSON dictionary)
```


## prophyle_index

### Tool Description
Index phylogenetic trees for efficient querying.

### Metadata
- **Docker Image**: quay.io/biocontainers/prophyle:0.3.3.2--py39h746d604_3
- **Homepage**: https://github.com/karel-brinda/prophyle
- **Package**: https://anaconda.org/channels/bioconda/packages/prophyle/overview
- **Validation**: PASS

### Original Help Text
```text
usage: prophyle index [-h] [-g DIR] [-j INT] [-k INT] [-l STR] [-s FLOAT] [-F]
                      [-M] [-P] [-S] [-K] [-T] [-A] [-R] [-c [STR ...]]
                      <tree.nw> [<tree.nw> ...] <index.dir>

positional arguments:
  <tree.nw>     phylogenetic tree (in Newick/NHX)
  <index.dir>   index directory (will be created)

optional arguments:
  -h, --help    show this help message and exit
  -g DIR        directory with the library sequences [dir. of the first tree]
  -j INT        number of threads [auto (20)]
  -k INT        k-mer length [31]
  -l STR        log file [<index.dir>/log.txt]
  -s FLOAT      rate of sampling of the tree [no sampling]
  -F            rewrite index files if they already exist
  -M            mask repeats/low complexity regions (using DustMasker)
  -P            do not add prefixes to node names when multiple trees are used
  -S            stop after k-mer propagation (no BWT index construction)
  -K            skip k-LCP construction (then restarted search only)
  -T            keep temporary files from k-mer propagation
  -A            autocomplete tree (names of internal nodes and FASTA paths)
  -R            switch propagation off (only re-assemble leaves)
  -c [STR ...]  advanced configuration (a JSON dictionary)
```


## prophyle_classify

### Tool Description
Classify reads based on a prophyle index.

### Metadata
- **Docker Image**: quay.io/biocontainers/prophyle:0.3.3.2--py39h746d604_3
- **Homepage**: https://github.com/karel-brinda/prophyle
- **Package**: https://anaconda.org/channels/bioconda/packages/prophyle/overview
- **Validation**: PASS

### Original Help Text
```text
usage: prophyle classify [-h] [-k INT] [-m {h1,c1,h2,c2}] [-f {kraken,sam}]
                         [-l STR] [-P] [-A] [-L] [-X] [-M] [-C] [-K]
                         [-c [STR ...]]
                         <index.dir> <reads1.fq> [<reads2.fq>]

positional arguments:
  <index.dir>       index directory
  <reads1.fq>       first file with reads in FASTA/FASTQ (- for standard
                    input)
  <reads2.fq>       second file with reads in FASTA/FASTQ

optional arguments:
  -h, --help        show this help message and exit
  -k INT            k-mer length [detect automatically from the index]
  -m {h1,c1,h2,c2}  measure: h1=hit count, c1=coverage, h2=norm.hit count,
                    c2=norm.coverage [h1]
  -f {kraken,sam}   output format [sam]
  -l STR            log file
  -P                incorporate sequences and qualities into SAM records
  -A                annotate assignments (using tax. information from NHX)
  -L                replace read assignments by their LCA
  -X                replace k-mer matches by their LCA
  -M                mimic Kraken (equivalent to "-m h1 -f kraken -L -X")
  -C                use C++ impl. of the assignment algorithm (experimental)
  -K                force restarted search mode
  -c [STR ...]      advanced configuration (a JSON dictionary)
```


## prophyle_analyze

### Tool Description
Analyze classified reads based on an index directory or phylogenetic tree.

### Metadata
- **Docker Image**: quay.io/biocontainers/prophyle:0.3.3.2--py39h746d604_3
- **Homepage**: https://github.com/karel-brinda/prophyle
- **Package**: https://anaconda.org/channels/bioconda/packages/prophyle/overview
- **Validation**: PASS

### Original Help Text
```text
usage: prophyle analyze [-h] [-s ['w', 'u', 'wl', 'ul']]
                        [-f ['sam', 'bam', 'cram', 'uncompressed_bam', 'kraken', 'histo']]
                        [-c [STR ...]]
                        {index_dir, tree.nw} <out.pref> <classified.bam>
                        [<classified.bam> ...]

positional arguments:
  {index_dir, tree.nw}     index directory or phylogenetic tree
  <out.pref>               output prefix
  <classified.bam>         classified reads (use '-' for stdin)

optional arguments:
  -h, --help               show this help message and exit
  -s ['w', 'u', 'wl', 'ul']
                           statistics to use for the computation of
                           histograms: w (default) => weighted assignments; u
                           => unique assignments, non-weighted; wl => weighted
                           assignments, propagated to leaves; ul => unique
                           assignments, propagated to leaves.
  -f ['sam', 'bam', 'cram', 'uncompressed_bam', 'kraken', 'histo']
                           Input format of assignments [auto]
  -c [STR ...]             advanced configuration (a JSON dictionary)
```


## prophyle_footprint

### Tool Description
Calculate footprint of prophages in a genome.

### Metadata
- **Docker Image**: quay.io/biocontainers/prophyle:0.3.3.2--py39h746d604_3
- **Homepage**: https://github.com/karel-brinda/prophyle
- **Package**: https://anaconda.org/channels/bioconda/packages/prophyle/overview
- **Validation**: PASS

### Original Help Text
```text
usage: prophyle footprint [-h] [-c [STR ...]] <index.dir>

positional arguments:
  <index.dir>   index directory

optional arguments:
  -h, --help    show this help message and exit
  -c [STR ...]  advanced configuration (a JSON dictionary)
```


## prophyle_compress

### Tool Description
Compresses a prophyle index directory into a tar.gz archive.

### Metadata
- **Docker Image**: quay.io/biocontainers/prophyle:0.3.3.2--py39h746d604_3
- **Homepage**: https://github.com/karel-brinda/prophyle
- **Package**: https://anaconda.org/channels/bioconda/packages/prophyle/overview
- **Validation**: PASS

### Original Help Text
```text
usage: prophyle compress [-h] [-c [STR ...]] <index.dir> [<archive.tar.gz>]

positional arguments:
  <index.dir>       index directory
  <archive.tar.gz>  output archive [<index.dir>.tar.gz]

optional arguments:
  -h, --help        show this help message and exit
  -c [STR ...]      advanced configuration (a JSON dictionary)
```


## prophyle_decompress

### Tool Description
Decompress a prophyle archive

### Metadata
- **Docker Image**: quay.io/biocontainers/prophyle:0.3.3.2--py39h746d604_3
- **Homepage**: https://github.com/karel-brinda/prophyle
- **Package**: https://anaconda.org/channels/bioconda/packages/prophyle/overview
- **Validation**: PASS

### Original Help Text
```text
usage: prophyle decompress [-h] [-K] [-c [STR ...]]
                           <archive.tar.gz> [<output.dir>]

positional arguments:
  <archive.tar.gz>  output archive
  <output.dir>      output directory [./]

optional arguments:
  -h, --help        show this help message and exit
  -K                skip k-LCP construction
  -c [STR ...]      advanced configuration (a JSON dictionary)
```


## prophyle_compile

### Tool Description
Compile prophyle database

### Metadata
- **Docker Image**: quay.io/biocontainers/prophyle:0.3.3.2--py39h746d604_3
- **Homepage**: https://github.com/karel-brinda/prophyle
- **Package**: https://anaconda.org/channels/bioconda/packages/prophyle/overview
- **Validation**: PASS

### Original Help Text
```text
usage: prophyle compile [-h] [-C] [-F] [-P] [-c [STR ...]]

optional arguments:
  -h, --help    show this help message and exit
  -C            clean files instead of compiling
  -F            force recompilation
  -P            run compilation in parallel
  -c [STR ...]  advanced configuration (a JSON dictionary)
```


## Metadata
- **Skill**: generated

## prophyle_prophyle build-index

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/prophyle:0.3.3.2--py39h746d604_3
- **Homepage**: https://github.com/karel-brinda/prophyle
- **Package**: https://anaconda.org/channels/bioconda/packages/prophyle/overview
- **Validation**: FAIL (generation failed)
### Generation Failed

No inputs — do not generate CWL.

### Validation Errors
- No inputs — do not generate CWL.

### Original Help Text
```text
usage: prophyle [-h] [-v]  ...

Program: prophyle (phylogeny-based metagenomic classification)
Version: 0.3.3.2
Authors: Karel Brinda, Kamil Salikhov, Simone Pignotti, Gregory Kucherov
Contact: kbrinda@hsph.harvard.edu

Usage:   prophyle <command> [options]

optional arguments:
  -h, --help     show this help message and exit
  -v, --version  show program's version number and exit

subcommands:
  
    download     download a genomic database
    index        build index
    classify     classify reads
    analyze      analyze results (experimental)
    footprint    estimate memory footprint
    compress     compress a ProPhyle index
    decompress   decompress a compressed ProPhyle index
    compile      compile auxiliary ProPhyle programs
```

## prophyle_prophyle classify

### Tool Description
Classify reads using a prophyle index.

### Metadata
- **Docker Image**: quay.io/biocontainers/prophyle:0.3.3.2--py39h746d604_3
- **Homepage**: https://github.com/karel-brinda/prophyle
- **Package**: https://anaconda.org/channels/bioconda/packages/prophyle/overview
- **Validation**: PASS
### Original Help Text
```text
usage: prophyle classify [-h] [-k INT] [-m {h1,c1,h2,c2}] [-f {kraken,sam}]
                         [-l STR] [-P] [-A] [-L] [-X] [-M] [-C] [-K]
                         [-c [STR ...]]
                         <index.dir> <reads1.fq> [<reads2.fq>]

positional arguments:
  <index.dir>       index directory
  <reads1.fq>       first file with reads in FASTA/FASTQ (- for standard
                    input)
  <reads2.fq>       second file with reads in FASTA/FASTQ

optional arguments:
  -h, --help        show this help message and exit
  -k INT            k-mer length [detect automatically from the index]
  -m {h1,c1,h2,c2}  measure: h1=hit count, c1=coverage, h2=norm.hit count,
                    c2=norm.coverage [h1]
  -f {kraken,sam}   output format [sam]
  -l STR            log file
  -P                incorporate sequences and qualities into SAM records
  -A                annotate assignments (using tax. information from NHX)
  -L                replace read assignments by their LCA
  -X                replace k-mer matches by their LCA
  -M                mimic Kraken (equivalent to "-m h1 -f kraken -L -X")
  -C                use C++ impl. of the assignment algorithm (experimental)
  -K                force restarted search mode
  -c [STR ...]      advanced configuration (a JSON dictionary)
```

