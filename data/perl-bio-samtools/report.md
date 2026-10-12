# perl-bio-samtools CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| perl-bio-samtools_bam2bedgraph | PASS |  |
| perl-bio-samtools_bamToGBrowse.pl | Failed | image problem: Bio::DB::BigFile is missing (createBigWig not found) and bedGraphToBigWig is not installed, so the BigWig step crashes |
| perl-bio-samtools_chrom_sizes.pl | PASS |  |
| perl-bio-samtools_genomeCoverageBed.pl | PASS |  |

## perl-bio-samtools_bam2bedgraph

### Tool Description
Create a BEDGraph file of genomic coverage from a sorted BAM file

### Metadata
- **Docker Image**: quay.io/biocontainers/perl-bio-samtools:1.43--pl5321h577a1d6_6
- **Homepage**: https://metacpan.org/pod/Bio::DB::Sam
- **Package**: https://anaconda.org/channels/bioconda/packages/perl-bio-samtools/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: bam2bedgraph <in.bam> [region]

Create a BEDGraph file of genomic coverage. BAM file must be sorted.
```

## perl-bio-samtools_bamToGBrowse.pl

### Tool Description
Convert SAM/BAM files to sorted indexed BAM, BigWig graphs and a GBrowse config

### Metadata
- **Docker Image**: quay.io/biocontainers/perl-bio-samtools:1.43--pl5321h577a1d6_6
- **Homepage**: https://metacpan.org/pod/Bio::DB::Sam
- **Package**: https://anaconda.org/channels/bioconda/packages/perl-bio-samtools/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: /usr/local/bin/bamToGBrowse.pl <directory_path> [<ref.fa>]

Given the path to a directory and the fasta file for the reference
sequence, do the following:

 1. Find all SAM files in the indicated directory and convert them
    into BAM. These must end in one of the extensions ".sam" or ".sam.gz".
    A series of <base>.bam files will be created. This step will be
    skipped if SAM files are absent or the corresponding BAM files
    are already present.

 2. Sort the newly created BAM files, creating a series of files named
    <base>_sorted.bam.

 3. Index BAM files that need indexing. This step will look for
      files named <base>_sorted.bam

 4. Create a set of BigWig files representing the coverage graph. These
      will be named <base>.bw.

 5. Create a skeletal GBrowse config file named "gbrowse.conf" that
    serves as a starting point for viewing these files. Previous versions
    of this file will be appended to.

You can prepopulate the directory with sorted and indexed BAM files,
in which case the script will not attempt to resort or reindex them.
Unless the Fasta file is explicitly provided, this script will look in
the designated directory for ONE .fa file to use.

Note that you will need temporary space in the directory equivalent to
the size of the largest SAM file being processed.

This script takes a long time to run and uses significant amounts of
RAM when generating the coverage graphs. To improve both performance
and memory consumption, you can install the following C binaries:

  bedGraphToBigWig  -- download from http://hgdownload.cse.ucsc.edu/admin/exe
                       or build from source downloadable from
                       http;//hgdownload.cse.ucsc.edu/admin/jksrc.zip

Place these executables into your path, e.g. /usr/local/bin or ~/bin.
```

## perl-bio-samtools_chrom_sizes.pl

### Tool Description
Output a chrom_sizes file from a BAM file

### Metadata
- **Docker Image**: quay.io/biocontainers/perl-bio-samtools:1.43--pl5321h577a1d6_6
- **Homepage**: https://metacpan.org/pod/Bio::DB::Sam
- **Package**: https://anaconda.org/channels/bioconda/packages/perl-bio-samtools/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: /usr/local/bin/chrom_sizes.pl <bamfile>
Output a chrom_sizes file.
```

## perl-bio-samtools_genomeCoverageBed.pl

### Tool Description
Write the genome coverage of a BAM file as a BEDGraph table

### Metadata
- **Docker Image**: quay.io/biocontainers/perl-bio-samtools:1.43--pl5321h577a1d6_6
- **Homepage**: https://metacpan.org/pod/Bio::DB::Sam
- **Package**: https://anaconda.org/channels/bioconda/packages/perl-bio-samtools/overview
- **Validation**: PASS

### Original Help Text
```text
Usage /usr/local/bin/genomeCoverageBed.pl <bamfile>
```

## Metadata
- **Skill**: generated
