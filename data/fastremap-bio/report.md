# fastremap-bio CWL Generation Report

## fastremap-bio_FastRemap

### Tool Description
A Tool for Quickly Remapping Reads between Genome Assemblies

### Metadata
- **Docker Image**: quay.io/biocontainers/fastremap-bio:1.0.0--h077b44d_2
- **Homepage**: https://github.com/CMU-SAFARI/FastRemap
- **Package**: https://anaconda.org/channels/bioconda/packages/fastremap-bio/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/fastremap-bio/overview
- **Total Downloads**: 2.6K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/CMU-SAFARI/FastRemap
- **Stars**: N/A
### Original Help Text
```text
FastRemap: A Tool for Quickly Remapping Reads between Genome Assemblies
=======================================================================

SYNOPSIS

DESCRIPTION

OPTIONS
    -h, --help
          Display the help message.
    --version
          Display version information.
    -f, --file-type STRING
          'bam', 'sam', or 'bed' file depending on input file One of bam, sam,
          and bed.
    -c, --chain-file INPUT_FILE
          A chain file (https://genome.ucsc.edu/goldenPath/help/chain.html)
          that describes regions of similarity between references.
    -i, --input INPUT_FILE
          {s,b}am or bed file containing elements to be remapped based on
          chain file
    -o, --output OUTPUT_FILE
          File containing all the remapped elements from the input file
    -u, --output-unmapped OUTPUT_FILE
          File containing all the elements that could not be remapped from the
          input file based on the provided chain file
    -a, --append-tags
          Add tag to each alignment in BAM file. Tags for pair-end alignments
          include: QF = QC failed, NN = both read1 and read2 unmapped, NU =
          read1 unmapped, read2 unique mapped, NM = read1 unmapped, multiple
          mapped, UN = read1 uniquely mapped, read2 unmap, UU = both read1 and
          read2 uniquely mapped, UM = read1 uniquely mapped, read2 multiple
          mapped, MN = read1 multiple mapped, read2 unmapped, MU = read1
          multiple mapped, read2 unique mapped, MM = both read1 and read2
          multiple mapped. Tags for single-end alignments include: QF = QC
          failed, SN = unmaped, SM = multiple mapped, SU = uniquely mapped.
    -m, --mean INTEGER
          Average insert size of pair-end sequencing (bp). In range [0..inf].
          Default: 200.
    -s, --stdev INTEGER
          Stanadard deviation of insert size. In range [0..inf]. Default: 30.
    -t, --times INTEGER
          A mapped pair is considered as proper pair if both ends mapped to
          different strand and the distance between them is less then '-t' *
          stdev from the mean. In range [0..inf]. Default: 3.

VERSION
    Last update: May 2022
    FastRemap: A Tool for Quickly Remapping Reads between Genome Assemblies version: 1.0
    SeqAn version: 2.4.0
```

