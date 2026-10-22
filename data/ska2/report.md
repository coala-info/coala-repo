# ska2 CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| ska2_align | PASS |  |
| ska2_build | PASS |  |
| ska2_cov | PASS |  |
| ska2_delete | PASS |  |
| ska2_distance | PASS |  |
| ska2_lo | PASS |  |
| ska2_map | PASS |  |
| ska2_merge | PASS |  |
| ska2_nk | PASS |  |
| ska2_weed | PASS |  |

## ska2_lo

### Tool Description
Finds 'left out' SNPs and INDELs using a graph

### Metadata
- **Docker Image**: quay.io/biocontainers/ska2:0.5.1--h4349ce8_0
- **Homepage**: https://github.com/bacpop/ska.rust
- **Package**: https://anaconda.org/channels/bioconda/packages/ska2/overview
- **Validation**: PASS

### Original Help Text
```text
Finds 'left out' SNPs and INDELs using a graph

Usage: ska lo [OPTIONS] <INPUT_SKF> <OUTPUT>

Arguments:
  <INPUT_SKF>  input SKA2 file
  <OUTPUT>     prefix of output files

Options:
  -v, --verbose  Show progress messages
  -h, --help     Print help
  -V, --version  Print version

input:
  -r, --reference <REFERENCE>  reference genome for SNP positioning

output:
  -m, --missing <MISSING>  maximum fraction of missing data [default: 0.1]

graph traversal:
  -d, --depth <DEPTH>  maximum depth of recursive paths [default: 4]

other:
  -n, --indel-kmers <INDEL_KMERS>  maximum number of internal indel k-mers [default: 2]
      --threads <THREADS>          Number of CPU threads [default: 1]
```

## ska2_nk

### Tool Description
Get the number of k-mers in a split k-mer file, and other information

### Metadata
- **Docker Image**: quay.io/biocontainers/ska2:0.5.1--h4349ce8_0
- **Homepage**: https://github.com/bacpop/ska.rust
- **Package**: https://anaconda.org/channels/bioconda/packages/ska2/overview
- **Validation**: PASS

### Original Help Text
```text
Get the number of k-mers in a split k-mer file, and other information

Usage: ska nk [OPTIONS] <SKF_FILE>

Arguments:
  <SKF_FILE>  Split-kmer (.skf) file to operate on

Options:
      --full-info  Also write out split-kmers, and middle base matrix
  -v, --verbose    Show progress messages
  -h, --help       Print help
  -V, --version    Print version
```

## ska2_cov

### Tool Description
Estimate a coverage cutoff using a k-mer count profile (FASTQ only)

### Metadata
- **Docker Image**: quay.io/biocontainers/ska2:0.5.1--h4349ce8_0
- **Homepage**: https://github.com/bacpop/ska.rust
- **Package**: https://anaconda.org/channels/bioconda/packages/ska2/overview
- **Validation**: PASS

### Original Help Text
```text
Estimate a coverage cutoff using a k-mer count profile (FASTQ only)

Usage: ska cov [OPTIONS] <FASTQ_FWD> <FASTQ_REV>

Arguments:
  <FASTQ_FWD>  FASTQ file (or .fastq.gz) with forward reads
  <FASTQ_REV>  FASTQ file (or .fastq.gz) with reverse reads

Options:
  -k <K>               K-mer size [default: 31]
      --single-strand  Ignore reverse complement (all reads are oriented along same strand)
  -v, --verbose        Show progress messages
  -h, --help           Print help
  -V, --version        Print version
```

## ska2_delete

### Tool Description
Remove samples from a split k-mer file

### Metadata
- **Docker Image**: quay.io/biocontainers/ska2:0.5.1--h4349ce8_0
- **Homepage**: https://github.com/bacpop/ska.rust
- **Package**: https://anaconda.org/channels/bioconda/packages/ska2/overview
- **Validation**: PASS

### Original Help Text
```text
Remove samples from a split k-mer file

Usage: ska delete [OPTIONS] --skf-file <SKF_FILE> <NAMES|-f <FILE_LIST>>

Arguments:
  [NAMES]...  List of sample names to remove

Options:
  -s, --skf-file <SKF_FILE>  Split-kmer (.skf) file to operate on
  -o <OUTPUT>                Output name. If not provided, will overwrite the input file
  -f <FILE_LIST>             File listing sample names to remove
  -v, --verbose              Show progress messages
  -h, --help                 Print help
  -V, --version              Print version
```

## ska2_map

### Tool Description
Write an ordered alignment using a reference sequence

### Metadata
- **Docker Image**: quay.io/biocontainers/ska2:0.5.1--h4349ce8_0
- **Homepage**: https://github.com/bacpop/ska.rust
- **Package**: https://anaconda.org/channels/bioconda/packages/ska2/overview
- **Validation**: PASS

### Original Help Text
```text
Write an ordered alignment using a reference sequence

Usage: ska map [OPTIONS] <REFERENCE> [INPUT]...

Arguments:
  <REFERENCE>
          Reference FASTA file to map to

  [INPUT]...
          A .skf file, or list of .fasta files

Options:
  -o <OUTPUT>
          Output filename (omit to output to stdout)

  -f, --format <FORMAT>
          Format of output file

          Possible values:
          - vcf: Variant call format
          - aln: FASTA alignment
          
          [default: aln]

      --ambig-mask
          Mask any ambiguous bases in the alignment with 'N'

      --repeat-mask
          Mask any repeats in the alignment with 'N'

      --threads <THREADS>
          Number of CPU threads
          
          [default: 1]

  -v, --verbose
          Show progress messages

  -h, --help
          Print help (see a summary with '-h')

  -V, --version
          Print version
```

## ska2_distance

### Tool Description
Calculate SNP distances and k-mer mismatches

### Metadata
- **Docker Image**: quay.io/biocontainers/ska2:0.5.1--h4349ce8_0
- **Homepage**: https://github.com/bacpop/ska.rust
- **Package**: https://anaconda.org/channels/bioconda/packages/ska2/overview
- **Validation**: PASS

### Original Help Text
```text
Calculate SNP distances and k-mer mismatches

Usage: ska distance [OPTIONS] <SKF_FILE>

Arguments:
  <SKF_FILE>  Split-kmer (.skf) file to operate on

Options:
  -o <OUTPUT>                Output filename (omit to output to stdout)
  -m, --min-freq <MIN_FREQ>  Minimum fraction of samples a k-mer has to appear in across the entire alignment [default: 0]
      --allow-ambiguous      Don't filter out ambiguous bases and compute fractional distances
      --threads <THREADS>    Number of CPU threads [default: 1]
  -v, --verbose              Show progress messages
  -h, --help                 Print help
  -V, --version              Print version
```

## ska2_build

### Tool Description
Create a split-kmer file from input sequences

### Metadata
- **Docker Image**: quay.io/biocontainers/ska2:0.5.1--h4349ce8_0
- **Homepage**: https://github.com/bacpop/ska.rust
- **Package**: https://anaconda.org/channels/bioconda/packages/ska2/overview
- **Validation**: PASS

### Original Help Text
```text
Create a split-kmer file from input sequences

Usage: ska build [OPTIONS] -o <OUTPUT> <SEQ_FILES|-f <FILE_LIST>>

Arguments:
  [SEQ_FILES]...
          List of input FASTA files

Options:
  -f <FILE_LIST>
          File listing input files (tab separated name, sequences)

  -o <OUTPUT>
          Output prefix

  -k <K>
          K-mer size
          
          [default: 31]

      --proportion-reads <PROPORTION_READS>
          Number of reads before stopping

      --single-strand
          Ignore reverse complement (all contigs are oriented along same strand)

      --min-count <MIN_COUNT>
          Minimum k-mer count (with reads)

      --min-qual <MIN_QUAL>
          Minimum k-mer quality (with reads)
          
          [default: 20]

      --qual-filter <QUAL_FILTER>
          Quality filtering criteria (with reads)

          Possible values:
          - no-filter: Ignore quality scores in reads
          - middle:    Filter middle bases below quality threshold
          - strict:    Filter entire k-mer when any base below quality threshold
          
          [default: strict]

      --threads <THREADS>
          Number of CPU threads
          
          [default: 1]

  -v, --verbose
          Show progress messages

  -h, --help
          Print help (see a summary with '-h')

  -V, --version
          Print version
```

## ska2_align

### Tool Description
Write an unordered alignment

### Metadata
- **Docker Image**: quay.io/biocontainers/ska2:0.5.1--h4349ce8_0
- **Homepage**: https://github.com/bacpop/ska.rust
- **Package**: https://anaconda.org/channels/bioconda/packages/ska2/overview
- **Validation**: PASS

### Original Help Text
```text
Write an unordered alignment

Usage: ska align [OPTIONS] <INPUT>...

Arguments:
  <INPUT>...
          A .skf file, or list of .fasta files

Options:
  -o <OUTPUT>
          Output filename (omit to output to stdout)

  -m, --min-freq <MIN_FREQ>
          Minimum fraction of samples a k-mer has to appear in
          
          [default: 0.9]

      --filter-ambig-as-missing
          With min_freq, only count non-ambiguous sites

      --filter <FILTER>
          Filter for constant middle base sites

          Possible values:
          - no-filter:         Output all variants
          - no-const:          Filter constant bases
          - no-ambig:          Filter any site with an ambiguous base
          - no-ambig-or-const: Filter constant bases, and any ambiguous bases
          
          [default: no-const]

      --ambig-mask
          Mask any ambiguous bases in the alignment with 'N'

      --no-gap-only-sites
          Ignore gaps '-' in constant sites (for low coverage samples)

      --threads <THREADS>
          Number of CPU threads
          
          [default: 1]

  -v, --verbose
          Show progress messages

  -h, --help
          Print help (see a summary with '-h')

  -V, --version
          Print version
```

## ska2_weed

### Tool Description
Remove k-mers from a split k-mer file

### Metadata
- **Docker Image**: quay.io/biocontainers/ska2:0.5.1--h4349ce8_0
- **Homepage**: https://github.com/bacpop/ska.rust
- **Package**: https://anaconda.org/channels/bioconda/packages/ska2/overview
- **Validation**: PASS

### Original Help Text
```text
Remove k-mers from a split k-mer file

Usage: ska weed [OPTIONS] <SKF_FILE> [WEED_FILE]

Arguments:
  <SKF_FILE>
          Split-kmer (.skf) file to operate on

  [WEED_FILE]
          A FASTA file containing sequences to remove

Options:
  -o <OUTPUT>
          Output filename (omit to overwrite input file)

      --reverse
          Remove k-mers not in the weed_file

  -m, --min-freq <MIN_FREQ>
          Minimum fraction of samples a k-mer has to appear in
          
          [default: 0.9]

      --filter-ambig-as-missing
          With min_freq, only count non-ambiguous sites

      --filter <FILTER>
          Filter for constant middle base sites

          Possible values:
          - no-filter:         Output all variants
          - no-const:          Filter constant bases
          - no-ambig:          Filter any site with an ambiguous base
          - no-ambig-or-const: Filter constant bases, and any ambiguous bases
          
          [default: no-filter]

      --ambig-mask
          Mask any ambiguous bases in the alignment with 'N'

      --no-gap-only-sites
          Ignore gaps '-' in constant sites

  -v, --verbose
          Show progress messages

  -h, --help
          Print help (see a summary with '-h')

  -V, --version
          Print version
```

## ska2_merge

### Tool Description
Combine multiple split k-mer files

### Metadata
- **Docker Image**: quay.io/biocontainers/ska2:0.5.1--h4349ce8_0
- **Homepage**: https://github.com/bacpop/ska.rust
- **Package**: https://anaconda.org/channels/bioconda/packages/ska2/overview
- **Validation**: PASS

### Original Help Text
```text
Combine multiple split k-mer files

Usage: ska merge [OPTIONS] -o <OUTPUT> [SKF_FILES]...

Arguments:
  [SKF_FILES]...  List of input split-kmer (.skf) files

Options:
  -o <OUTPUT>    Output prefix
  -v, --verbose  Show progress messages
  -h, --help     Print help
  -V, --version  Print version
```

