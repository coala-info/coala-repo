---
name: readseq
description: "readseq converts biosequence data between various file formats while maintaining sequence integrity and metadata. Use when user asks to convert sequence files, translate between biosequence formats, or extract information from sequence data files."
homepage: http://iubio.bio.indiana.edu/soft/molbio/readseq/java/
---


# readseq

## Overview
readseq is a specialized Java-based command-line utility for the high-fidelity conversion of biosequence data. It eliminates the need for custom parsing scripts by providing a standardized interface to translate between dozens of sequence formats while maintaining sequence integrity and associated metadata where possible.

## Command Line Usage

The tool is typically invoked via the Java Runtime Environment. The primary syntax is:
`java -jar readseq.jar [options] input_file`

### Common Format Codes
When using the `-f` (format) flag, use the following numeric identifiers for common outputs:
- **1**: IG/Stanford
- **2**: GenBank
- **3**: NBRF
- **4**: EMBL
- **5**: GCG
- **8**: Pearson/FASTA
- **11**: DNAStrider
- **12**: PHYLIP
- **13**: GDE

### Essential Flags
- `-a`: Process all sequences in the input file (essential for multi-FASTA or multi-entry GenBank files).
- `-f[number]`: Specify the output format by index.
- `-o[filename]`: Direct the output to a specific file instead of standard output.
- `-p`: Pipe output (display to screen/stdout).
- `-i`: Display information about the input file without converting.

## Expert Tips and Best Practices

### Automatic Format Detection
readseq is highly effective at auto-detecting the input format. You generally do not need to specify the input type; focus only on defining the desired output format using the `-f` flag.

### Batch Processing
To convert a directory of files to FASTA format, use a loop structure to call readseq on each file, ensuring you use the `-a` flag to capture every sequence entry:
`for f in *.gb; do java -jar readseq.jar -a -f8 -o${f%.gb}.fasta $f; done`

### Handling Large Files
When dealing with very large genomic files, ensure the Java heap size is sufficient by prepending the memory flag to the command:
`java -Xmx2g -jar readseq.jar ...`

### Cleaning Sequences
Use readseq to "clean" sequences that contain non-standard characters or whitespace by converting them to a raw format and then back to a standard format like FASTA.

## Reference documentation
- [readseq - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_readseq_overview.md)