# tandem-genotypes CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| tandem-genotypes | PASS |  |
| tandem-genotypes_tandem-genotypes-join | PASS |  |
| tandem-genotypes_tandem-genotypes-merge | Not completed | needs the original reads and a last-train alignment-parameter file that the test data does not include |
| tandem-genotypes_tandem-genotypes-plot | Failed | tool bug: the plot script starts R but does not wait for it, so the container exits before the PDF is written |

## tandem-genotypes

### Tool Description
Try to indicate genotypes of tandem repeats.

### Metadata
- **Docker Image**: quay.io/biocontainers/tandem-genotypes:1.9.2--pyh7e72e81_0
- **Homepage**: https://github.com/mcfrith/tandem-genotypes
- **Package**: https://anaconda.org/channels/bioconda/packages/tandem-genotypes/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/tandem-genotypes/overview
- **Total Downloads**: 33.4K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/mcfrith/tandem-genotypes
- **Stars**: N/A
### Original Help Text
```text
Usage: tandem-genotypes [options] microsat.txt alignments.maf

Try to indicate genotypes of tandem repeats.

Options:
  -h, --help            show this help message and exit
  -g FILE, --genes=FILE
                        read genes from a genePred or BED file
  -o NUM, --output=NUM  output format: 1=original, 2=alleles (default=1)
  -m PROB, --mismap=PROB
                        ignore any alignment with mismap probability > PROB
                        (default=1e-06)
  --postmask=NUMBER     ignore mostly-lowercase alignments (default=1)
  -p BP, --promoter=BP  promoter length (default=300)
  -s N, --select=N      select: all repeats (0), non-intergenic repeats (1),
                        non-intergenic non-intronic repeats (2) (default=0)
  -u BP, --min-unit=BP  ignore repeats with unit shorter than BP (default=2)
  -f BP, --far=BP       require alignment >= BP beyond both sides of a repeat
                        (default=100)
  -n BP, --near=BP      count insertions <= BP beyond a repeat (default=60)
  --mode=LETTER         L=lenient, S=strict (default=L)
  --scores=FILE         importance scores for gene parts
  -v, --verbose         show more details
```

## tandem-genotypes_tandem-genotypes-join

### Tool Description
Join and re-rank outputs of tandem-genotypes.

### Metadata
- **Docker Image**: quay.io/biocontainers/tandem-genotypes:1.9.2--pyh7e72e81_0
- **Homepage**: https://github.com/mcfrith/tandem-genotypes
- **Package**: https://anaconda.org/channels/bioconda/packages/tandem-genotypes/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: tandem-genotypes-join positive-file(s) [: negative-file(s)]

Join and re-rank outputs of tandem-genotypes.

Options:
  -h, --help          show this help message and exit
  -c N, --change=N    get importance from: most-changed non-outlier read (0),
                      most-changed allele (1), least-changed allele (2)
                      (default=0)
  -s, --shrink        shrink the output
  -m NUM, --mean=NUM  type of mean for positive/patient/case files:
                      1=ordinary, 3=cubic (default=1)
  --scores=FILE       importance scores for gene parts
  -v, --verbose       show more details
```

## tandem-genotypes_tandem-genotypes-plot

### Tool Description
Draw graphs of tandem-genotypes output.

### Metadata
- **Docker Image**: quay.io/biocontainers/tandem-genotypes:1.9.2--pyh7e72e81_0
- **Homepage**: https://github.com/mcfrith/tandem-genotypes
- **Package**: https://anaconda.org/channels/bioconda/packages/tandem-genotypes/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: tandem-genotypes-plot tandem-genotypes.txt [output.pdf]

Draw graphs of tandem-genotypes output.

Options:
  -h, --help            show this help message and exit
  -r ROWS, --rows=ROWS  arrange the graphs in this many rows (default=4)
  -c COLS, --cols=COLS  arrange the graphs in this many columns (default=4)
  -n NUM, --num=NUM     graph the top NUM repeat regions (default=ROWS*COLS)
  -s SAMPLE, --sample=SAMPLE
                        select SAMPLE-th sample to plot (default=1)
  --pointsize=POINTS    text size (default=8)
  --reads=FILE          show expected coverage for FASTA or FASTQ reads
  -v, --verbose         show more details
```

## tandem-genotypes_tandem-genotypes-merge

### Tool Description
Merge the DNA reads of each tandem-repeat allele into a consensus sequence.

### Metadata
- **Docker Image**: quay.io/biocontainers/tandem-genotypes:1.9.2--pyh7e72e81_0
- **Homepage**: https://github.com/mcfrith/tandem-genotypes
- **Package**: https://anaconda.org/channels/bioconda/packages/tandem-genotypes/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: tandem-genotypes-merge [opts] seqs.fx last-train.out tan-gen.txt > out.fa
   or: tandem-genotypes-merge seqs.fx tan-gen.txt > unmerged-sequences.fx

Merge the DNA reads of each tandem-repeat allele into a consensus sequence.

Options:
  -h, --help         show this help message and exit
  -n NUM, --num=NUM  get the top NUM repeats (default=16)
  -g G, --gap-max=G  use alignment columns with <= G% gaps (default=50)
  --end              ... including gaps past the ends of the sequences
  -s S, --seq-min=S  omit consensus flanks with < S sequences (default=1)
  -p P, --prob=P     use pairwise restrictions with error probability <= P
                     (default=0.002)
  -v, --verbose      show progress messages

  LAST options:
    -P P             number of parallel threads (default=1)
    -W W             use minimum positions in length-W windows (default=19)
    -m M             max initial matches per query position (default=5)
    -z Z             max gap length (default=30)
```

