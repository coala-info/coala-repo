# rdeval CWL Generation Report

## rdeval

### Tool Description
Evaluates sequencing reads.

### Metadata
- **Docker Image**: quay.io/biocontainers/rdeval:0.0.8--r44h35c04b2_1
- **Homepage**: https://github.com/vgl-hub/rdeval
- **Package**: https://anaconda.org/channels/bioconda/packages/rdeval/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/rdeval/overview
- **Total Downloads**: 4.8K
- **Last updated**: 2025-12-21
- **GitHub**: https://github.com/vgl-hub/rdeval
- **Stars**: N/A
### Original Help Text
```text
rdeval input.fa*[.gz]|bam|cram|rd [expected genome size as uint]
Options:
	--sequence-report generates a per-read report
	-e --exclude-list <file> generates output on a excluding list of headers.
	-f --filter <exp> filter reads using <exp> in quotes, e.g. 'l>10' for longer than 10bp or 'l>10 & q>10' to further exclude reads by quality (default: none).
	-i --include-list <file> generates output on a subset list of headers.
	-o --out-file <file> output file (fa*[.gz], bam, cram, rd). Optionally write reads to file or generate rd summary file.
	-p --out-prefix <prefix> a prefix for the names of the files when generating multiple outputs. Inputs names will be used for each file.
	-q --quality q|a generates list of average quality for each read (q) or both length and quality (a).
	-r --input-reads <file1> <file2> <file n> input file (fa*[.gz], bam, cram, rd).
	-s --out-size u|s|h|c  generates size list (unsorted|sorted|histogram|inverse cumulative table).
	--homopolymer-compress <int> compress all the homopolymers longer than n in the input.
	--sample <float> fraction of reads to subsample.
	--random-seed <int> an optional random seed to make subsampling reproducible.
	--cifi-enzyme <string> the specific enzyme to use for SciFi read digestion.
	--cifi-out-combinations output all per-read combinations of SciFi fragments (default: no).
	--md5 print md5 of .rd files.
	--parallel-files <int> numbers of files that can be opened and processed in parallel (producer threads, default:4).
	--decompression-threads <int> numbers of decompression threads used by htslib for bam/cram (default:4).
	--compression-threads <int> numbers of compression threads used by htslib for bam/cram (default:6).
	--tabular tabular output.
	--verbose verbose output.
	-m --max-memory <int> max number of bases in a single buffer of the ring buffer (default:1000000 bp or ~1MB). The total number of buffers is approximately consumer threads*2.
	-j --threads <int> numbers of consumer threads (default:8).
	-v --version software version.
	--cmd print $0 to stdout.
```

