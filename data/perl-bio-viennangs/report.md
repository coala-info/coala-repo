# perl-bio-viennangs CWL Generation Report

## perl-bio-viennangs_gff2bed.pl

### Tool Description
Extract specific features from a GFF3 file and convert them to BED format.

### Metadata
- **Docker Image**: quay.io/biocontainers/perl-bio-viennangs:v0.19.2--pl526_5
- **Homepage**: http://metacpan.org/pod/Bio::ViennaNGS
- **Package**: https://anaconda.org/channels/bioconda/packages/perl-bio-viennangs/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/perl-bio-viennangs/overview
- **Total Downloads**: 25.0K
- **Last updated**: 2025-04-22
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
Usage:
    gff2bed.pl [--gff FILE] [options]

Options:
    --gff
        Input GFF file.

    --feature -f
        Specify feature type (eg. CDS,tRNA,rRNA,SBS, etc) to be extracted
        from GFF3.

    --out -o
        Output path.

    --help -h
        Print short help

    --man
        Prints the manual page and exits
```


## perl-bio-viennangs_bam_split.pl

### Tool Description
Split BAM files by strand and optionally create BED, BedGraph, and bigWig coverage files.

### Metadata
- **Docker Image**: quay.io/biocontainers/perl-bio-viennangs:v0.19.2--pl526_5
- **Homepage**: http://metacpan.org/pod/Bio::ViennaNGS
- **Package**: https://anaconda.org/channels/bioconda/packages/perl-bio-viennangs/overview
- **Validation**: PASS

### Original Help Text
```text
Usage:
    bam_split.pl [--bam FILE] [options]

Options:
    --bam
        Input file in BAM format

    --bed
        Create a BED6 file for each split BAM file

    --bw
        Create BedGraph and bigWig coverage files for e.g. genome browser
        visualization.

    --bwdir
        Directory name for resulting bigWig files. This directory is created
        as subdirectory of the output directory. Default is 'vis'.

    --cs
        Chromosome sizes file (required if --bw is given).

    --norm
        Normalize resulting bigWig files

    --out -o
        Output directory

    --reverse -r
        Reverse the +/- strand mapping. This is required to achieve proper
        strand assignments for certain RNA-seq library preparation protocol.

    --scale
        If --bw is given, scale bigWig files to this number. Default is
        1000000.

    --uniq
        Filter uniquely mapped reads by inspecting the NH:i: SAM attribute.
        See also the bam_uniq.pl utility, which extracts both uniquely and
        multiply mapped reads from BAM files without strand-splitting.

    --log -l
        Log file extension. Default is ".bam_split.log". The log file is
        created in the directory given via -o and its name is constructed
        from the base name of the input BAM file and the log filename
        extension.

    --help -h
        Print short help

    --man
        Prints the manual page and exits
```


## perl-bio-viennangs_bam_to_bigwig.pl

### Tool Description
Convert BAM files to bigWig format for visualization, with support for strand-specific data.

### Metadata
- **Docker Image**: quay.io/biocontainers/perl-bio-viennangs:v0.19.2--pl526_5
- **Homepage**: http://metacpan.org/pod/Bio::ViennaNGS
- **Package**: https://anaconda.org/channels/bioconda/packages/perl-bio-viennangs/overview
- **Validation**: PASS

### Original Help Text
```text
Usage:
    bam_to_bigWig.pl [--bam FILE] [--cs FILE] [--strand +/-] [options]

Options:
    --bam -b
        Input file in BAM format

    --cs -c
        Chromosome sizes file

    --strand -s
        Use this option if the input BAM file is strictly strand-specific,
        ie. contains only reads mapped to either the positive or negative
        strand. Possible values are either '+' or '-'. If the value given
        here is '+', the interim bedGraph file will be created with positive
        values. A '-' given here will create the inerim bedGraph file with
        negative values, which is required for proper visualization of
        bigWig files holding coverage profiles of reads mapped to the
        negative strand in the UCSC genome browser. If the input BAM file is
        not strand-specific, ie contains reads mapped to both positive and
        negative strand, then the default value '+' will be used, resulting
        in bigWig coverage profiles rendered in positive (y-axis direction)
        in the UCSC genome browser.

    -o  Output directory

    --log -l
        Name of the log file. Unless specified, the default log file will be
        "bam_to_bigwig.log" in the given output directory.

    --help -h
        Print short help

    --man
        Prints the manual page and exits
```

