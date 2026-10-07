# crossmap CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| crossmap_vcf | PASS |  |

## crossmap_vcf

### Tool Description
CrossMap is a program for convenient conversion of genome coordinates and genome annotation files between assemblies (e.g. lift over from human hg18 to hg19 or vice versa). It supports VCF format.

### Metadata
- **Docker Image**: quay.io/biocontainers/crossmap:0.7.3--pyhdfd78af_0
- **Homepage**: https://crossmap.sourceforge.net
- **Package**: https://anaconda.org/channels/bioconda/packages/crossmap/overview
- **Validation**: PASS

### Original Help Text
```text
usage: CrossMap vcf [-h] [--chromid {a,s,l,n}] [--ref-consistent]
                    [--no-comp-alleles] [--compress]
                    input.chain input.vcf refgenome.fa out_vcf

positional arguments:
  input.chain          Chain file
                       (https://genome.ucsc.edu/goldenPath/help/chain.html)
                       describes pairwise alignments between two genomes. The
                       input chain file can be a plain text file or compressed
                       (.gz, .Z, .z, .bz, .bz2, .bzip2) file.
  input.vcf            Input VCF (variant call format,
                       https://samtools.github.io/hts-specs/VCFv4.2.pdf). The
                       VCF file can be plain text file, compressed file with
                       extension of .gz, .Z, .z, .bz, .bz2 and .bzip2, or even
                       a URL pointing to accessible remote files (http://,
                       https:// and ftp://). Compressed remote files are not
                       supported.
  refgenome.fa         Chromosome sequences of target assembly in FASTA
                       (https://en.wikipedia.org/wiki/FASTA_format) format.
  out_vcf              Output VCF file.

options:
  -h, --help           show this help message and exit
  --chromid {a,s,l,n}  The style of the output chromosome IDs. "a" = "as-is",
                       "l" = "long style", "s" = "short style", and "n" = "no-
                       change". As-is: The chromosome ID of the target is
                       written to the output file in the same style of the
                       query chromosome ID. This is applied individually to
                       each query-ID/target-ID pair (as found in any given
                       input record). The output file may have mixed styles if
                       the input file has mixed styles. Long style: "chr"
                       appears at the beginning of the chromosome ID (e.g.,
                       "chr1", "chrX"); the "chr" will be prepended if needed.
                       Short style: "chr" does not appear at the beginning of
                       the chromosome ID (e.g., "1", "X"); any "chr" prefix
                       will be removed if needed. No-change: The chromosome ID
                       is left completely unchanged.
  --ref-consistent     If set, CrossMap will check if reference allele is
                       consistent during liftover.
  --no-comp-alleles    If set, CrossMap does NOT check if the reference allele
                       is different from the alternate allele.
  --compress           If set, compress the output VCF file by calling the
                       system "gzip".
```

