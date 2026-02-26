# lamassemble CWL Generation Report

## lamassemble

### Tool Description
Merge DNA sequences into a consensus sequence.

### Metadata
- **Docker Image**: quay.io/biocontainers/lamassemble:1.7.2--pyh7cba7a3_0
- **Homepage**: https://gitlab.com/mcfrith/lamassemble
- **Package**: https://anaconda.org/channels/bioconda/packages/lamassemble/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/lamassemble/overview
- **Total Downloads**: 16.2K
- **Last updated**: 2025-04-22
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
Usage: lamassemble [options] last-train.out sequences.fx > consensus.fa

Merge DNA sequences into a consensus sequence.

Options:
  -h, --help            show this help message and exit
  -a, --alignment       print an alignment, not a consensus
  -c, --consensus       just make a consensus, of already-aligned sequences
  -f FMT, --format=FMT  output format: fasta/fa or fastq/fq (default=fasta)
  -g G, --gap-max=G     use alignment columns with <= G% gaps (default=50)
  --end                 ... including gaps past the ends of the sequences
  -s S, --seq-min=S     omit consensus flanks with < S sequences (default=1)
  -n NAME, --name=NAME  name of the consensus sequence (default=lamassembled)
  -o BASE, --out=BASE   just write MAFFT input files, named BASE.xxx
  -p P, --prob=P        use pairwise restrictions with error probability <= P
                        (default=0.002)
  -d D, --diagonal-max=D
                        max change in alignment diagonal between pairwise
                        alignments (default=1000)
  -v, --verbose         show progress messages
  --all                 use all of each sequence, not just aligning part
  --mafft=ARGS          additional arguments for MAFFT

  LAST options:
    -P P                number of parallel threads (default=1)
    -u RY               use ~1 per this many initial matches
    -W W                use minimum positions in length-W windows (default=19)
    -m M                max initial matches per query position (default=5)
    -z Z                max gap length (default=30)
```

