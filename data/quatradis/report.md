# quatradis CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| quatradis_tradis_compare_essentiality | PASS | output of tradis plot count on a QuaTradis repo test plot; essentiality table identical to the repo expected small_control file |
| quatradis_tradis_compare_gene_report | Not completed | ran on the repo's saved comparison output (compare insertion_sites cannot run in this image); regions and signs agree with the logFC plot, but the reported values could not be confirmed. |
| quatradis_tradis_compare_insertion_sites | Failed | image problem: R package edgeR is missing, so tradis_comparison.R stops; genome_length made required |
| quatradis_tradis_compare_presence_absence | PASS | QuaTradis repo presence-absence test data; logFC matrix values identical to the repo expected file, with heatmaps and trees; output folder collected as a Directory |
| quatradis_tradis_plot_combine | PASS | QuaTradis repo combine test plots with a list file; combined plots are the sums of the input plots, with tabix index; list file and plots staged together |
| quatradis_tradis_plot_count | PASS | QuaTradis repo pipeline plots and EMBL annotation; read and insertion counts for the first gene (78 reads, 13 sites) match a direct count of the plot |
| quatradis_tradis_plot_create | PASS | QuaTradis repo test FASTQ and reference; 23 of 23 reads mapped with 9 unique insertion sites in the plot |
| quatradis_tradis_plot_normalise | PASS | QuaTradis repo pipeline plots; the plot with most reads stays unchanged and the other is scaled up towards it |
| quatradis_tradis_utils_index | PASS | QuaTradis repo smallref.fa; BWA index files (.amb .ann .bwt .pac .sa) written |

## quatradis_tradis_compare_essentiality

### Tool Description
Determine how essential each gene is based on the transposon insertion site plot counts.

### Metadata
- **Docker Image**: quay.io/biocontainers/quatradis:1.4.0--py312h0fa9677_1
- **Homepage**: https://github.com/quadram-institute-bioscience/QuaTradis
- **Package**: https://anaconda.org/channels/bioconda/packages/quatradis/overview
- **Validation**: PASS

### Original Help Text
```text
usage: tradis compare essentiality [options] <plot_count_file>

Determines how essential each gene is based on the transposon insertion site
plot counts

positional arguments:
  count_file     Counts from a transposon insertion site plot file to be used.
                 i.e. generated from "tradis plot count"

options:
  -h, --help     show this help message and exit
  --profile      Turn on profiling. Prints out cumulative time in each
                 function to stdout and to an output file (tradis.profile).
                 The profile file can be read by tools such as snakeviz.
  --verbose, -v  Print out extra information about the process while it runs
```

## quatradis_tradis_compare_gene_report

### Tool Description
Generate a gene report from comparison analysis data.

### Metadata
- **Docker Image**: quay.io/biocontainers/quatradis:1.4.0--py312h0fa9677_1
- **Homepage**: https://github.com/quadram-institute-bioscience/QuaTradis
- **Package**: https://anaconda.org/channels/bioconda/packages/quatradis/overview
- **Validation**: PASS

### Original Help Text
```text
usage: tradis compare gene_report [options] <comparison_dir> <EMBL_file>

Generate gene report from comparison analysis data

positional arguments:
  embl                  Original EMBL file used for analysis

options:
  -h, --help            show this help message and exit
  --combined COMBINED   Combined plotfile
  --forward FORWARD     Forward plotfile
  --reverse REVERSE     Reverse plotfile
  --scores SCORES       Combined scores
  --window_size WINDOW_SIZE, -w WINDOW_SIZE
                        Window size
  --output_dir OUTPUT_DIR, -o OUTPUT_DIR
                        Output filename prefix
  --use_annotations, -a
                        EMBL file is a real EMBL file with annotations (not a
                        set of windows)
  --profile             Turn on profiling. Prints out cumulative time in each
                        function to stdout and to an output file
                        (tradis.profile). The profile file can be read by
                        tools such as snakeviz.
  --verbose, -v         Print out extra information about the process while it
                        runs
```

## quatradis_tradis_compare_insertion_sites

### Tool Description
Run an insertion site comparison for a specific plot file direction (forward, reverse, combined, original) over all experiments to produce a file including edgeR output (logfc, p and q values).

### Metadata
- **Docker Image**: quay.io/biocontainers/quatradis:1.4.0--py312h0fa9677_1
- **Homepage**: https://github.com/quadram-institute-bioscience/QuaTradis
- **Package**: https://anaconda.org/channels/bioconda/packages/quatradis/overview
- **Validation**: PASS

### Original Help Text
```text
usage: tradis compare insertion_sites [options] --condition_dirs <condition_plotfiles>+ --control_dirs <control_plotfiles>+ <EMBL_file> <analysis_type>

Run an insertion site comparison for a specific plot file direction: forward,
reverse, combined, original over all experiments to produce a file including
edgeR output (logfc, p and q values)

positional arguments:
  emblfile              Annotation file in EMBL format
  analysis_type         Analysis type: forward, reverse, combined, original

options:
  -h, --help            show this help message and exit
  --controls CONTROLS [CONTROLS ...]
                        Control plot files (optionally gzipped). There must be
                        an equal number of condition and control files.
  --conditions CONDITIONS [CONDITIONS ...]
                        Condition plot files (optionally gzipped). There must
                        be an equal number of condition and control files.
  --span_gaps SPAN_GAPS, -s SPAN_GAPS
                        Span a gap if it is this multiple of a window size
                        (default: 1)
  --minimum_block MINIMUM_BLOCK, -b MINIMUM_BLOCK
                        Minimum number of reads which must be in 1 block in
                        comparison (default: 100)
  --minimum_logfc MINIMUM_LOGFC, -f MINIMUM_LOGFC
                        Minimum log fold change +/- (default: 1)
  --minimum_logcpm MINIMUM_LOGCPM, -c MINIMUM_LOGCPM
                        Minimum log counts per million +/- (default: 8.0)
  --minimum_proportion_insertions MINIMUM_PROPORTION_INSERTIONS, -d MINIMUM_PROPORTION_INSERTIONS
                        If the proportion of insertions is too low compared to
                        control, do not call decreased insertions below this
                        level (default: 0.1)
  --prefix PREFIX, -o PREFIX
                        Output directory prefix
  --pvalue PVALUE, -p PVALUE
                        Do not report anything above this p-value (default:
                        0.05)
  --qvalue QVALUE, -q QVALUE
                        Do not report anything above this q-value (default:
                        0.05)
  --window_size WINDOW_SIZE, -w WINDOW_SIZE
                        Window size (default: 100)
  --dont_report_decreased_insertions, -r
                        Whether or not to report decreased insertions
  --genome_length GENOME_LENGTH, -g GENOME_LENGTH
                        The length of the genome or sequence being analysed
  --profile             Turn on profiling. Prints out cumulative time in each
                        function to stdout and to an output file
                        (tradis.profile). The profile file can be read by
                        tools such as snakeviz.
  --verbose, -v         Print out extra information about the process while it
                        runs
```

## quatradis_tradis_compare_presence_absence

### Tool Description
Take in gene report files and produce a heatmap.

### Metadata
- **Docker Image**: quay.io/biocontainers/quatradis:1.4.0--py312h0fa9677_1
- **Homepage**: https://github.com/quadram-institute-bioscience/QuaTradis
- **Package**: https://anaconda.org/channels/bioconda/packages/quatradis/overview
- **Validation**: PASS

### Original Help Text
```text
usage: tradis compare presence_absence [options] <EMBLfile> <gene_reports>+

Take in gene report files and produce a heatmap

positional arguments:
  emblfile              Annotation file in EMBL format
  genereports           Gene report spreadsheets

options:
  -h, --help            show this help message and exit
  --prefix PREFIX, -o PREFIX
                        Output directory prefix
  --profile             Turn on profiling. Prints out cumulative time in each
                        function to stdout and to an output file
                        (tradis.profile). The profile file can be read by
                        tools such as snakeviz.
  --verbose, -v         Print out extra information about the process while it
                        runs
```

## quatradis_tradis_plot_combine

### Tool Description
Combine multiple TraDIS plot files into one, optionally in groups, controlled by a tab-delimited list file.

### Metadata
- **Docker Image**: quay.io/biocontainers/quatradis:1.4.0--py312h0fa9677_1
- **Homepage**: https://github.com/quadram-institute-bioscience/QuaTradis
- **Package**: https://anaconda.org/channels/bioconda/packages/quatradis/overview
- **Validation**: PASS

### Original Help Text
```text
usage: 

Combine multiple TraDIS plot files into one. Also can combine plots files in
groups. The plot combining process is controlled via a tab-delimited file with
an ID as the first column followed by a list of plotfiles to combine per row.
The ID will be used to name the new plotfile and as an identifier in the stats
file, so ensure these are unique.

positional arguments:
  plot_file_list        A tab delimited file with id in the first column
                        followed by a list of plot files

options:
  -h, --help            show this help message and exit
  --combined_dir COMBINED_DIR
                        The directory in which to store the combined output
                        files (default: combined)
  --profile             Turn on profiling. Prints out cumulative time in each
                        function to stdout and to an output file
                        (tradis.profile). The profile file can be read by
                        tools such as snakeviz.
  --verbose, -v         Print out extra information about the process while it
                        runs
```

## quatradis_tradis_plot_count

### Tool Description
Take in one or more plot files and an EMBL file to produce a tab delimited file with insert site details to use as input to an essentiality test.

### Metadata
- **Docker Image**: quay.io/biocontainers/quatradis:1.4.0--py312h0fa9677_1
- **Homepage**: https://github.com/quadram-institute-bioscience/QuaTradis
- **Package**: https://anaconda.org/channels/bioconda/packages/quatradis/overview
- **Validation**: PASS

### Original Help Text
```text
usage: 

Take in one or more plot files and an embl file to produce a tab delimited
file with insert site details to use as input to another script to test for
essentiality.

positional arguments:
  embl_in               The embl formatted annotation file
  plot_in               The insertion site plot files (can be gzipped)

options:
  -h, --help            show this help message and exit
  -o OUTPUT_DIR, --output_dir OUTPUT_DIR
                        The directory in which to put all output files
                        (default: current working directory)
  -s OUTPUT_SUFFIX, --output_suffix OUTPUT_SUFFIX
                        The suffix to add to output files (optional, default =
                        tradis_gene_insert_sites.csv)
  --trim5               Trim insertion sites from 5' end of gene
  --trim3               Trim insertion sites from 3' end of gene
  -j, --joined_output   output a single file with all info.
  --profile             Turn on profiling. Prints out cumulative time in each
                        function to stdout and to an output file
                        (tradis.profile). The profile file can be read by
                        tools such as snakeviz.
  --verbose, -v         Print out extra information about the process while it
                        runs
```

## quatradis_tradis_plot_create

### Tool Description
Create a TraDIS plot file from either FASTQ or alignment file input.

### Metadata
- **Docker Image**: quay.io/biocontainers/quatradis:1.4.0--py312h0fa9677_1
- **Homepage**: https://github.com/quadram-institute-bioscience/QuaTradis
- **Package**: https://anaconda.org/channels/bioconda/packages/quatradis/overview
- **Validation**: PASS

### Original Help Text
```text
usage: 

Can create a TraDIS plot file from either fastq or alignment file input

positional arguments:
  fastq                 Either the fastq formatted reads for processing (can
                        be gzipped)
  reference             The fasta formatted reference for processing.

options:
  -h, --help            show this help message and exit
  -l ALIGNMENTS, --alignments ALIGNMENTS
                        SAM or BAM file. If provided then we will skip
                        aligning the fastq to the reference.
  -o OUTPUT_DIR, --output_dir OUTPUT_DIR
                        The directory in which to put all output files
                        (default: current working directory)
  -p OUTPUT_PREFIX, --output_prefix OUTPUT_PREFIX
                        The filename prefix to use for all output files
                        (default: quatradis_out)
  -n THREADS, --threads THREADS
                        number of threads to use when mapping and sorting
                        (default: 1)
  -a ALIGNER, --aligner ALIGNER
                        mapping tool to use (bwa, smalt, minimap2,
                        minimap2_long) (default: bwa)
  -ni, --no_ref_index   If reference is alredy indexed used this flag to skip
                        the indexing process.
  -m MAPPING_SCORE, --mapping_score MAPPING_SCORE
                        mapping quality must be greater than X (Default: 30)
  -t TAG, --tag TAG     the tag to remove from fastq input (default: "")
  -mm MISMATCH, --mismatch MISMATCH
                        number of mismatches allowed when matching tag
                        (default: 0)
  --profile             Turn on profiling. Prints out cumulative time in each
                        function to stdout and to an output file
                        (tradis.profile). The profile file can be read by
                        tools such as snakeviz.
  --verbose, -v         Print out extra information about the process while it
                        runs
```

## quatradis_tradis_plot_normalise

### Tool Description
Given a set of plot files, find the one with the highest number of reads and normalise all the rest into new files.

### Metadata
- **Docker Image**: quay.io/biocontainers/quatradis:1.4.0--py312h0fa9677_1
- **Homepage**: https://github.com/quadram-institute-bioscience/QuaTradis
- **Package**: https://anaconda.org/channels/bioconda/packages/quatradis/overview
- **Validation**: PASS

### Original Help Text
```text
usage: tradis tisp normalise [options] <plot_file>+

Given a set of plot files, find the one with the highest number of reads and
normalise all the rest into new files

positional arguments:
  plot_files            One or more paths to transposon insertion site plot
                        files

options:
  -h, --help            show this help message and exit
  --minimum_proportion_insertions MINIMUM_PROPORTION_INSERTIONS, -d MINIMUM_PROPORTION_INSERTIONS
                        If the proportion of insertions is too low compared to
                        control, dont call decreased insertions below this
                        level
  -o OUTPUT_DIR, --output_dir OUTPUT_DIR
                        The directory in which to put all output files
                        (default: current working directory)
  -n OUTPUT_FILENAME, --output_filename OUTPUT_FILENAME
                        The name for the normalised output files. Normalised
                        files will be distinguished by directory
  --profile             Turn on profiling. Prints out cumulative time in each
                        function to stdout and to an output file
                        (tradis.profile). The profile file can be read by
                        tools such as snakeviz.
  --verbose, -v         Print out extra information about the process while it
                        runs
```

## quatradis_tradis_utils_index

### Tool Description
Index a reference using the specified alignment tool.

### Metadata
- **Docker Image**: quay.io/biocontainers/quatradis:1.4.0--py312h0fa9677_1
- **Homepage**: https://github.com/quadram-institute-bioscience/QuaTradis
- **Package**: https://anaconda.org/channels/bioconda/packages/quatradis/overview
- **Validation**: PASS

### Original Help Text
```text
usage: tradis utils index [options] <reference fasta file> <reference name>

Index a reference using specified alignment tool.

positional arguments:
  reference             The fasta formatted reference for processing.
  refname               The name for this reference.

options:
  -h, --help            show this help message and exit
  -a ALIGNER, --aligner ALIGNER
                        read aligning tool to use (bwa, smalt, minimap2)
                        (default: bwa)
  -r READ_LEN, --read_len READ_LEN
                        the average read length used (required for smalt)
  -sk SMALT_K, --smalt_k SMALT_K
                        the average read length used
  -ss SMALT_S, --smalt_s SMALT_S
                        the average read length used
  --profile             Turn on profiling. Prints out cumulative time in each
                        function to stdout and to an output file
                        (tradis.profile). The profile file can be read by
                        tools such as snakeviz.
  --verbose, -v         Print out extra information about the process while it
                        runs
```

