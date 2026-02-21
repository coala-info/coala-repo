# pileuppy CWL Generation Report

## pileuppy

### Tool Description
Pileups reads in a specified region.

### Metadata
- **Docker Image**: quay.io/biocontainers/pileuppy:1.2.0--pyhdfd78af_0
- **Homepage**: https://gitlab.com/tprodanov/pileuppy
- **Package**: https://anaconda.org/channels/bioconda/packages/pileuppy/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/pileuppy/overview
- **Total Downloads**: 12.4K
- **Last updated**: 2025-04-22
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
usage: pileuppy in1.bam [in2.bam ...] [-f ref.fa] -r chrom:start-end [-o out.pileup] [options]

Pileups reads in a specified region.

Input/output arguments:
  FILE                  Required: Input indexed BAM/CRAM files. Allows format name=path,
                        in that case name will be displayed in pileup instead of filename.
  -f FILE, --fasta-ref FILE
                        Optional: Input reference indexed FASTA file.
  -o FILE, --output FILE
                        Optional: Output file [stdout]. Disables colors.

Region arguments:
  -r STR, --region STR  Required: pileup region in one of the following formats:
                          chrom:pos - pileup of a single position,
                          chrom:start-end - closed interval, 1-based positions,
                          chrom:pos^size - same as chrom:[pos - size]-[pos + size].
  -d INT, --display INT
                        Display additional INT positions around the region.
                        Only displays reads that cover <region>.
  --size INT|none       Split region longer than INT [150].

Filering arguments:
  -q INT, --min-mapq INT
                        Skip alignments with mapQ less than INT [0].
  -Q INT, --min-bq INT  Print ? instead of base pairs with quality less than INT [0].
  --rf INT, --req-flags INT
                        Required flags: skip reads with mask bits unset [0].
  --ff INT, --filt-flags INT
                        Filter flags: skip reads with mask bits set [1796].

Samples arguments:
  -s [STR ...], --samples [STR ...]
                        Only use reads with matching samples. You can use multiple regex patterns
                        or exact sample names. Pattern must match the sample name from start to end.
  --join-samples        Do not split single BAM/CRAM file into multiple columns with different samples.

Format arguments:
  -B, --skip-bq         Do not print base qualities.
  -n, --show-names      Print read names in the header.
  --header skip|comment|plain
                        How to write headers. If comment, every header line will start with "#".
  --skip-legend         Do not write legend.
  -e, --skip-empty      Skip lines with zero coverage
  --skip-chrom          Do not show chromosome name

Coloring arguments:
  -S none|ansi|white|black, --scheme none|ansi|white|black
                        Possible color schemes:
                            none - no colors (default if -o FILE),
                            ansi - 16 colors,
                            white - 256 colors with white background,
                            black - 256 colors with black background (default unless -o FILE).
  --no-logo             Do not use logo colors for nucleotides.
  -C, --no-columns      Do not highlight columns with a different color.

Other arguments:
  -h, --help            Show this message and exit.
  -V, --version         Show version and exit.
```


## Metadata
- **Skill**: generated
