# footprint CWL Generation Report

## footprint_find_footprints.sh

### Tool Description
Finds footprints from ATAC-seq or DNase-seq data.

### Metadata
- **Docker Image**: quay.io/biocontainers/footprint:1.0.1--pl5321r41hdfd78af_0
- **Homepage**: https://ohlerlab.mdc-berlin.de/software/Reproducible_footprinting_139/
- **Package**: https://anaconda.org/channels/bioconda/packages/footprint/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/footprint/overview
- **Total Downloads**: 10.6K
- **Last updated**: 2025-04-22
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
Usage: find_footprints.sh \
         bam_file         \
         chrom_sizes      \
         motif_coords     \
         genome_fasta     \
         factor_name      \
         bias_file        \
         peak_file        \
         no_of_components \
         background       \
         fixed_bg

The arguments are explained below:

    bam_file:
        The bam file from the ATAC-seq or DNase-seq experiment.

    chrom_sizes:
        A tab delimited file with 2 columns, where the first column is
        the chromosome name and the second column is the chromosome
        length for the appropriate organism and genome build.

    motif_coords:
	A 6-column file with the coordinates of motif matches (eg
        resulting from scanning the genome with a PWM) for the
        transcription factor of interest. The 6 columns should contain
        chromosome, start coordinate, end coordinate, name, score and
        strand information in this order. There should not be any additional
	columns.The coordinates should be closed (1-based).

    genome_fasta:
        A multi-fasta format file that contains the whole genome
        sequence for the appropriate organism and genome build. This
        file should be indexed (eg by using samtools faidx) and placed
        in the same directory.

    factor_name:
        The name of the transcription factor of interest supplied by
        the user. This is used in the naming of the output files.

    bias_file:
        A file listing the cleavage/transposition bias of the
        different protocols, for all 6-mers. Provided options: ATAC,
        DNase double hit or DNase single hit protocols.

    peak_file:
        A file with the coordinates of the ChIP-seq peaks for the
        transcription factor of interest. The format is flexible as
        long as the first 3 columns (chromosome, start coordinate, end
        coordinate) are present.

    no_of_components:
        Total number of footprint and background components that
        should be learned from the data. Options are 2 (1 fp and 1 bg)
        and 3 (2 fp and 1 bg) components.

    background:
       The mode of initialization for the background
       component. Options are "Flat" or "Seq". Choosing "Flat"
       initializes this component as a uniform distribution. Choosing
       "Seq" initializes it as the signal profile that would be
       expected solely due to the protocol bias (given by the
       bias_file parameter).

    fixed_bg:
       Whether the background component should be kept fixed. Options
       are TRUE/T or FALSE/F. Setting "TRUE" keeps this component
       fixed, whereas setting "FALSE" lets it be reestimated during
       training. In general, if the background is estimated from bias 
       (option "Seq"), it is recommended to keep it fixed.
```

