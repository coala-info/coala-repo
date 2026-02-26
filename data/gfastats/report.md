# gfastats CWL Generation Report

## gfastats

### Tool Description
Calculates statistics for FASTA, FASTQ, and GFA files.

### Metadata
- **Docker Image**: quay.io/biocontainers/gfastats:1.3.11--h077b44d_0
- **Homepage**: https://github.com/vgl-hub/gfastats
- **Package**: https://anaconda.org/channels/bioconda/packages/gfastats/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/gfastats/overview
- **Total Downloads**: 31.9K
- **Last updated**: 2025-05-09
- **GitHub**: https://github.com/vgl-hub/gfastats
- **Stars**: N/A
### Original Help Text
```text
gfastats input.[fasta|fastq|gfa][.gz] [expected genome size] [header[:start-end]]
genome size: estimated genome size for NG* statistics (optional).
header: target specific sequence by header, optionally with coordinates (optional).

Options:
	-a --agp-to-path <file> converts input agp to path and replaces existing paths.
	-b --out-coord a|s|c|g generates bed coordinates of given feature (agp|scaffolds|contigs|gaps default:agp).
	-e --exclude-bed <file> opposite of --include-bed. They can be combined (no coordinates).
	-f --input-sequence <file> input file (fasta, fastq, gfa [.gz]). Also as first positional argument.
	-h --help print help and exit.
	-i --include-bed <file> generates output on a subset list of headers or coordinates in 0-based bed format.
	-k --swiss-army-knife <file> set of instructions provided as an ordered list.
	-j --threads <n> numbers of threads (default: max).
	-o --out-format fasta|fastq|gfa[.gz] outputs selected sequences. If more than the extension is provided the output is written to the specified file (e.g. out.fasta.gz). Multiple file outputs can be given at once.
	-s --out-size s|c|g  generates size list of given feature (scaffolds|contigs|gaps default:scaffolds).
	-t --tabular output in tabular format.
	-v --version software version.

	--cmd print $0 to stdout.
	--remove-terminal-gaps removes leading/trailing Ns from scaffolds.
	--discover-paths prototype to induce paths from input.
	--discover-terminal-overlaps <n> append perfect terminal overlaps of minimum length n (default: 1000).
	--homopolymer-compress <n> compress all the homopolymers longer than n in the input.
	--line-length <n> specifies line length in when output format is fasta. Default has no line breaks.
	--nstar-report generates full N* and L* statistics.
	--no-sequence do not output the sequence (eg. in gfa).
	--out-sequence reports also the actual sequence (in combination with --seq-report).
	--out-bubbles outputs a potential list of bubbles in the graph.
	--segment-report report statistics for each segment/contig.
	--path-report report statistics for each path/scaffold.
	--sort ascending|descending|largest|smallest|file sort sequences according to input. Ascending/descending used the sequence/path header.
	--stats report summary statistics (default).
	--verbose verbose output.
	--locale set a different locale, for instance to use , for thousand separators use en_US.UTF-8.

All input files can be piped from stdin using '-'.
```

