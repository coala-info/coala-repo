# plastid CWL Generation Report

## plastid_phase_by_size

### Tool Description
Estimate sub-codon phasing in a ribosome profiling dataset,
stratified by read length.

Because ribosomes step three nucleotides in each cycle of translation elongation,
in many ribosome profiling datasets a triplet periodicity is observable
in the distribution of ribosome-protected footprints.

In a good dataset, 70-90% of the reads on a codon fall within the first of the
three codon positions. This allows deduction of translation reading frames, if
the reading frame is not known *a priori.* See Ingolia2009 for more
details.

### Metadata
- **Docker Image**: quay.io/biocontainers/plastid:0.6.1--py38h7d1810a_2
- **Homepage**: http://plastid.readthedocs.io/en/latest/
- **Package**: https://anaconda.org/channels/bioconda/packages/plastid/overview
- **Validation**: PASS

### Original Help Text
```text
usage: phase_by_size [-h] [-q] [-v]
                     [--annotation_files infile.[BED | BigBed | GTF2 | GFF3]
                     [infile.[BED | BigBed | GTF2 | GFF3] ...]]
                     [--annotation_format {BED,BigBed,GTF2,GFF3}]
                     [--add_three] [--tabix] [--sorted]
                     [--bed_extra_columns BED_EXTRA_COLUMNS [BED_EXTRA_COLUMNS ...]]
                     [--maxmem MAXMEM]
                     [--gff_transcript_types GFF_TRANSCRIPT_TYPES [GFF_TRANSCRIPT_TYPES ...]]
                     [--gff_exon_types GFF_EXON_TYPES [GFF_EXON_TYPES ...]]
                     [--gff_cds_types GFF_CDS_TYPES [GFF_CDS_TYPES ...]]
                     [--count_files COUNT_FILES [COUNT_FILES ...]]
                     [--countfile_format {BAM}] [--sum SUM] [--min_length N]
                     [--max_length N] [--fiveprime_variable] [--fiveprime]
                     [--threeprime] [--center] [--offset OFFSET] [--nibble N]
                     [--figformat {eps,jpeg,jpg,pdf,pgf,png,ps,raw,rgba,svg,svgz,tif,tiff,webp}]
                     [--figsize N N] [--title TITLE] [--cmap CMAP] [--dpi DPI]
                     [--stylesheet {Solarize_Light2,_classic_test_patch,_mpl-gallery,_mpl-gallery-nogrid,bmh,classic,dark_background,fast,fivethirtyeight,ggplot,grayscale,seaborn-v0_8,seaborn-v0_8-bright,seaborn-v0_8-colorblind,seaborn-v0_8-dark,seaborn-v0_8-dark-palette,seaborn-v0_8-darkgrid,seaborn-v0_8-deep,seaborn-v0_8-muted,seaborn-v0_8-notebook,seaborn-v0_8-paper,seaborn-v0_8-pastel,seaborn-v0_8-poster,seaborn-v0_8-talk,seaborn-v0_8-ticks,seaborn-v0_8-white,seaborn-v0_8-whitegrid,tableau-colorblind10}]
                     [--codon_buffer CODON_BUFFER]
                     [roi_file] outbase

------------------------------------------------------------------------------

Estimate sub-codon phasing in a ribosome profiling dataset,
stratified by read length.

Because ribosomes step three nucleotides in each cycle of translation elongation,
in many ribosome profiling datasets a triplet periodicity is observable
in the distribution of ribosome-protected footprints.

In a good dataset, 70-90% of the reads on a codon fall within the first of the
three codon positions. This allows deduction of translation reading frames, if
the reading frame is not known *a priori.* See Ingolia2009 for more
details.

Output files
------------
    OUTBASE_phasing.txt
        Read phasing for each read length

    OUTBASE_phasing.svg
        Plot of phasing by read length

where `OUTBASE` is supplied by the user.

 .. note::

    To avoid double-counting of codons, users should either use an *ROI file*
    made by the ``generate`` subprogram of the metagene script, or supply
    an annotation file that includes only one transcript isoform per
    gene.

------------------------------------------------------------------------------

positional arguments:
  roi_file              Optional. ROI file of maximal spanning windows
                        surrounding start codons, from ``metagene generate``
                        subprogram. Using this instead of `--annotation_files`
                        prevents double-counting of codons when multiple
                        transcript isoforms exist for a gene. See the
                        documentation for `metagene` for more info about ROI
                        files.If an ROI file is not given, supply an
                        annotation with ``--annotation_files``
  outbase               Required. Basename for output files

optional arguments:
  -h, --help            show this help message and exit
  --codon_buffer CODON_BUFFER
                        Codons before and after start codon to ignore
                        (Default: 5)

warning/error options:
  -q, --quiet           Suppress all warning messages. Cannot use with '-v'.
  -v, --verbose         Increase verbosity. With '-v', show every warning.
                        With '-vv', turn warnings into exceptions. Cannot use
                        with '-q'. (Default: show each type of warning once)

annotation file options (one or more annotation files required):
  Open one or more genome annotation files

  --annotation_files infile.[BED | BigBed | GTF2 | GFF3] [infile.[BED | BigBed | GTF2 | GFF3] ...]
                        Zero or more annotation files (max 1 file if BigBed)
  --annotation_format {BED,BigBed,GTF2,GFF3}
                        Format of annotation_files (Default: GTF2). Note: GFF3
                        assembly assumes SO v.2.5.2 feature ontologies, which
                        may or may not match your specific file.
  --add_three           If supplied, coding regions will be extended by 3
                        nucleotides at their 3' ends (except for GTF2 files
                        that explicitly include `stop_codon` features). Use if
                        your annotation file excludes stop codons from CDS.
  --tabix               annotation_files are tabix-compressed and indexed
                        (Default: False). Ignored for BigBed files.
  --sorted              annotation_files are sorted by chromosomal position
                        (Default: False)

BED-specific options:
  --bed_extra_columns BED_EXTRA_COLUMNS [BED_EXTRA_COLUMNS ...]
                        Number of extra columns in BED file (e.g. in custom
                        ENCODE formats) or list of names for those columns.
                        (Default: 0).

BigBed-specific options:
  --maxmem MAXMEM       Maximum desired memory footprint in MB to devote to
                        BigBed/BigWig files. May be exceeded by large queries.
                        (Default: 0, No maximum)

GFF3-specific options:
  --gff_transcript_types GFF_TRANSCRIPT_TYPES [GFF_TRANSCRIPT_TYPES ...]
                        GFF3 feature types to include as transcripts, even if
                        no exons are present (for GFF3 only; default: use SO
                        v2.5.3 specification)
  --gff_exon_types GFF_EXON_TYPES [GFF_EXON_TYPES ...]
                        GFF3 feature types to include as exons (for GFF3 only;
                        default: use SO v2.5.3 specification)
  --gff_cds_types GFF_CDS_TYPES [GFF_CDS_TYPES ...]
                        GFF3 feature types to include as CDS (for GFF3 only;
                        default: use SO v2.5.3 specification)

count & alignment file options:
  Open alignment or count files and optionally set mapping rules

  --count_files COUNT_FILES [COUNT_FILES ...]
                        One or more count or alignment file(s) from a single
                        sample or set of samples to be pooled.
  --countfile_format {BAM}
                        Format of file containing alignments or counts
                        (Default: BAM)
  --sum SUM             Sum used in normalization of counts and RPKM/RPNT
                        calculations (Default: total mapped reads/counts in
                        dataset)
  --min_length N        Minimum read length required to be included (BAM &
                        bowtie files only. Default: 25)
  --max_length N        Maximum read length permitted to be included (BAM &
                        bowtie files only. Default: 100)

alignment mapping functions (BAM & bowtie files only):
  For BAM or bowtie files, one of the mutually exclusive read mapping functions
  is required:

  --fiveprime_variable  Map read alignment to a variable offset from 5'
                        position of read, with offset determined by read
                        length. Requires `--offset` below
  --fiveprime           Map read alignment to 5' position.
  --threeprime          Map read alignment to 3' position
  --center              Subtract N positions from each end of read, and add
                        1/(length-N), to each remaining position, where N is
                        specified by `--nibble`

filtering and alignment mapping options:
  
  The remaining arguments are optional and affect the behavior of specific
  mapping functions:

  --offset OFFSET       For `--fiveprime` or `--threeprime`, provide an
                        integer representing the offset into the read,
                        starting from either the 5' or 3' end, at which data
                        should be plotted. For `--fiveprime_variable`, provide
                        the filename of a two-column tab-delimited text file,
                        in which first column represents read length or the
                        special keyword `'default'`, and the second column
                        represents the offset from the five prime end of that
                        read length at which the read should be mapped.
                        (Default: 0)
  --nibble N            For use with `--center` only. nt to remove from each
                        end of read before mapping (Default: 0)

Plotting options:
  --figformat {eps,jpeg,jpg,pdf,pgf,png,ps,raw,rgba,svg,svgz,tif,tiff,webp}
                        File format for figure(s); Default: png)
  --figsize N N         Figure width and height, in inches. (Default: use
                        matplotlibrc params)
  --title TITLE         Base title for plot(s).
  --cmap CMAP           Matplotlib color map from which palette will be made
                        (e.g. 'Blues','autumn','Set1'; default: use colors
                        from ``--stylesheet`` if given, or color cycle in
                        matplotlibrc)
  --dpi DPI             Figure resolution (Default: 150)
  --stylesheet {Solarize_Light2,_classic_test_patch,_mpl-gallery,_mpl-gallery-nogrid,bmh,classic,dark_background,fast,fivethirtyeight,ggplot,grayscale,seaborn-v0_8,seaborn-v0_8-bright,seaborn-v0_8-colorblind,seaborn-v0_8-dark,seaborn-v0_8-dark-palette,seaborn-v0_8-darkgrid,seaborn-v0_8-deep,seaborn-v0_8-muted,seaborn-v0_8-notebook,seaborn-v0_8-paper,seaborn-v0_8-pastel,seaborn-v0_8-poster,seaborn-v0_8-talk,seaborn-v0_8-ticks,seaborn-v0_8-white,seaborn-v0_8-whitegrid,tableau-colorblind10}
                        Use this matplotlib stylesheet instead of matplotlibrc
                        params
```

## plastid_counts_in_region

### Tool Description
Count the number of read alignments covering regions of interest in the genome, and calculate read densities (in reads per nucleotide and in RPKM) over these regions.

### Metadata
- **Docker Image**: quay.io/biocontainers/plastid:0.6.1--py38h7d1810a_2
- **Homepage**: http://plastid.readthedocs.io/en/latest/
- **Package**: https://anaconda.org/channels/bioconda/packages/plastid/overview
- **Validation**: PASS

### Original Help Text
```text
usage: counts_in_region [-h] [-q] [-v]
                        [--count_files COUNT_FILES [COUNT_FILES ...]]
                        [--countfile_format {BAM,bigwig,bowtie,wiggle}]
                        [--sum SUM] [--min_length N] [--max_length N]
                        [--big_genome] [--fiveprime_variable] [--fiveprime]
                        [--threeprime] [--center] [--offset OFFSET]
                        [--nibble N]
                        [--annotation_files infile.[BED | BigBed | GTF2 | GFF3]
                        [infile.[BED | BigBed | GTF2 | GFF3] ...]]
                        [--annotation_format {BED,BigBed,GTF2,GFF3}]
                        [--add_three] [--tabix] [--sorted]
                        [--bed_extra_columns BED_EXTRA_COLUMNS [BED_EXTRA_COLUMNS ...]]
                        [--maxmem MAXMEM]
                        [--gff_transcript_types GFF_TRANSCRIPT_TYPES [GFF_TRANSCRIPT_TYPES ...]]
                        [--gff_exon_types GFF_EXON_TYPES [GFF_EXON_TYPES ...]]
                        [--gff_cds_types GFF_CDS_TYPES [GFF_CDS_TYPES ...]]
                        [--mask_annotation_files infile.[BED | BigBed | GTF2 | GFF3 | PSL]
                        [infile.[BED | BigBed | GTF2 | GFF3 | PSL] ...]]
                        [--mask_annotation_format {BED,BigBed,GTF2,GFF3,PSL}]
                        [--mask_add_three] [--mask_tabix] [--mask_sorted]
                        [--mask_bed_extra_columns MASK_BED_EXTRA_COLUMNS [MASK_BED_EXTRA_COLUMNS ...]]
                        [--mask_maxmem MASK_MAXMEM]
                        [--mask_gff_transcript_types MASK_GFF_TRANSCRIPT_TYPES [MASK_GFF_TRANSCRIPT_TYPES ...]]
                        [--mask_gff_exon_types MASK_GFF_EXON_TYPES [MASK_GFF_EXON_TYPES ...]]
                        [--mask_gff_cds_types MASK_GFF_CDS_TYPES [MASK_GFF_CDS_TYPES ...]]
                        outfile

------------------------------------------------------------------------------

Count the number of :term:`read alignments<alignment>` covering 
regions of interest in the genome, and calculate read densities (in reads
per nucleotide and in RPKM) over these regions.

Results are output as a table with the following columns:

    ========================  ==================================================
    **Name**                  **Definition**
    ------------------------  --------------------------------------------------
    `region_name`             Name or ID of region of interest
    
    `region`                  Genomic coordinates of region, formatted as
                              described in
                              plastid.genomics.roitools.SegmentChain.from_str
                              
    `counts`                  Number of reads mapping to region
    
    `counts_per_nucleotide`   Read density, measured in number of reads mapping
                              to region, divided by length of region
                              
    `rpkm`                    Read density, measured in RPKM
    
    `length`                  Region length, in nucleotides
    ========================  ==================================================
    
If a mask annotation file is supplied, masked portions of regions
will be excluded when tabulating counts, measuring region length, and calculating
`counts_per_nucleotide` and `rpkm`.

See also
--------
~plastid.bin.cs script
    Count the number of :term:`read alignments<alignment>` and calculate
    read densities (in RPKM) specifically for genes and sub-regions
    (5' UTR, CDS, 3' UTR), excluding positions covered by multiple genes

------------------------------------------------------------------------------

positional arguments:
  outfile               Output filename

optional arguments:
  -h, --help            show this help message and exit

warning/error options:
  -q, --quiet           Suppress all warning messages. Cannot use with '-v'.
  -v, --verbose         Increase verbosity. With '-v', show every warning.
                        With '-vv', turn warnings into exceptions. Cannot use
                        with '-q'. (Default: show each type of warning once)

count & alignment file options:
  Open alignment or count files and optionally set mapping rules

  --count_files COUNT_FILES [COUNT_FILES ...]
                        One or more count or alignment file(s) from a single
                        sample or set of samples to be pooled.
  --countfile_format {BAM,bigwig,bowtie,wiggle}
                        Format of file containing alignments or counts
                        (Default: BAM)
  --sum SUM             Sum used in normalization of counts and RPKM/RPNT
                        calculations (Default: total mapped reads/counts in
                        dataset)
  --min_length N        Minimum read length required to be included (BAM &
                        bowtie files only. Default: 25)
  --max_length N        Maximum read length permitted to be included (BAM &
                        bowtie files only. Default: 100)
  --big_genome          Use slower but memory-efficient implementation for big
                        genomes or for memory-limited computers. For wiggle &
                        bowtie files only.

alignment mapping functions (BAM & bowtie files only):
  For BAM or bowtie files, one of the mutually exclusive read mapping functions
  is required:

  --fiveprime_variable  Map read alignment to a variable offset from 5'
                        position of read, with offset determined by read
                        length. Requires `--offset` below
  --fiveprime           Map read alignment to 5' position.
  --threeprime          Map read alignment to 3' position
  --center              Subtract N positions from each end of read, and add
                        1/(length-N), to each remaining position, where N is
                        specified by `--nibble`

filtering and alignment mapping options:
  
  The remaining arguments are optional and affect the behavior of specific
  mapping functions:

  --offset OFFSET       For `--fiveprime` or `--threeprime`, provide an
                        integer representing the offset into the read,
                        starting from either the 5' or 3' end, at which data
                        should be plotted. For `--fiveprime_variable`, provide
                        the filename of a two-column tab-delimited text file,
                        in which first column represents read length or the
                        special keyword `'default'`, and the second column
                        represents the offset from the five prime end of that
                        read length at which the read should be mapped.
                        (Default: 0)
  --nibble N            For use with `--center` only. nt to remove from each
                        end of read before mapping (Default: 0)

annotation file options (one or more annotation files required):
  Open one or more genome annotation files

  --annotation_files infile.[BED | BigBed | GTF2 | GFF3] [infile.[BED | BigBed | GTF2 | GFF3] ...]
                        Zero or more annotation files (max 1 file if BigBed)
  --annotation_format {BED,BigBed,GTF2,GFF3}
                        Format of annotation_files (Default: GTF2). Note: GFF3
                        assembly assumes SO v.2.5.2 feature ontologies, which
                        may or may not match your specific file.
  --add_three           If supplied, coding regions will be extended by 3
                        nucleotides at their 3' ends (except for GTF2 files
                        that explicitly include `stop_codon` features). Use if
                        your annotation file excludes stop codons from CDS.
  --tabix               annotation_files are tabix-compressed and indexed
                        (Default: False). Ignored for BigBed files.
  --sorted              annotation_files are sorted by chromosomal position
                        (Default: False)

BED-specific options:
  --bed_extra_columns BED_EXTRA_COLUMNS [BED_EXTRA_COLUMNS ...]
                        Number of extra columns in BED file (e.g. in custom
                        ENCODE formats) or list of names for those columns.
                        (Default: 0).
  --mask_bed_extra_columns MASK_BED_EXTRA_COLUMNS [MASK_BED_EXTRA_COLUMNS ...]
                        Number of extra columns in BED file (e.g. in custom
                        ENCODE formats) or list of names for those columns.
                        (Default: 0).

BigBed-specific options:
  --maxmem MAXMEM       Maximum desired memory footprint in MB to devote to
                        BigBed/BigWig files. May be exceeded by large queries.
                        (Default: 0, No maximum)
  --mask_maxmem MASK_MAXMEM
                        Maximum desired memory footprint in MB to devote to
                        BigBed/BigWig files. May be exceeded by large queries.
                        (Default: 0, No maximum)

GFF3-specific options:
  --gff_transcript_types GFF_TRANSCRIPT_TYPES [GFF_TRANSCRIPT_TYPES ...]
                        GFF3 feature types to include as transcripts, even if
                        no exons are present (for GFF3 only; default: use SO
                        v2.5.3 specification)
  --gff_exon_types GFF_EXON_TYPES [GFF_EXON_TYPES ...]
                        GFF3 feature types to include as exons (for GFF3 only;
                        default: use SO v2.5.3 specification)
  --gff_cds_types GFF_CDS_TYPES [GFF_CDS_TYPES ...]
                        GFF3 feature types to include as CDS (for GFF3 only;
                        default: use SO v2.5.3 specification)
  --mask_gff_transcript_types MASK_GFF_TRANSCRIPT_TYPES [MASK_GFF_TRANSCRIPT_TYPES ...]
                        GFF3 feature types to include as transcripts, even if
                        no exons are present (for GFF3 only; default: use SO
                        v2.5.3 specification)
  --mask_gff_exon_types MASK_GFF_EXON_TYPES [MASK_GFF_EXON_TYPES ...]
                        GFF3 feature types to include as exons (for GFF3 only;
                        default: use SO v2.5.3 specification)
  --mask_gff_cds_types MASK_GFF_CDS_TYPES [MASK_GFF_CDS_TYPES ...]
                        GFF3 feature types to include as CDS (for GFF3 only;
                        default: use SO v2.5.3 specification)

mask file options (optional):
  Add mask file(s) that annotate regions that should be excluded from analyses
  (e.g. repetitive genomic regions).

  --mask_annotation_files infile.[BED | BigBed | GTF2 | GFF3 | PSL] [infile.[BED | BigBed | GTF2 | GFF3 | PSL] ...]
                        Zero or more annotation files (max 1 file if BigBed)
  --mask_annotation_format {BED,BigBed,GTF2,GFF3,PSL}
                        Format of mask_annotation_files (Default: GTF2). Note:
                        GFF3 assembly assumes SO v.2.5.2 feature ontologies,
                        which may or may not match your specific file.
  --mask_add_three      If supplied, coding regions will be extended by 3
                        nucleotides at their 3' ends (except for GTF2 files
                        that explicitly include `stop_codon` features). Use if
                        your annotation file excludes stop codons from CDS.
  --mask_tabix          mask_annotation_files are tabix-compressed and indexed
                        (Default: False). Ignored for BigBed files.
  --mask_sorted         mask_annotation_files are sorted by chromosomal
                        position (Default: False)
```

## Metadata
- **Skill**: generated
