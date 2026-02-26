# samcut CWL Generation Report

## samcut

### Tool Description
Print the standard 11 columns (qname, flag, ..., qual) with a header row

### Metadata
- **Docker Image**: quay.io/biocontainers/samcut:0.1.1--h9948957_3
- **Homepage**: https://github.com/gshiba/samcut
- **Package**: https://anaconda.org/channels/bioconda/packages/samcut/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/samcut/overview
- **Total Downloads**: 3.7K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/gshiba/samcut
- **Stars**: N/A
### Original Help Text
```text
samcut is cut for sam: `samtools view in.bam | samcut`. See --help for examples.

Print the standard 11 columns (qname, flag, ..., qual) with a header row:
    $ samtools view in.bam | samcut -H

Print qname, cigar, pos, and tlen only:
    $ samtools view in.bam | samcut qname cigar pos tlen

Also print a specific tag:
    $ samtools view in.bam | samcut qname cigar pos tlen MD

Separate flag into columns for each bit:
    $ samtools view in.bam | samcut -H qname flagss flags

Get a histogram of (read1, secondary, supplementary) flag values:
    $ samtools view in.bam | samcut read1 secondary supplementary | sort | uniq -c

Usage: samcut [OPTIONS] [FIELDS]...

Arguments:
  [FIELDS]...
          Select only these fields. Example: `samcut n qname tlen read1 MD`. See --help for details.
          If not supplied, `std` is used.
          
          Standard keys:
              key              description
              ----------------------------------------------------------------------------
              qname            query template name
              flag             bitwise flag
              rname            reference sequence name
              pos              1-based leftmost mapping position
              mapq             mapping quality
              cigar            cigar string
              rnext            ref. name of the mate/next read
              pnext            position of the mat/next read
              tlen             observed template length
              seq              segment sequence
              qual             ascii of phred-scaled base quality+33
          
          Flag keys:
              key              description
              ----------------------------------------------------------------------------
              paired           paired-end (or multiple-segment) sequencing technology
              proper_pair      each segment properly aligned according to the aligner
              unmap            segment unmapped
              munmap           next segment in the template unmapped
              reverse          SEQ is reverse complemented
              mreverse         SEQ of the next segment in the template is reversed
              read1            the first segment in the template
              read2            the last segment in the template
              secondary        secondary alignment
              qcfail           not passing quality controls
              dup              PCR or optical duplicate
              supplementary    supplementary alignment
          
          Speical keys:
              key              description
              ----------------------------------------------------------------------------
              n                One-based index for the input stream
              std              Expands to the standard 11 columns (qname, flag, ..., qual)
              flags            Humarn readable flag ("paired,proper_pair,mreverse,read1")
              flagss           Expands to the 12 flag names (from `samtool flags`)

Options:
  -H, --header
          Print a header row with column names

  -d, --delim <DELIM>
          Character to use as delimiter for output
          
          [default: "\t"]

  -i, --fill <FILL>
          String to fill missing values with (tags are optional and can be missing)
          
          [default: .]

  -h, --help
          Print help (see a summary with '-h')

  -V, --version
          Print version
```

