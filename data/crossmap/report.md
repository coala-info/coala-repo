# crossmap CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| crossmap_bam | PASS |  |
| crossmap_bed | PASS |  |
| crossmap_bigwig | PASS |  |
| crossmap_gff | PASS |  |
| crossmap_gvcf | PASS |  |
| crossmap_maf | PASS |  |
| crossmap_region | PASS |  |
| crossmap_vcf | PASS |  |
| crossmap_viewchain | PASS |  |
| crossmap_wig | PASS |  |

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

## crossmap_bed

### Tool Description
CrossMap converts genome coordinates in BED, BED-like, or bigBed files between assemblies (e.g. lift over from human hg18 to hg19). The first 3 columns of the input must be chrom, start and end.

### Metadata
- **Docker Image**: quay.io/biocontainers/crossmap:0.7.3--pyhdfd78af_0
- **Homepage**: https://crossmap.sourceforge.net
- **Package**: https://anaconda.org/channels/bioconda/packages/crossmap/overview
- **Validation**: PASS
### Original Help Text
```text
usage: CrossMap bed [-h] [--chromid {a,s,l,n}] [--unmap-file UNMAP_FILE]
                    [--naive-bed-parsing]
                    input.chain input.bed [out_bed]

positional arguments:
  input.chain           Chain file
                        (https://genome.ucsc.edu/goldenPath/help/chain.html)
                        describes pairwise alignments between two genomes. The
                        input chain file can be a plain text file or
                        compressed (.gz, .Z, .z, .bz, .bz2, .bzip2) file.
  input.bed             The input BED file. The first 3 columns must be
                        “chrom”, “start”, and “end”. The input BED file can be
                        plain text file, compressed file with extension of
                        .gz, .Z, .z, .bz, .bz2 and .bzip2, or even a URL
                        pointing to accessible remote files (http://, https://
                        and ftp://). Compressed remote files are not
                        supported.
  out_bed               Output BED file. if argument is missing, CrossMap will
                        write BED file to the STDOUT.

options:
  -h, --help            show this help message and exit
  --chromid {a,s,l,n}   The style of the output chromosome IDs. "a" = "as-is",
                        "l" = "long style", "s" = "short style", and "n" =
                        "no-change". As-is: The chromosome ID of the target is
                        written to the output file in the same style of the
                        query chromosome ID. This is applied individually to
                        each query-ID/target-ID pair (as found in any given
                        input record). The output file may have mixed styles
                        if the input file has mixed styles. Long style: "chr"
                        appears at the beginning of the chromosome ID (e.g.,
                        "chr1", "chrX"); the "chr" will be prepended if
                        needed. Short style: "chr" does not appear at the
                        beginning of the chromosome ID (e.g., "1", "X"); any
                        "chr" prefix will be removed if needed. No-change: The
                        chromosome ID is left completely unchanged.
  --unmap-file UNMAP_FILE
                        file to save unmapped entries. This will be ignored if
                        [out_bed] was not provided.
  --naive-bed-parsing   Perform "naive" parsing on the input BED file. Focus
                        on the first 3 columns (chr, start, end) without
                        making assumptions about the expected format or
                        content of the other columns. This can serve as a
                        workaround to provide a BED file with a number of
                        columns matching the number of columns in a well-
                        defined format (e.g., BED12) without conforming to
                        that format's requirements. Note that for any given
                        entry, a column with "+" or "-" will still be searched
                        for in an attempt to determine the orientation.
```

## crossmap_bam

### Tool Description
CrossMap converts genome coordinates of alignments in BAM, CRAM or SAM format between assemblies. The input file type is detected from the suffix (.bam, .cram, .sam).

### Metadata
- **Docker Image**: quay.io/biocontainers/crossmap:0.7.3--pyhdfd78af_0
- **Homepage**: https://crossmap.sourceforge.net
- **Package**: https://anaconda.org/channels/bioconda/packages/crossmap/overview
- **Validation**: PASS
### Original Help Text
```text
usage: CrossMap bam [-h] [-m INSERT_SIZE] [-s INSERT_SIZE_STDEV]
                    [-t INSERT_SIZE_FOLD] [-a] [--chromid {a,s,l,n}]
                    input.chain input.bam [out_bam]

positional arguments:
  input.chain           Chain file
                        (https://genome.ucsc.edu/goldenPath/help/chain.html)
                        describes pairwise alignments between two genomes. The
                        input chain file can be a plain text file or
                        compressed (.gz, .Z, .z, .bz, .bz2, .bzip2) file.
  input.bam             Input BAM file (https://genome.ucsc.edu/FAQ/FAQformat.
                        html#format5.1).
  out_bam               Output BAM file. if argument is missing, CrossMap will
                        write BAM file to the STDOUT.

options:
  -h, --help            show this help message and exit
  -m INSERT_SIZE, --mean INSERT_SIZE
                        Average insert size of pair-end sequencing (bp).
  -s INSERT_SIZE_STDEV, --stdev INSERT_SIZE_STDEV
                        Stanadard deviation of insert size.
  -t INSERT_SIZE_FOLD, --times INSERT_SIZE_FOLD
                        A mapped pair is considered as "proper pair" if both
                        ends mapped to different strand and the distance
                        between them is less then '-t' * stdev from the mean.
  -a, --append-tags     Add tag to each alignment in BAM file. Tags for pair-
                        end alignments include: QF = QC failed, NN = both
                        read1 and read2 unmapped, NU = read1 unmapped, read2
                        unique mapped, NM = read1 unmapped, multiple mapped,
                        UN = read1 uniquely mapped, read2 unmap, UU = both
                        read1 and read2 uniquely mapped, UM = read1 uniquely
                        mapped, read2 multiple mapped, MN = read1 multiple
                        mapped, read2 unmapped, MU = read1 multiple mapped,
                        read2 unique mapped, MM = both read1 and read2
                        multiple mapped. Tags for single-end alignments
                        include: QF = QC failed, SN = unmaped, SM = multiple
                        mapped, SU = uniquely mapped.
  --chromid {a,s,l,n}   The style of the output chromosome IDs. "a" = "as-is",
                        "l" = "long style", "s" = "short style", and "n" =
                        "no-change". As-is: The chromosome ID of the target is
                        written to the output file in the same style of the
                        query chromosome ID. This is applied individually to
                        each query-ID/target-ID pair (as found in any given
                        input record). The output file may have mixed styles
                        if the input file has mixed styles. Long style: "chr"
                        appears at the beginning of the chromosome ID (e.g.,
                        "chr1", "chrX"); the "chr" will be prepended if
                        needed. Short style: "chr" does not appear at the
                        beginning of the chromosome ID (e.g., "1", "X"); any
                        "chr" prefix will be removed if needed. No-change: The
                        chromosome ID is left completely unchanged.
```

## crossmap_gff

### Tool Description
CrossMap converts genome coordinates in GFF or GTF format files between assemblies.

### Metadata
- **Docker Image**: quay.io/biocontainers/crossmap:0.7.3--pyhdfd78af_0
- **Homepage**: https://crossmap.sourceforge.net
- **Package**: https://anaconda.org/channels/bioconda/packages/crossmap/overview
- **Validation**: PASS
### Original Help Text
```text
usage: CrossMap gff [-h] [--chromid {a,s,l,n}] input.chain input.gff [out_gff]

positional arguments:
  input.chain          Chain file
                       (https://genome.ucsc.edu/goldenPath/help/chain.html)
                       describes pairwise alignments between two genomes. The
                       input chain file can be a plain text file or compressed
                       (.gz, .Z, .z, .bz, .bz2, .bzip2) file.
  input.gff            The input GFF (General Feature Format,
                       http://genome.ucsc.edu/FAQ/FAQformat.html#format3) or
                       GTF (Gene Transfer Format,
                       http://genome.ucsc.edu/FAQ/FAQformat.html#format4)
                       file. The input GFF/GTF file can be plain text file,
                       compressed file with extension of .gz, .Z, .z, .bz,
                       .bz2 and .bzip2, or even a URL pointing to accessible
                       remote files (http://, https:// and ftp://). Compressed
                       remote files are not supported.
  out_gff              Output GFF/GTF file. if argument is missing, CrossMap
                       will write GFF/GTF file to the STDOUT.

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
```

## crossmap_wig

### Tool Description
CrossMap converts genome coordinates in wiggle or bedGraph format files between assemblies. Both variableStep and fixedStep wiggle lines are supported. Regardless of the input, the output is written as bedGraph and bigWig.

### Metadata
- **Docker Image**: quay.io/biocontainers/crossmap:0.7.3--pyhdfd78af_0
- **Homepage**: https://crossmap.sourceforge.net
- **Package**: https://anaconda.org/channels/bioconda/packages/crossmap/overview
- **Validation**: PASS
### Original Help Text
```text
usage: CrossMap wig [-h] [--chromid {a,s,l,n}] input.chain input.wig out_wig

positional arguments:
  input.chain          Chain file
                       (https://genome.ucsc.edu/goldenPath/help/chain.html)
                       describes pairwise alignments between two genomes. The
                       input chain file can be a plain text file or compressed
                       (.gz, .Z, .z, .bz, .bz2, .bzip2) file.
  input.wig            The input wiggle/bedGraph format file
                       (http://genome.ucsc.edu/goldenPath/help/wiggle.html).
                       Both "variableStep" and "fixedStep" wiggle lines are
                       supported. The input wiggle/bedGraph file can be plain
                       text file, compressed file with extension of .gz, .Z,
                       .z, .bz, .bz2 and .bzip2, or even a URL pointing to
                       accessible remote files (http://, https:// and ftp://).
                       Compressed remote files are not supported.
  out_wig              Output bedGraph file. Regardless of the input is wiggle
                       or bedGraph, the output file is always in bedGraph
                       format.

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
```

## crossmap_bigwig

### Tool Description
CrossMap converts genome coordinates in bigWig format files between assemblies. The output is written as bigWig and as sorted bedGraph.

### Metadata
- **Docker Image**: quay.io/biocontainers/crossmap:0.7.3--pyhdfd78af_0
- **Homepage**: https://crossmap.sourceforge.net
- **Package**: https://anaconda.org/channels/bioconda/packages/crossmap/overview
- **Validation**: PASS
### Original Help Text
```text
usage: CrossMap bigwig [-h] [--chromid {a,s,l,n}]
                       input.chain input.bw output.bw

positional arguments:
  input.chain          Chain file
                       (https://genome.ucsc.edu/goldenPath/help/chain.html)
                       describes pairwise alignments between two genomes. The
                       input chain file can be a plain text file or compressed
                       (.gz, .Z, .z, .bz, .bz2, .bzip2) file.
  input.bw             The input bigWig format file
                       (https://genome.ucsc.edu/goldenPath/help/bigWig.html).
  output.bw            Output bigWig file.

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
```

## crossmap_gvcf

### Tool Description
CrossMap converts genome coordinates in gVCF (genomic variant call format) files between assemblies.

### Metadata
- **Docker Image**: quay.io/biocontainers/crossmap:0.7.3--pyhdfd78af_0
- **Homepage**: https://crossmap.sourceforge.net
- **Package**: https://anaconda.org/channels/bioconda/packages/crossmap/overview
- **Validation**: PASS
### Original Help Text
```text
usage: CrossMap gvcf [-h] [--chromid {a,s,l,n}] [--ref-consistent]
                     [--no-comp-alleles] [--compress]
                     input.chain input.gvcf refgenome.fa out_gvcf

positional arguments:
  input.chain          Chain file
                       (https://genome.ucsc.edu/goldenPath/help/chain.html)
                       describes pairwise alignments between two genomes. The
                       input chain file can be a plain text file or compressed
                       (.gz, .Z, .z, .bz, .bz2, .bzip2) file.
  input.gvcf           Input gVCF (genomic variant call format,
                       https://samtools.github.io/hts-specs/VCFv4.2.pdf). The
                       gVCF file can be plain text file, compressed file with
                       extension of .gz, .Z, .z, .bz, .bz2 and .bzip2, or even
                       a URL pointing to accessible remote files (http://,
                       https:// and ftp://). Compressed remote files are not
                       supported.
  refgenome.fa         Chromosome sequences of target assembly in FASTA
                       (https://en.wikipedia.org/wiki/FASTA_format) format.
  out_gvcf             Output gVCF file.

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

## crossmap_maf

### Tool Description
CrossMap converts genome coordinates in MAF (mutation annotation format) files between assemblies.

### Metadata
- **Docker Image**: quay.io/biocontainers/crossmap:0.7.3--pyhdfd78af_0
- **Homepage**: https://crossmap.sourceforge.net
- **Package**: https://anaconda.org/channels/bioconda/packages/crossmap/overview
- **Validation**: PASS
### Original Help Text
```text
usage: CrossMap maf [-h] [--chromid {a,s,l,n}]
                    input.chain input.maf refgenome.fa build_name out_maf

positional arguments:
  input.chain          Chain file
                       (https://genome.ucsc.edu/goldenPath/help/chain.html)
                       describes pairwise alignments between two genomes. The
                       input chain file can be a plain text file or compressed
                       (.gz, .Z, .z, .bz, .bz2, .bzip2) file.
  input.maf            Input MAF (https://docs.gdc.cancer.gov/Data/File_Format
                       s/MAF_Format/) format file. The MAF file can be plain
                       text file, compressed file with extension of .gz, .Z,
                       .z, .bz, .bz2 and .bzip2, or even a URL pointing to
                       accessible remote files (http://, https:// and ftp://).
                       Compressed remote files are not supported.
  refgenome.fa         Chromosome sequences of target assembly in FASTA
                       (https://en.wikipedia.org/wiki/FASTA_format) format.
  build_name           the name of the *target_assembly* (eg "GRCh38").
  out_maf              Output MAF file.

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
```

## crossmap_region

### Tool Description
CrossMap converts genome regions in BED format between assemblies. A region is lifted over as a whole; it is reported only when the ratio of bases that remap is at least the minimum ratio.

### Metadata
- **Docker Image**: quay.io/biocontainers/crossmap:0.7.3--pyhdfd78af_0
- **Homepage**: https://crossmap.sourceforge.net
- **Package**: https://anaconda.org/channels/bioconda/packages/crossmap/overview
- **Validation**: PASS
### Original Help Text
```text
usage: CrossMap region [-h] [--chromid {a,s,l,n}] [-r MIN_MAP_RATIO]
                       input.chain input.bed [out_bed]

positional arguments:
  input.chain           Chain file
                        (https://genome.ucsc.edu/goldenPath/help/chain.html)
                        describes pairwise alignments between two genomes. The
                        input chain file can be a plain text file or
                        compressed (.gz, .Z, .z, .bz, .bz2, .bzip2) file.
  input.bed             The input BED file. The first 3 columns must be
                        “chrom”, “start”, and “end”. The input BED file can be
                        plain text file, compressed file with extension of
                        .gz, .Z, .z, .bz, .bz2 and .bzip2, or even a URL
                        pointing to accessible remote files (http://, https://
                        and ftp://). Compressed remote files are not
                        supported.
  out_bed               Output BED file. if argument is missing, CrossMap will
                        write BED file to the STDOUT.

options:
  -h, --help            show this help message and exit
  --chromid {a,s,l,n}   The style of the output chromosome IDs. "a" = "as-is",
                        "l" = "long style", "s" = "short style", and "n" =
                        "no-change". As-is: The chromosome ID of the target is
                        written to the output file in the same style of the
                        query chromosome ID. This is applied individually to
                        each query-ID/target-ID pair (as found in any given
                        input record). The output file may have mixed styles
                        if the input file has mixed styles. Long style: "chr"
                        appears at the beginning of the chromosome ID (e.g.,
                        "chr1", "chrX"); the "chr" will be prepended if
                        needed. Short style: "chr" does not appear at the
                        beginning of the chromosome ID (e.g., "1", "X"); any
                        "chr" prefix will be removed if needed. No-change: The
                        chromosome ID is left completely unchanged.
  -r MIN_MAP_RATIO, --ratio MIN_MAP_RATIO
                        Minimum ratio of bases that must remap.
```

## crossmap_viewchain

### Tool Description
CrossMap viewchain prints the chain file as a block-to-block table: the source chromosome, start, end and strand, and the target chromosome, start, end and strand of each aligned block.

### Metadata
- **Docker Image**: quay.io/biocontainers/crossmap:0.7.3--pyhdfd78af_0
- **Homepage**: https://crossmap.sourceforge.net
- **Package**: https://anaconda.org/channels/bioconda/packages/crossmap/overview
- **Validation**: PASS
### Original Help Text
```text
usage: CrossMap viewchain [-h] input.chain

positional arguments:
  input.chain  Chain file (https://genome.ucsc.edu/goldenPath/help/chain.html)
               describes pairwise alignments between two genomes. The input
               chain file can be a plain text file or compressed (.gz, .Z, .z,
               .bz, .bz2, .bzip2) file.

options:
  -h, --help   show this help message and exit
```

