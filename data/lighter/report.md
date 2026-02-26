# lighter CWL Generation Report

## lighter

### Tool Description
OPTIONS:

### Metadata
- **Docker Image**: quay.io/biocontainers/lighter:1.1.3--h077b44d_2
- **Homepage**: https://github.com/mourisl/Lighter
- **Package**: https://anaconda.org/channels/bioconda/packages/lighter/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/lighter/overview
- **Total Downloads**: 38.6K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/mourisl/Lighter
- **Stars**: N/A
### Original Help Text
```text
Usage: ./lighter [OPTIONS]
OPTIONS:
Required parameters:
	-r seq_file: seq_file is the path to the sequence file. Can use multiple -r to specifiy multiple sequence files
	             The file can be fasta and fastq, and can be gzip'ed with extension *.gz.
	             When the input file is *.gz, the corresponding output file will also be gzip'ed.
	-k kmer_length genome_size alpha: (see README for information on setting alpha)
					or
	-K kmer_length genom_size: in this case, the genome size should be relative accurate.
Other parameters:
	-od output_file_directory: (default: ./)
	-t num_of_threads: number of threads to use (default: 1)
	-maxcor INT: the maximum number of corrections within a 20bp window (default: 4)
	-trim: allow trimming (default: false)
	-discard: discard unfixable reads. Will LOSE paired-end matching when discarding (default: false)
	-noQual: ignore the quality socre (default: false)
	-newQual ascii_quality_score: set the quality for the bases corrected to the specified score (default: not used)
	-saveTrustedKmers file: save the trusted kmers to specified file then stop (default: not used)
	-loadTrustedKmers file: directly get solid kmers from specified file (default: not used)
	-zlib compress_level: set the compression level(0-9) of gzip (default: 1)
	-h: print the help message and quit
	-v: print the version information and quit
```

