# rustybam CWL Generation Report

## rustybam_stats

### Tool Description
Get percent identity stats from a sam/bam/cram or PAF. Requires =/X operations in the CIGAR string!

### Metadata
- **Docker Image**: quay.io/biocontainers/rustybam:0.1.34--hf24ce72_0
- **Homepage**: https://github.com/mrvollger/rustybam
- **Package**: https://anaconda.org/channels/bioconda/packages/rustybam/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/rustybam/overview
- **Total Downloads**: 31.7K
- **Last updated**: 2025-06-03
- **GitHub**: https://github.com/mrvollger/rustybam
- **Stars**: N/A
### Original Help Text
```text
rustybam-stats 0.1.34
Get percent identity stats from a sam/bam/cram or PAF. Requires =/X operations in the CIGAR string!

## output column descriptions: ### perID_by_matches is calculated as: `matches / (matches +
mismatches)` ### perID_by_events is calculated as: `matches / (matches + mismatches + insertion
events + deletion events)` ### perID_by_all is calculated as: `matches / (matches + mismatches +
insertion bases + deletion bases)`

USAGE:
    rustybam stats [OPTIONS] [BAM]

ARGS:
    <BAM>
            Input sam/bam/cram/file
            
            [default: -]

OPTIONS:
    -q, --qbed
            Print query coordinates first

    -p, --paf
            Specify that the input is paf format, (must have cg tag with extended cigar)

    -h, --help
            Print help information

    -V, --version
            Print version information
```


## rustybam_Get

### Tool Description
A tool for working with BAM files.

### Metadata
- **Docker Image**: quay.io/biocontainers/rustybam:0.1.34--hf24ce72_0
- **Homepage**: https://github.com/mrvollger/rustybam
- **Package**: https://anaconda.org/channels/bioconda/packages/rustybam/overview
- **Validation**: PASS

### Original Help Text
```text
error: The subcommand 'Get' wasn't recognized

USAGE:
    rustybam [OPTIONS] <SUBCOMMAND>

For more information try --help
```


## rustybam_CIGAR

### Tool Description
A Rust library for reading and writing BAM files.

### Metadata
- **Docker Image**: quay.io/biocontainers/rustybam:0.1.34--hf24ce72_0
- **Homepage**: https://github.com/mrvollger/rustybam
- **Package**: https://anaconda.org/channels/bioconda/packages/rustybam/overview
- **Validation**: PASS

### Original Help Text
```text
error: The subcommand 'CIGAR' wasn't recognized

USAGE:
    rustybam [OPTIONS] <SUBCOMMAND>

For more information try --help
```


## rustybam_bed-length

### Tool Description
Count the number of bases in a bed file

### Metadata
- **Docker Image**: quay.io/biocontainers/rustybam:0.1.34--hf24ce72_0
- **Homepage**: https://github.com/mrvollger/rustybam
- **Package**: https://anaconda.org/channels/bioconda/packages/rustybam/overview
- **Validation**: PASS

### Original Help Text
```text
rustybam-bed-length 0.1.34
Count the number of bases in a bed file

USAGE:
    rustybam bed-length [OPTIONS] [BED]...

ARGS:
    <BED>...    Input bed file [default: -]

OPTIONS:
    -r, --readable           Make the output human readable (Mbp)
    -c, --column <COLUMN>    Count bases for each category in this column <COLUMN>
    -h, --help               Print help information
    -V, --version            Print version information
```


## rustybam_filter

### Tool Description
Filter PAF records in various ways

### Metadata
- **Docker Image**: quay.io/biocontainers/rustybam:0.1.34--hf24ce72_0
- **Homepage**: https://github.com/mrvollger/rustybam
- **Package**: https://anaconda.org/channels/bioconda/packages/rustybam/overview
- **Validation**: PASS

### Original Help Text
```text
rustybam-filter 0.1.34
Filter PAF records in various ways

USAGE:
    rustybam filter [OPTIONS] [PAF]

ARGS:
    <PAF>    PAF file from minimap2 or unimap. Must have the cg tag, and n matches will be zero
             unless the cigar uses =X [default: -]

OPTIONS:
    -p, --paired-len <PAIRED_LEN>    Minimum number of aligned bases across all alignments between a
                                     target and query in order to keep those records [default: 0]
    -a, --aln <ALN>                  Minimum alignment length [default: 0]
    -q, --query <QUERY>              Minimum query length [default: 0]
    -h, --help                       Print help information
    -V, --version                    Print version information
```


## rustybam_Filter

### Tool Description
A tool for manipulating BAM files.

### Metadata
- **Docker Image**: quay.io/biocontainers/rustybam:0.1.34--hf24ce72_0
- **Homepage**: https://github.com/mrvollger/rustybam
- **Package**: https://anaconda.org/channels/bioconda/packages/rustybam/overview
- **Validation**: PASS

### Original Help Text
```text
error: The subcommand 'Filter' wasn't recognized

	Did you mean 'filter'?

If you believe you received this message in error, try re-running with 'rustybam -- Filter'

USAGE:
    rustybam [OPTIONS] <SUBCOMMAND>

For more information try --help
```


## rustybam_invert

### Tool Description
Invert the target and query sequences in a PAF along with the CIGAR string

### Metadata
- **Docker Image**: quay.io/biocontainers/rustybam:0.1.34--hf24ce72_0
- **Homepage**: https://github.com/mrvollger/rustybam
- **Package**: https://anaconda.org/channels/bioconda/packages/rustybam/overview
- **Validation**: PASS

### Original Help Text
```text
rustybam-invert 0.1.34
Invert the target and query sequences in a PAF along with the CIGAR string

USAGE:
    rustybam invert [PAF]

ARGS:
    <PAF>    PAF file from minimap2 or unimap. Must have the cg tag, and n matches will be zero
             unless the cigar uses =X [default: -]

OPTIONS:
    -h, --help       Print help information
    -V, --version    Print version information
```


## rustybam_Invert

### Tool Description
A tool for manipulating BAM files.

### Metadata
- **Docker Image**: quay.io/biocontainers/rustybam:0.1.34--hf24ce72_0
- **Homepage**: https://github.com/mrvollger/rustybam
- **Package**: https://anaconda.org/channels/bioconda/packages/rustybam/overview
- **Validation**: PASS

### Original Help Text
```text
error: The subcommand 'Invert' wasn't recognized

	Did you mean 'invert'?

If you believe you received this message in error, try re-running with 'rustybam -- Invert'

USAGE:
    rustybam [OPTIONS] <SUBCOMMAND>

For more information try --help
```


## rustybam_liftover

### Tool Description
Liftover target sequence coordinates onto query sequence using a PAF.

### Metadata
- **Docker Image**: quay.io/biocontainers/rustybam:0.1.34--hf24ce72_0
- **Homepage**: https://github.com/mrvollger/rustybam
- **Package**: https://anaconda.org/channels/bioconda/packages/rustybam/overview
- **Validation**: PASS

### Original Help Text
```text
rustybam-liftover 0.1.34
Liftover target sequence coordinates onto query sequence using a PAF.

This is a function for lifting over coordinates from a reference (<BED>) to a query using a PAF file
from minimap2 or unimap (note, you can use `paftools.js sam2paf` to convert SAM data to PAF format).
The returned file is a PAF file that is trimmed to the regions in the bed file. Even the cigar in
the returned PAF file is trimmed so it can be used downstream! Additionally, a tag with the format
`id:Z:<>` is added to the PAF where `<>` is either the 4th column of the input bed file or if not
present `chr_start_end`.

USAGE:
    rustybam liftover [OPTIONS] --bed <BED> [PAF]

ARGS:
    <PAF>
            PAF file from minimap2 or unimap run with -c and --eqx [i.e. the PAF file must have the
            cg tag and use extended CIGAR opts (=/X)]
            
            [default: -]

OPTIONS:
    -b, --bed <BED>
            BED file of reference regions to liftover to the query

    -q, --qbed
            Specifies that the BED file contains query coordinates to be lifted onto the reference
            (reverses direction of liftover).
            
            Note, that this will make the query in the input `PAF` the target in the output `PAF`.

    -l, --largest
            If multiple records overlap the same region in the <bed> return only the largest
            liftover. The default is to return all liftovers

    -h, --help
            Print help information

    -V, --version
            Print version information
```


## rustybam_trim-paf

### Tool Description
Trim PAF records that overlap in query sequence to find and optimal splitting point using dynamic programing.

### Metadata
- **Docker Image**: quay.io/biocontainers/rustybam:0.1.34--hf24ce72_0
- **Homepage**: https://github.com/mrvollger/rustybam
- **Package**: https://anaconda.org/channels/bioconda/packages/rustybam/overview
- **Validation**: PASS

### Original Help Text
```text
rustybam-trim-paf 0.1.34
Trim PAF records that overlap in query sequence to find and optimal splitting point using dynamic
programing.

Note, this can be combined with `rb invert` to also trim the target sequence.

This idea is to mimic some of the trimming that happens in PAV to improve breakpoint detection.
Starts with the largest overlap and iterates until no query overlaps remain.

USAGE:
    rustybam trim-paf [OPTIONS] [PAF]

ARGS:
    <PAF>
            PAF file from minimap2 or unimap. Must have the cg tag, and n matches will be zero
            unless the cigar uses =X
            
            [default: -]

OPTIONS:
    -m, --match-score <MATCH_SCORE>
            Value added for a matching base
            
            [default: 1]

    -d, --diff-score <DIFF_SCORE>
            Value subtracted for a mismatching base
            
            [default: 1]

    -i, --indel-score <INDEL_SCORE>
            Value subtracted for an insertion or deletion
            
            [default: 1]

    -r, --remove-contained
            Remove contained alignments as well as overlaps

    -h, --help
            Print help information

    -V, --version
            Print version information
```


## rustybam_Trim

### Tool Description
A tool for manipulating BAM files.

### Metadata
- **Docker Image**: quay.io/biocontainers/rustybam:0.1.34--hf24ce72_0
- **Homepage**: https://github.com/mrvollger/rustybam
- **Package**: https://anaconda.org/channels/bioconda/packages/rustybam/overview
- **Validation**: PASS

### Original Help Text
```text
error: The subcommand 'Trim' wasn't recognized

	Did you mean 'trim'?

If you believe you received this message in error, try re-running with 'rustybam -- Trim'

USAGE:
    rustybam [OPTIONS] <SUBCOMMAND>

For more information try --help
```


## rustybam_orient

### Tool Description
Orient paf records so that most of the bases are in the forward direction.

Optionally scaffold the queriers so that there is one query per target.

### Metadata
- **Docker Image**: quay.io/biocontainers/rustybam:0.1.34--hf24ce72_0
- **Homepage**: https://github.com/mrvollger/rustybam
- **Package**: https://anaconda.org/channels/bioconda/packages/rustybam/overview
- **Validation**: PASS

### Original Help Text
```text
rustybam-orient 0.1.34
Orient paf records so that most of the bases are in the forward direction.

Optionally scaffold the queriers so that there is one query per target.

USAGE:
    rustybam orient [OPTIONS] [PAF]

ARGS:
    <PAF>
            PAF file from minimap2 or unimap. Must have the cg tag, and n matches will be zero
            unless the cigar uses =X
            
            [default: -]

OPTIONS:
    -s, --scaffold
            Generate ~1 query per target that scaffolds together all the records that map to that
            target sequence.
            
            The order of the scaffold will be determined by the average target position across all
            the queries, and the name of the new scaffold will be.

    -i, --insert <INSERT>
            Space to add between records
            
            [default: 1000000]

    -h, --help
            Print help information

    -V, --version
            Print version information
```


## rustybam_Orient

### Tool Description
A tool for manipulating BAM files.

### Metadata
- **Docker Image**: quay.io/biocontainers/rustybam:0.1.34--hf24ce72_0
- **Homepage**: https://github.com/mrvollger/rustybam
- **Package**: https://anaconda.org/channels/bioconda/packages/rustybam/overview
- **Validation**: PASS

### Original Help Text
```text
error: The subcommand 'Orient' wasn't recognized

	Did you mean 'orient'?

If you believe you received this message in error, try re-running with 'rustybam -- Orient'

USAGE:
    rustybam [OPTIONS] <SUBCOMMAND>

For more information try --help
```


## rustybam_break-paf

### Tool Description
Break PAF records with large indels into multiple records (useful for SafFire)

### Metadata
- **Docker Image**: quay.io/biocontainers/rustybam:0.1.34--hf24ce72_0
- **Homepage**: https://github.com/mrvollger/rustybam
- **Package**: https://anaconda.org/channels/bioconda/packages/rustybam/overview
- **Validation**: PASS

### Original Help Text
```text
rustybam-break-paf 0.1.34
Break PAF records with large indels into multiple records (useful for SafFire)

USAGE:
    rustybam break-paf [OPTIONS] [PAF]

ARGS:
    <PAF>    PAF file from minimap2 or unimap. Must have the cg tag, and n matches will be zero
             unless the cigar uses =X [default: -]

OPTIONS:
    -m, --max-size <MAX_SIZE>    Maximum indel size to keep in the paf [default: 100]
    -h, --help                   Print help information
    -V, --version                Print version information
```


## rustybam_paf-to-sam

### Tool Description
Convert a PAF file into a SAM file. Warning, all alignments will be marked as primary!

### Metadata
- **Docker Image**: quay.io/biocontainers/rustybam:0.1.34--hf24ce72_0
- **Homepage**: https://github.com/mrvollger/rustybam
- **Package**: https://anaconda.org/channels/bioconda/packages/rustybam/overview
- **Validation**: PASS

### Original Help Text
```text
rustybam-paf-to-sam 0.1.34
Convert a PAF file into a SAM file. Warning, all alignments will be marked as primary!

USAGE:
    rustybam paf-to-sam [OPTIONS] [PAF]

ARGS:
    <PAF>    PAF file from minimap2 or unimap. Must have a CIGAR tag [default: -]

OPTIONS:
    -f, --fasta <FASTA>    Optional query fasta file (with index) to populate the query seq field
    -h, --help             Print help information
    -V, --version          Print version information
```


## rustybam_Convert

### Tool Description
A command-line tool for manipulating BAM files.

### Metadata
- **Docker Image**: quay.io/biocontainers/rustybam:0.1.34--hf24ce72_0
- **Homepage**: https://github.com/mrvollger/rustybam
- **Package**: https://anaconda.org/channels/bioconda/packages/rustybam/overview
- **Validation**: PASS

### Original Help Text
```text
error: The subcommand 'Convert' wasn't recognized

	Did you mean 'invert'?

If you believe you received this message in error, try re-running with 'rustybam -- Convert'

USAGE:
    rustybam [OPTIONS] <SUBCOMMAND>

For more information try --help
```


## rustybam_fastx-split

### Tool Description
Splits fastx from stdin into multiple files.

### Metadata
- **Docker Image**: quay.io/biocontainers/rustybam:0.1.34--hf24ce72_0
- **Homepage**: https://github.com/mrvollger/rustybam
- **Package**: https://anaconda.org/channels/bioconda/packages/rustybam/overview
- **Validation**: PASS

### Original Help Text
```text
rustybam-fastx-split 0.1.34
Splits fastx from stdin into multiple files.

Specifically it reads fastx format (fastq, fasta, or mixed) from stdin and divides the records
across multiple output files. Output files can be compressed by adding `.gz`, and the input can also
be compressed or uncompressed.

USAGE:
    rustybam fastx-split [FASTX]...

ARGS:
    <FASTX>...
            List of fastx files to write to

OPTIONS:
    -h, --help
            Print help information

    -V, --version
            Print version information
```


## rustybam_get-fasta

### Tool Description
Mimic bedtools getfasta but allow for bgzip in both bed and fasta inputs

### Metadata
- **Docker Image**: quay.io/biocontainers/rustybam:0.1.34--hf24ce72_0
- **Homepage**: https://github.com/mrvollger/rustybam
- **Package**: https://anaconda.org/channels/bioconda/packages/rustybam/overview
- **Validation**: PASS

### Original Help Text
```text
rustybam-get-fasta 0.1.34
Mimic bedtools getfasta but allow for bgzip in both bed and fasta inputs

USAGE:
    rustybam get-fasta [OPTIONS] --bed <BED>

OPTIONS:
    -f, --fasta <FASTA>    Fasta file to extract sequences from [default: -]
    -b, --bed <BED>        BED file of regions to extract
    -s, --strand           Reverse complement the sequence if the strand is "-"
    -n, --name             Add the name (4th column) to the header of the fasta output
    -h, --help             Print help information
    -V, --version          Print version information
```


## rustybam_nucfreq

### Tool Description
Get the frequencies of each bp at each position

### Metadata
- **Docker Image**: quay.io/biocontainers/rustybam:0.1.34--hf24ce72_0
- **Homepage**: https://github.com/mrvollger/rustybam
- **Package**: https://anaconda.org/channels/bioconda/packages/rustybam/overview
- **Validation**: PASS

### Original Help Text
```text
rustybam-nucfreq 0.1.34
Get the frequencies of each bp at each position

USAGE:
    rustybam nucfreq [OPTIONS] [BAM]

ARGS:
    <BAM>    Input sam/bam/cram/file [default: -]

OPTIONS:
    -r, --region <REGION>    Print nucfreq info from the input region e.g "chr1:1-1000"
    -b, --bed <BED>          Print nucfreq info from regions in the bed file output is optionally
                             tagged using the 4th column
    -s, --small              Smaller output format
    -h, --help               Print help information
    -V, --version            Print version information
```


## rustybam_repeat

### Tool Description
Report the longest exact repeat length at every position in a fasta

### Metadata
- **Docker Image**: quay.io/biocontainers/rustybam:0.1.34--hf24ce72_0
- **Homepage**: https://github.com/mrvollger/rustybam
- **Package**: https://anaconda.org/channels/bioconda/packages/rustybam/overview
- **Validation**: PASS

### Original Help Text
```text
rustybam-repeat 0.1.34
Report the longest exact repeat length at every position in a fasta

USAGE:
    rustybam repeat [OPTIONS] [FASTA]

ARGS:
    <FASTA>    Input fasta file [default: -]

OPTIONS:
    -m, --min <MIN>    The smallest repeat length to report [default: 21]
    -h, --help         Print help information
    -V, --version      Print version information
```


## rustybam_Report

### Tool Description
A tool for working with BAM files.

### Metadata
- **Docker Image**: quay.io/biocontainers/rustybam:0.1.34--hf24ce72_0
- **Homepage**: https://github.com/mrvollger/rustybam
- **Package**: https://anaconda.org/channels/bioconda/packages/rustybam/overview
- **Validation**: PASS

### Original Help Text
```text
error: The subcommand 'Report' wasn't recognized

USAGE:
    rustybam [OPTIONS] <SUBCOMMAND>

For more information try --help
```


## rustybam_suns

### Tool Description
Extract the intervals in a genome (fasta) that are made up of SUNs

### Metadata
- **Docker Image**: quay.io/biocontainers/rustybam:0.1.34--hf24ce72_0
- **Homepage**: https://github.com/mrvollger/rustybam
- **Package**: https://anaconda.org/channels/bioconda/packages/rustybam/overview
- **Validation**: PASS

### Original Help Text
```text
rustybam-suns 0.1.34
Extract the intervals in a genome (fasta) that are made up of SUNs

USAGE:
    rustybam suns [OPTIONS]

OPTIONS:
    -f, --fasta <FASTA>            Input fasta file with the genome [default: -]
    -k, --kmer-size <KMER_SIZE>    The size of the required unique kmer [default: 21]
    -m, --max-size <MAX_SIZE>      The maximum size SUN interval to report [default:
                                   18446744073709551615]
    -v, --validate                 Confirm all the SUNs (very slow) only for debugging
    -h, --help                     Print help information
    -V, --version                  Print version information
```


## rustybam_Extract

### Tool Description
A tool for manipulating BAM files.

### Metadata
- **Docker Image**: quay.io/biocontainers/rustybam:0.1.34--hf24ce72_0
- **Homepage**: https://github.com/mrvollger/rustybam
- **Package**: https://anaconda.org/channels/bioconda/packages/rustybam/overview
- **Validation**: PASS

### Original Help Text
```text
error: The subcommand 'Extract' wasn't recognized

USAGE:
    rustybam [OPTIONS] <SUBCOMMAND>

For more information try --help
```


## rustybam_add-rg

### Tool Description
Add RG lines from a source BAM file to the BAM from stdin to the BAM going to stdout

### Metadata
- **Docker Image**: quay.io/biocontainers/rustybam:0.1.34--hf24ce72_0
- **Homepage**: https://github.com/mrvollger/rustybam
- **Package**: https://anaconda.org/channels/bioconda/packages/rustybam/overview
- **Validation**: PASS

### Original Help Text
```text
rustybam-add-rg 0.1.34
Add RG lines from a source BAM file to the BAM from stdin to the BAM going to stdout

USAGE:
    rustybam add-rg [OPTIONS] <SOURCE>

ARGS:
    <SOURCE>    Source BAM file to read RG lines from

OPTIONS:
    -t, --threads <THREADS>    Number of threads to use [default: 8]
    -u, --uncompressed         Write uncompressed output
    -s, --sample <SAMPLE>      Add this string as the sample name (SM) to each read group in the
                               output BAM
    -h, --help                 Print help information
    -V, --version              Print version information
```


## rustybam_Add

### Tool Description
A tool for manipulating BAM files.

### Metadata
- **Docker Image**: quay.io/biocontainers/rustybam:0.1.34--hf24ce72_0
- **Homepage**: https://github.com/mrvollger/rustybam
- **Package**: https://anaconda.org/channels/bioconda/packages/rustybam/overview
- **Validation**: PASS

### Original Help Text
```text
error: The subcommand 'Add' wasn't recognized

USAGE:
    rustybam [OPTIONS] <SUBCOMMAND>

For more information try --help
```


## rustybam_seq-stats

### Tool Description
Calculate summary statistics from fasta/q, sam, bam, or bed files. e.g. N50, mean, quantiles

### Metadata
- **Docker Image**: quay.io/biocontainers/rustybam:0.1.34--hf24ce72_0
- **Homepage**: https://github.com/mrvollger/rustybam
- **Package**: https://anaconda.org/channels/bioconda/packages/rustybam/overview
- **Validation**: PASS

### Original Help Text
```text
rustybam-seq-stats 0.1.34
Calculate summary statistics from fasta/q, sam, bam, or bed files. e.g. N50, mean, quantiles

USAGE:
    rustybam seq-stats [OPTIONS] <INFILES>...

ARGS:
    <INFILES>...    Input files (fast{a,q}(.gz), sam, bam, bed)

OPTIONS:
    -t, --threads <THREADS>            Number of threads to use [default: 4]
    -r, --human                        Print human-readable output
    -q, --quantiles <QUANTILES>        Quantiles to calculate [default: 0.5]
    -g, --genome-size <GENOME_SIZE>    Genome size for NG50 calculation
    -h, --help                         Print help information
    -V, --version                      Print version information
```


## rustybam_Calculate

### Tool Description
A Rust library for working with BAM files.

### Metadata
- **Docker Image**: quay.io/biocontainers/rustybam:0.1.34--hf24ce72_0
- **Homepage**: https://github.com/mrvollger/rustybam
- **Package**: https://anaconda.org/channels/bioconda/packages/rustybam/overview
- **Validation**: PASS

### Original Help Text
```text
error: The subcommand 'Calculate' wasn't recognized

USAGE:
    rustybam [OPTIONS] <SUBCOMMAND>

For more information try --help
```


## rustybam_quantiles

### Tool Description
A tool for processing BAM files.

### Metadata
- **Docker Image**: quay.io/biocontainers/rustybam:0.1.34--hf24ce72_0
- **Homepage**: https://github.com/mrvollger/rustybam
- **Package**: https://anaconda.org/channels/bioconda/packages/rustybam/overview
- **Validation**: PASS

### Original Help Text
```text
error: The subcommand 'quantiles' wasn't recognized

USAGE:
    rustybam [OPTIONS] <SUBCOMMAND>

For more information try --help
```


## rustybam_Print

### Tool Description
A command-line tool for manipulating BAM files.

### Metadata
- **Docker Image**: quay.io/biocontainers/rustybam:0.1.34--hf24ce72_0
- **Homepage**: https://github.com/mrvollger/rustybam
- **Package**: https://anaconda.org/channels/bioconda/packages/rustybam/overview
- **Validation**: PASS

### Original Help Text
```text
error: The subcommand 'Print' wasn't recognized

	Did you mean 'orient'?

If you believe you received this message in error, try re-running with 'rustybam -- Print'

USAGE:
    rustybam [OPTIONS] <SUBCOMMAND>

For more information try --help
```


## Metadata
- **Skill**: generated
