# minimap2-coverage CWL Generation Report

## minimap2-coverage

### Tool Description
minimap2-coverage is a forked minimap2 program focusing on coverage, and tuned for LongQC.

### Metadata
- **Docker Image**: quay.io/biocontainers/minimap2-coverage:1.2.0c--h577a1d6_4
- **Homepage**: https://github.com/yfukasawa/LongQC
- **Package**: https://anaconda.org/channels/bioconda/packages/minimap2-coverage/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/minimap2-coverage/overview
- **Total Downloads**: 5.2K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/yfukasawa/LongQC
- **Stars**: N/A
### Original Help Text
```text
Usage: minimap2-coverage [OPTION...] reference reads
minimap2-coverage is a forked minimap2 program focusing on coverage, and tuned
for LongQC.

 Indexing options:
  -d, --dump-index=FILE      dump index to FILE
  -H, --homopolymer          use homopolymer-compressed k-mer
  -I, --index-size=STRING    split index for every ~NUM input bases
  -k, --k-mer=INT            k-mer size (no larger than 28)
  -w, --window=INT           minizer window size

 Mapping options
  -g, --max-gap-length=INT   stop chain enlongation if there are no minimizers
                             in INT-bp
  -m, --min-score=INT        minimal chaining score (matching bases minus log
                             gap penalty)
  -n, --min-cnt=INT          minimal number of minimizers on a chain
  -p, --min-score-t2=INT     chaining score to filter bad reads and must be >=
                             min-score
  -q, --min-score-t3=INT     chaining score to filter bad and some spurious
                             reads/overlap and must be >= min-score-t2
  -X, --skip-self-ava        skip self and dual mappings (for the all-vs-all
                             mode)
  -Y, --skip-self            skip self mappings (for the all-vs-subfraction
                             mode)

 Filtering options
  -a, --max-overhang=INT     stop chain enlongation if there are no minimizers
                             in INT-bp
  -c, --min-coverage=INT     minimal chaining score (matching bases minus log
                             gap penalty)
  -l, --min-overlap-len=INT  minimal number of minimizers on a chain
  -r, --min-overlap-ratio=NUM   minimum coverage ratio. overlap length is
                             compared with overhang length.

 Misc options
  -f, --filter               read filtering mode. Can be used to filter out
                             known contaminants (e.g. spiked-in control
                             reads).
  -t, --threads=INT          number of threads
  -u, --num-subset=INT       number of sequences for query subset
  -z, --minimizer-cnt        count minimizer apperance for all queries

  -?, --help                 Give this help list
      --usage                Give a short usage message
  -V, --version              Print program version

Mandatory or optional arguments to long options are also mandatory or optional
for any corresponding short options.

 

Report bugs to <yoshinori.fukasawa@kaust.edu.sa>.
```

