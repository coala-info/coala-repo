---
name: perl-bio-db-hts
description: This tool provides a high-performance Perl interface to the HTSlib library for rapid access to BAM, CRAM, and VCF files. Use when user asks to write or debug Perl scripts for sequence alignment retrieval, variant file processing, or region-based genomic data analysis.
homepage: https://metacpan.org/pod/Bio::DB::HTS
metadata:
  docker_image: "quay.io/biocontainers/perl-bio-db-hts:3.01--pl5321h577a1d6_12"
---

# perl-bio-db-hts

## Overview
The `perl-bio-db-hts` skill focuses on the programmatic use of the `Bio::DB::HTS` Perl module. This tool is a high-performance interface to the HTSlib C library, designed to replace the older `Bio::DB::Sam`. It allows for rapid, random access to compressed sequence alignment formats and variant call files. Use this skill to write or debug Perl scripts that perform depth calculations, variant filtering, or custom sequence analysis where speed and memory efficiency are critical.

## Installation
The most reliable way to set up the environment is via Bioconda:
```bash
conda install -c bioconda perl-bio-db-hts
```

## Core Usage Patterns

### Initializing a BAM/CRAM Database
To access alignments, initialize the high-level `Bio::DB::HTS` object.
```perl
use Bio::DB::HTS;

# For BAM files
my $hts = Bio::DB::HTS->new(-bam => "input.bam", -fasta => "ref.fa");

# For CRAM files (Reference FASTA is mandatory for CRAM)
my $hts_cram = Bio::DB::HTS->new(-bam => "input.cram", -fasta => "ref.fa");
```

### Region-Based Fetching
One of the most common tasks is retrieving alignments from a specific genomic window.
```perl
my @alignments = $hts->get_features_by_location(
    -seq_id => 'chr1',
    -start  => 1000,
    -end    => 2000
);

foreach my $aln (@alignments) {
    print $aln->query->display_name, " ", $aln->start, "\n";
}
```

### Low-Level BAM Access (Bio::DB::HTS::Bam)
For maximum performance or access to raw BAM records, use the low-level API.
```perl
use Bio::DB::HTS::Bam;

my $bam = Bio::DB::HTS::Bam->open("input.bam");
my $header = $bam->header;
my $target_names = $header->target_name;

while (my $alignment = $bam->read1) {
    my $seq_id = $target_names->[$alignment->tid];
    my $start  = $alignment->pos + 1; # BAM is 0-based, Perl Bio is usually 1-based
    next if $alignment->qual < 30;    # Filter by mapping quality
}
```

### Working with VCF/BCF
Accessing variants via the HTSlib VCF/BCF API:
```perl
use Bio::DB::HTS::VCF;

my $vcf = Bio::DB::HTS::VCF->new(-file => "variants.vcf.gz");
my $header = $vcf->header;

while (my $row = $vcf->next_data_hash($header)) {
    print $row->{CHROM}, ":", $row->{POS}, " ", $row->{ID}, "\n";
}
```

## Expert Tips and Best Practices

1.  **Index Files**: Always ensure your BAM/CRAM/VCF files are indexed (`.bai`, `.crai`, or `.tbi`). `Bio::DB::HTS` relies on these for random access; without them, performance will degrade to linear scanning.
2.  **Memory Management**: When processing millions of records, avoid storing all objects in an array. Use the `while($bam->read1)` iterator pattern to process records one at a time.
3.  **CRAM References**: When working with CRAM, the `-fasta` argument is essential. If the reference is not provided, HTSlib will attempt to download it via EBI's refget API, which can be slow or fail in firewalled environments.
4.  **Coordinate Systems**: Remember that the low-level `Bio::DB::HTS::Bam` API uses 0-based coordinates (matching the BAM spec), while the high-level `Bio::DB::HTS` API often follows BioPerl's 1-based convention. Always verify coordinate offsets when switching between APIs.
5.  **Filtering**: Use the bitwise flag methods (e.g., `$aln->flag & 0x0004` for unmapped) to quickly filter reads before performing more expensive string manipulations or object method calls.

## Reference documentation
- [Bio::DB::HTS Documentation](./references/metacpan_org_pod_Bio__DB__HTS.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_perl-bio-db-hts_overview.md)