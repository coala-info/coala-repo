# dinamo CWL Generation Report

## dinamo

### Tool Description
Finds motifs in sequences.

### Metadata
- **Docker Image**: quay.io/biocontainers/dinamo:1.0--h9948957_8
- **Homepage**: https://github.com/bonsai-team/DiNAMO/
- **Package**: https://anaconda.org/channels/bioconda/packages/dinamo/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/dinamo/overview
- **Total Downloads**: 10.3K
- **Last updated**: 2025-08-06
- **GitHub**: https://github.com/bonsai-team/DiNAMO
- **Stars**: N/A
### Original Help Text
```text
Usage :
dinamo (-pf|--positive-file) path/to/positive (-nf|--negative-file) path/to/negative (-l|--motif-length) k
Available options :
	(-d|--degeneration-level) k         : Limits the degeneration to at most k positions
	(-o|--output-file) path/to/output   : Output the meme file to the desired path (has no effect when -p option is used)
	(-p|--position) k                   : Only process motif that end at position k in the sequence.
		(Important note : position 0 corresponds to the last motif of each sequence)
	--norc                              : When -p is not used, prevents dinamo to link motif to their reverse complement
		(Please be warned : not linking the motif to their reverse complement usually doubles memory usage)
	(-t|--threshold) r                  : Sets the pvalue threshold to r (0 <= r <= 1)
	(-h|--help)                         : Displays this help
	--no-log                            : Prevents the log ouput from being displayed
```

