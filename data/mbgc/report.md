# mbgc CWL Generation Report

## mbgc

### Tool Description
Multiple Bacteria Genome Compressor (MBGC)

### Metadata
- **Docker Image**: quay.io/biocontainers/mbgc:2.1.1--hd63eeec_0
- **Homepage**: https://github.com/kowallus/mbgc
- **Package**: https://anaconda.org/channels/bioconda/packages/mbgc/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/mbgc/overview
- **Total Downloads**: 8.9K
- **Last updated**: 2026-02-21
- **GitHub**: https://github.com/kowallus/mbgc
- **Stars**: N/A
### Original Help Text
```text
Multiple Bacteria Genome Compressor (MBGC) v2.1.1 (c) Tomasz Kowalski, Szymon Grabowski, 2026-02-20

Usage for partial file listing:
	mbgc i [-H] [-e <pattern>] [-E <patternsFile>] <archiveFile>

<archiveFile> mbgc archive filename
	for standard input in decompression, set <archiveFile> to -
<patternsFile> name of text file with list of patterns (in separate lines)
	excludes files not matching any pattern (does not invalidate -e option)

Basic options:
	[-e <pattern>] exclude files with names not containing pattern
	[-E <patternsFile>] exclude files not matching any pattern
	[-H] list sequence headers (using convention: ">sequencename>filename")
	[-t <noOfThreads>] set limit of used threads
	[-I] ignore FASTA file paths (use only filenames)
	[-2] redirect app output to stderr
	[-h] print full command help and exit
	[-v] print version number and exit

The order of all selected options is arbitrary.

Note: selected default command 'i'. Please use 'mbgc' to list all commands.
```

