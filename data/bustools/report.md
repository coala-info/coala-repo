# bustools CWL Generation Report

## bustools_sort

### Tool Description
Sort BUS files by barcode, UMI, ec, and flag.

### Metadata
- **Docker Image**: quay.io/biocontainers/bustools:0.45.1--h6f0a7f7_0
- **Homepage**: https://github.com/BUStools/bustools
- **Package**: https://anaconda.org/channels/bioconda/packages/bustools/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/bustools/overview
- **Total Downloads**: 37.8K
- **Last updated**: 2025-05-28
- **GitHub**: https://github.com/BUStools/bustools
- **Stars**: N/A
### Original Help Text
```text
Usage: bustools sort [options] bus-files

Options: 
Default behavior is to sort by barcode, UMI, ec, then flag
-t, --threads         Number of threads to use
-m, --memory          Maximum memory used
-T, --temp            Location and prefix for temporary files 
                      required if using -p, otherwise defaults to output
-o, --output          File for sorted output
-p, --pipe            Write to standard output
    --umi             Sort by UMI, barcode, then ec
    --count           Sort by multiplicity, barcode, UMI, then ec
    --flags           Sort by flag, ec, barcode, then UMI
    --flags-bc        Sort by flag, barcode, UMI, then ec
    --no-flags        Ignore and reset the flag while sorting
```


## bustools_correct

### Tool Description
Correct barcodes in BUS files using an on-list

### Metadata
- **Docker Image**: quay.io/biocontainers/bustools:0.45.1--h6f0a7f7_0
- **Homepage**: https://github.com/BUStools/bustools
- **Package**: https://anaconda.org/channels/bioconda/packages/bustools/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: bustools correct [options] bus-files

Options: 
-o, --output          File for corrected bus output
-w, --onlist          File of on-list barcodes to correct to
-p, --pipe            Write to standard output
-d, --dump            Dump uncorrected to corrected barcodes (optional)
-r, --replace         The file of on-list barcodes is a barcode replacement file
    --nocorrect       Skip barcode error correction and only keep perfect matches to on-list
```


## bustools_umicorrect

### Tool Description
Correct UMIs in sorted BUS files

### Metadata
- **Docker Image**: quay.io/biocontainers/bustools:0.45.1--h6f0a7f7_0
- **Homepage**: https://github.com/BUStools/bustools
- **Package**: https://anaconda.org/channels/bioconda/packages/bustools/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: bustools umicorrect [options] sorted-bus-files

Options: 
-o, --output          Output directory gene matrix files
-p, --pipe            Write to standard output
-g, --genemap         File for mapping transcripts to genes
-e, --ecmap           File for mapping equivalence classes to transcripts
-t, --txnames         File with names of transcripts
```


## bustools_count

### Tool Description
Count gene matrix files from sorted BUS files

### Metadata
- **Docker Image**: quay.io/biocontainers/bustools:0.45.1--h6f0a7f7_0
- **Homepage**: https://github.com/BUStools/bustools
- **Package**: https://anaconda.org/channels/bioconda/packages/bustools/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: bustools count [options] sorted-bus-files

Options: 
-o, --output          Output directory gene matrix files
-g, --genemap         File for mapping transcripts to genes
-e, --ecmap           File for mapping equivalence classes to transcripts
-t, --txnames         File with names of transcripts
    --genecounts      Aggregate counts to genes only
    --umi-gene        Perform gene-level collapsing of UMIs
    --cm              Count multiplicities instead of UMIs
-s, --split           Split output matrix in two (plus ambiguous) based on transcripts supplied in this file
-m, --multimapping    Include bus records that pseudoalign to multiple genes
```


## bustools_inspect

### Tool Description
Inspects a sorted BUS file and provides statistics

### Metadata
- **Docker Image**: quay.io/biocontainers/bustools:0.45.1--h6f0a7f7_0
- **Homepage**: https://github.com/BUStools/bustools
- **Package**: https://anaconda.org/channels/bioconda/packages/bustools/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: bustools inspect [options] sorted-bus-file

Options: 
-o, --output          File for JSON output (optional)
-e, --ecmap           File for mapping equivalence classes to transcripts
-w, --onlist          File of on-list barcodes to correct to
-p, --pipe            Write to standard output
```


## bustools_allowlist

### Tool Description
Generates an allowlist (on-list) of barcodes from a sorted BUS file based on a frequency threshold.

### Metadata
- **Docker Image**: quay.io/biocontainers/bustools:0.45.1--h6f0a7f7_0
- **Homepage**: https://github.com/BUStools/bustools
- **Package**: https://anaconda.org/channels/bioconda/packages/bustools/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: bustools allowlist [options] sorted-bus-file

Options: 
-o, --output        File for the on-list
-f, --threshold     Minimum number of times a barcode must appear to be included in on-list
```


## bustools_capture

### Tool Description
Capture records from a BUS file based on a list of transcripts, UMIs, barcodes, or flags.

### Metadata
- **Docker Image**: quay.io/biocontainers/bustools:0.45.1--h6f0a7f7_0
- **Homepage**: https://github.com/BUStools/bustools
- **Package**: https://anaconda.org/channels/bioconda/packages/bustools/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: bustools capture [options] bus-files

Options: 
-o, --output          File for captured output 
-x, --complement      Take complement of captured set
-c, --capture         Capture list
-e, --ecmap           File for mapping equivalence classes to transcripts (for --transcripts)
-t, --txnames         File with names of transcripts (for --transcripts)
-p, --pipe            Write to standard output
Capture types: 
-F, --flags           Capture list is a list of flags to capture
-s, --transcripts     Capture list is a list of transcripts to capture
-u, --umis            Capture list is a list of UMIs to capture
-b, --barcode         Capture list is a list of barcodes to capture
```


## bustools_text

### Tool Description
Convert BUS files to text format

### Metadata
- **Docker Image**: quay.io/biocontainers/bustools:0.45.1--h6f0a7f7_0
- **Homepage**: https://github.com/BUStools/bustools
- **Package**: https://anaconda.org/channels/bioconda/packages/bustools/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: bustools text [options] bus-files

Options: 
-o, --output          File for text output
-f, --flags           Write the flag column
-d, --pad             Write the pad column
-p, --pipe            Write to standard output
-a, --showAll         Show hidden metadata in barcodes
```


## bustools_fromtext

### Tool Description
Convert text files to BUS format

### Metadata
- **Docker Image**: quay.io/biocontainers/bustools:0.45.1--h6f0a7f7_0
- **Homepage**: https://github.com/BUStools/bustools
- **Package**: https://anaconda.org/channels/bioconda/packages/bustools/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: bustools fromtext [options] text-files

Options: 
-o, --output          File for BUS output
-p, --pipe            Write to standard output
```


## bustools_extract

### Tool Description
Extract reads from FASTQ files based on a sorted BUS file. Note: BUS file should be sorted by flag using bustools sort --flag.

### Metadata
- **Docker Image**: quay.io/biocontainers/bustools:0.45.1--h6f0a7f7_0
- **Homepage**: https://github.com/BUStools/bustools
- **Package**: https://anaconda.org/channels/bioconda/packages/bustools/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: bustools extract [options] sorted-bus-file
  Note: BUS file should be sorted by flag using bustools sort --flag

Options: 
-o, --output          Output directory for FASTQ files
-f, --fastq           FASTQ file(s) from which to extract reads (comma-separated list)
-N, --nFastqs         Number of FASTQ file(s) per run
-x, --exclude         Exclude reads in the BUS file from the specified FASTQ file(s)
-i, --include         Include reads in the BUS file from the specified FASTQ file(s)
```


## bustools_compress

### Tool Description
Compress a BUS file, which should be sorted by barcode-umi-ec.

### Metadata
- **Docker Image**: quay.io/biocontainers/bustools:0.45.1--h6f0a7f7_0
- **Homepage**: https://github.com/BUStools/bustools
- **Package**: https://anaconda.org/channels/bioconda/packages/bustools/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: bustools compress [options] sorted-bus-file
Note: BUS file should be sorted by barcode-umi-ec

Options: 
-N, --chunk-size CHUNK_SIZE    Number of rows to compress as a single block.
-o, --output OUTPUT            Write compressed file to OUTPUT.
-p, --pipe                     Write to standard output.
-h, --help                     Print this message and exit.
```


## bustools_decompress

### Tool Description
Decompress or inflate a compressed BUS file

### Metadata
- **Docker Image**: quay.io/biocontainers/bustools:0.45.1--h6f0a7f7_0
- **Homepage**: https://github.com/BUStools/bustools
- **Package**: https://anaconda.org/channels/bioconda/packages/bustools/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: bustools {inflate | decompress} [options] compressed-bus-file

Options: 
-p, --pipe               Write to standard output.
-o, --output OUTPUT      File for inflated output.
-h, --help               Print this message and exit.
```


## bustools_cite

### Tool Description
Display citation information for bustools

### Metadata
- **Docker Image**: quay.io/biocontainers/bustools:0.45.1--h6f0a7f7_0
- **Homepage**: https://github.com/BUStools/bustools
- **Package**: https://anaconda.org/channels/bioconda/packages/bustools/overview
- **Validation**: PASS

### Original Help Text
```text
When using this program in your research, please cite

  Melsted, P., Booeshaghi, A. S., et al.
  Modular, efficient and constant-memory single-cell RNA-seq preprocessing, 
  Nature Biotechnology (2021), doi:10.1038/s41587-021-00870-2
```


## Metadata
- **Skill**: generated
