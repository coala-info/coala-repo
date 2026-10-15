# plastid CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| plastid_counts_in_region | PASS | nf-core human riboseq chr20 BAM and CDS BED from cs generate; 500 regions counted, counts equal cs count (ENSG00000000419 = 6); added BAM index secondary files and offset as int or file |
| plastid_crossmap | Failed | image problem: crossmap looks for bowtie at /usr/bin/bowtie, which is missing (bowtie is in /usr/local/bin), so the run exits 0 with an empty mask; it works only when the job sets --bowtie /usr/local/bin/bowtie; new CWL for crossmap |
| plastid_cs_chart | Failed | image problem: matplotlib in the image is too new (log-scale argument basex removed), so cs chart crashes when plotting; default bins also hit a NaN error on the sparse test data; new CWL for cs chart |
| plastid_cs_count | PASS | nf-core human riboseq chr20 BAM with positions from cs generate and P-site offsets; table of 1446 genes with exon, 5' UTR, CDS and 3' UTR counts; new CWL for cs count |
| plastid_cs_generate | PASS | nf-core human riboseq chr20 GTF; gene and transcript position files and BED tracks written (1447 genes); new CWL for cs generate |
| plastid_findjuncs | PASS | nf-core SARS-CoV-2 genome.gtf; 9 splice junctions for the 10-exon transcript, BED and tophat juncs written; new CWL for findjuncs |
| plastid_get_count_vectors | PASS | nf-core human riboseq chr20 BAM and 10 CDS regions; vector sums equal counts_in_region counts (266 in total); new CWL for get_count_vectors |
| plastid_gff_parent_types | PASS | nf-core SARS-CoV-2 genome.gff3; parent-child table matches feature counts (12 CDS and 10 gene features with transcript parents); new CWL for gff_parent_types |
| plastid_make_wiggle | PASS | nf-core human riboseq chr20 BAM with P-site offsets; wiggle signal total 423252 vs 423256 reads of length 25-100 in the BAM; new CWL for make_wiggle |
| plastid_metagene_count | PASS | nf-core human riboseq chr20 BAM with P-site offsets; profile non-zero with --min_counts 1 --use_mean (sparse subset BAM; with default min_counts the program crashes on an empty selection); new CWL for metagene count |
| plastid_metagene_generate | PASS | nf-core human riboseq chr20 GTF; ROI table identical to the nf-core expected file; new CWL for metagene generate |
| plastid_phase_by_size | PASS | nf-core human riboseq chr20 BAM and ROI file from metagene generate; phasing table and plot written; added BAM index secondary files |
| plastid_psite | PASS | nf-core human riboseq chr20 BAM and ROI file; P-site offsets identical to the nf-core expected file; new CWL for psite |
| plastid_reformat_transcripts | PASS | nf-core SARS-CoV-2 genome.gtf converted to BED12 with --output_format BED (one transcript, 10 exons, 258-29667); default output is GTF2 whatever the file name; new CWL for reformat_transcripts |
| plastid_slidejuncs | PASS | junctions from findjuncs on nf-core SARS-CoV-2 genome and genome FASTA; all 9 junctions matched to the known reference set; new CWL for slidejuncs |

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

## plastid_findjuncs

### Tool Description
Find splice junctions in read alignments (RNA-seq or ribosome profiling) and export them as BED.

### Metadata
- **Docker Image**: quay.io/biocontainers/plastid:0.6.1--py38h7d1810a_2
- **Homepage**: https://github.com/joshuagryphon/plastid
- **Package**: https://anaconda.org/channels/bioconda/packages/plastid/overview
- **Validation**: PASS

### Original Help Text
```text
usage: findjuncs [-h] [-q] [-v]
                 [--annotation_files infile.[BED | BigBed | GTF2 | GFF3 | PSL]
                 [infile.[BED | BigBed | GTF2 | GFF3 | PSL] ...]]
                 [--annotation_format {BED,BigBed,GTF2,GFF3,PSL}]
                 [--add_three] [--tabix] [--sorted]
                 [--bed_extra_columns BED_EXTRA_COLUMNS [BED_EXTRA_COLUMNS ...]]
                 [--maxmem MAXMEM]
                 [--gff_transcript_types GFF_TRANSCRIPT_TYPES [GFF_TRANSCRIPT_TYPES ...]]
                 [--gff_exon_types GFF_EXON_TYPES [GFF_EXON_TYPES ...]]
                 [--gff_cds_types GFF_CDS_TYPES [GFF_CDS_TYPES ...]]
                 [--export_tophat]
                 outbase

------------------------------------------------------------------------------

This script identify all the unique splice junctions in one or more transcript
annotations, and exports these as a BED file with one splice junction per line
Optionally, this script can also export junctions as a Tophat ``.juncs`` file.

If a splice junction appears multiple times (e.g. used by more than one transcript),
only the first occurrence of the junction will be reported. Scores, if present,
are exported unaltered in BED output.

Examples:

.. code-block:: shell

   # identify splice junctions from a transcript annotation supplied in GTF2
   # creates output file 'annotation.bed'
   $ findjuncs my_annotation --annotation_format GTF2 \
               --annotation_files transcripts.gtf
    
   # merge unique annotations from annotation.bed and newly_discovered.bed,
   # export only unique junctions to 'merged_unique.bed'
   $ findjuncs merged_unique --annotation_format BED \
               --annotation_files annotation.bed newly_discovered.bed

See also
--------
plastid.bin.slidejuncs
   Script that makes richer comparisons between discovered and annotated
   junctions, using genomic sequence and plastid.bin.crossmap
   results to classify junctions

------------------------------------------------------------------------------

positional arguments:
  outbase               Basename for output files

optional arguments:
  -h, --help            show this help message and exit
  --export_tophat       Export tophat `.juncs` file in addition to BED output

warning/error options:
  -q, --quiet           Suppress all warning messages. Cannot use with '-v'.
  -v, --verbose         Increase verbosity. With '-v', show every warning.
                        With '-vv', turn warnings into exceptions. Cannot use
                        with '-q'. (Default: show each type of warning once)

annotation file options (one or more annotation files required):
  Open one or more genome annotation files

  --annotation_files infile.[BED | BigBed | GTF2 | GFF3 | PSL] [infile.[BED | BigBed | GTF2 | GFF3 | PSL] ...]
                        Zero or more annotation files (max 1 file if BigBed)
  --annotation_format {BED,BigBed,GTF2,GFF3,PSL}
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
```

## plastid_slidejuncs

### Tool Description
Slide discovered splice junctions to canonical positions and compare with reference junctions.

### Metadata
- **Docker Image**: quay.io/biocontainers/plastid:0.6.1--py38h7d1810a_2
- **Homepage**: https://github.com/joshuagryphon/plastid
- **Package**: https://anaconda.org/channels/bioconda/packages/plastid/overview
- **Validation**: PASS

### Original Help Text
```text
usage: slidejuncs [-h] [-q] [-v]
                  [--sequence_file infile.[fasta | fastq | twobit | genbank | embl]]
                  [--sequence_format {fasta,fastq,twobit,genbank,embl}]
                  [--mask_annotation_files infile.[BED | BigBed | GTF2 | GFF3 | PSL]
                  [infile.[BED | BigBed | GTF2 | GFF3 | PSL] ...]]
                  [--mask_annotation_format {BED,BigBed,GTF2,GFF3,PSL}]
                  [--mask_add_three] [--mask_tabix] [--mask_sorted]
                  [--mask_bed_extra_columns MASK_BED_EXTRA_COLUMNS [MASK_BED_EXTRA_COLUMNS ...]]
                  [--mask_maxmem MASK_MAXMEM]
                  [--mask_gff_transcript_types MASK_GFF_TRANSCRIPT_TYPES [MASK_GFF_TRANSCRIPT_TYPES ...]]
                  [--mask_gff_exon_types MASK_GFF_EXON_TYPES [MASK_GFF_EXON_TYPES ...]]
                  [--mask_gff_cds_types MASK_GFF_CDS_TYPES [MASK_GFF_CDS_TYPES ...]]
                  [--maxslide MAXSLIDE] [--ref ref.bed] [--slide_canonical]
                  input.bed outbase

------------------------------------------------------------------------------

Compare splice junctions discovered in a dataset to those in an annotation
of known splice junctions, amending misplaced junctions, and identifying 
junctions that fall within repetitive areas of the genome.

Known splice junctions can be misidentified as novel or non-canonical junctions
when intronic sequence immediately downstream of the fiveprime splice site
exactly matches the exonic sequence immediately downstream of the threeprime
splice site. In fact, the junction point could appear anywhere in this
locally-repeated region with equal support from sequencing data. For example,
suppose we have a splice junction as follows::

        
                Exon 1 [0,6)            Intron                                  Exon 2 [16,24)
                ---------------------   --------------------------------------  ------------------------------
    Sequence    G   C   T   C   T   A   C   T   A   G   N   N   N   C   T   A   C   T   A   G   A   T   G   G
    Position    0   1   2   3   4   5   6   7   8   9   10  11  12  13  14  15  16  17  18  19  20  21  22  23
    Repeated                ^^^^^^^^^^^^^^^^^^^^^^^^^^^^            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^
    
In this case, the splice junction could be moved 3 bases to the left, or
four bases to the right, without losing consistency with the sequence of
any cDNA or read alignment covering the junction.
   
To identify this and other causes of false positive splice junction calls,
the following operations are performed on each query junction:

    1.  If a mask file from crossmap
        is provided, junctions in which one or more of the 5' and 3' splice
        sites appear in a repetitive region of the genome are flagged as
        non-informative and written to a separate file. 

    2.  For remaining splice junctions, the extent of locally repeated nucleotide
        sequence, if any, surrounding the query junction's splice donor and
        acceptor sites, are determined in both the 5' and 3' directions.
        
        This is the maximum window (*equal-support region*) across which the
        actual splice junction could be moved without reducing sequence support.
    
    3.  If there is one or more known splice junctions in this region, the
        query junction is assumed to match these, and the known junctions are
        reported rather than the query. 
    
    4.  If (3) is not satisfied, and the query junction is a canonical splice
        junction, it is reported as is.

    5.  If (3) is not satisfied, and the query junction represents a non-canonical
        splice junction, the program determines if one or more canonical splice
        junctions is present in the equal-support region. If so, these canonical
        splice junction are reported rather than the query junction.
        
    6.  If (5) is not satisfied, the non-canonical query junction is reported as-is.

Output files
------------
The following files are written, where `OUTBASE` is a string supplied by the
user. Scores of splice junctions, if present in the input, are ignored.
Each record in each BED file represents a single exon-exon junction, rather
than a transcript:

    OUTBASE_repetitive.bed
        Splice junctions in which one or more of the splice sites lands
        in a repetitive/degenerate region of the genome, which gives rise to
        mapping ambiguities (step 1 above)
    
    OUTBASE_shifted_known.bed
        The result of shifting query splice junctions to known splice junctions
        with equal sequence support (step 3 above)
    
    OUTBASE_shifted_canonical.bed
        The result of shifting non-canonical query splice junctions to canonical
        splice junctions with equal sequence support (step 5 above)
    
    OUTBASE_untouched.bed
        Query junctions reported without changes (steps 4 and 6 above)

where `OUTBASE` is given by the user.

------------------------------------------------------------------------------

positional arguments:
  input.bed             BED file describing discovered junctions
  outbase               Basename for output files

optional arguments:
  -h, --help            show this help message and exit
  --maxslide MAXSLIDE   Maximum number of nt to search 5' and 3' of intron
                        boundaries (Default: 10)
  --ref ref.bed         Reference file describing known splice junctions
  --slide_canonical     Slide junctions to canonical junctions if present
                        within equal support region

warning/error options:
  -q, --quiet           Suppress all warning messages. Cannot use with '-v'.
  -v, --verbose         Increase verbosity. With '-v', show every warning.
                        With '-vv', turn warnings into exceptions. Cannot use
                        with '-q'. (Default: show each type of warning once)

sequence options:

  --sequence_file infile.[fasta | fastq | twobit | genbank | embl]
                        A file of DNA sequence
  --sequence_format {fasta,fastq,twobit,genbank,embl}
                        Format of sequence_file (Default: fasta).

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

BED-specific options:
  --mask_bed_extra_columns MASK_BED_EXTRA_COLUMNS [MASK_BED_EXTRA_COLUMNS ...]
                        Number of extra columns in BED file (e.g. in custom
                        ENCODE formats) or list of names for those columns.
                        (Default: 0).

BigBed-specific options:
  --mask_maxmem MASK_MAXMEM
                        Maximum desired memory footprint in MB to devote to
                        BigBed/BigWig files. May be exceeded by large queries.
                        (Default: 0, No maximum)

GFF3-specific options:
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
```

## plastid_crossmap

### Tool Description
Calculate a crossmap (genome-wide mappability of reads of a given length) for a genome with bowtie.

### Metadata
- **Docker Image**: quay.io/biocontainers/plastid:0.6.1--py38h7d1810a_2
- **Homepage**: https://github.com/joshuagryphon/plastid
- **Package**: https://anaconda.org/channels/bioconda/packages/plastid/overview
- **Validation**: PASS

### Original Help Text
```text
usage: crossmap [-h] [-q] [-v]
                [--sequence_file infile.[fasta | fastq | twobit | genbank | embl]]
                [--sequence_format {fasta,fastq,twobit,genbank,embl}]
                [-k READ_LENGTH] [--offset OFFSET] [--mismatches N]
                [--bowtie BOWTIE] [--have_kmers] [--save_kmers] [-p N]
                ebwt outbase

------------------------------------------------------------------------------

This script empirically determines which positions in a genome yield 
multimapping reads under a given set of alignment parameters. These positions
are saved in a BED-formatted mask file, so that they may be excluded
as from further analyses.

To identify multimapping regions, a genome sequence is diced into :term:`k-mers
<k-mer>` and the k-mers aligned back to the genome. Positions in the
genome that give rise to k-mers that align equally well to more
than one genomic location are then marked as multimapping..

`k` is specified by the user, as are the alignment parameters.

Output files
------------
The following files are made:

    OUTBASE_READLENGTH_MISMATCHES_crossmap.bed
        Final mask file annotation, in BED format

    OUTBASE_READLENGTH_MISMATCHES_CHROMOSOME_kmers.fa
        K-mers derived from chromosome `CHROMOSOME`. These
        files can be reused in subsequent runs allowing a different number of
        mismatches, using the ``--have_kmers`` option

where:

  - `OUTBASE` is a name meaningful to the user
  - `READLENGTH` is the k-mer length chosen by the user
  - `MISMATCHES` is the number of mismatches permitted during alignment,
    also set by the user.

Considerations for large genomes
--------------------------------

For large genomes (e.g. vertebrate, plant, or some *very* big amoebas):

  - crossmap can require a ton of memory if genome sequence is stored 
    in a fasta file. If crossmap maxes out your system's memory, it may
    be terminated by your system before it completes.

    Consider converting the file to a 2bit file to save memory and
    avoid this potential problem

  - Enabling mismatches with short read sizes will make crossmap take
    a lot longer, especially on large genomes. Consider using ``--mismatches
    0`` if you run into this problem 

  - Using multiple processes (e.g. via ``-p 2``) will speed crossmap's
    execution time, but will increase its memory footprint, as each process
    will need its own memory space to create and align k-mers from chromosomal
    sequence

  - By default, crossmap creates BED files. Consider converting these to
    BigBed files will save substantial amounts of time and memory in the future.

    This can be achieved using Jim Kent's ``bedToBigBed`` utility as follows
    (from the terminal)::

        $ bowtie-inspect --summary BOWTIE_INDEX  grep Sequence \
                         cut -f2,3 | sed -e "s/\([^ ]\+\).*\t/\1\t/"  >OUTFILE.sizes
        $ sort -k1,1 -k2,2n OUTBASE.bed > OUTBASE_sorted.bed
        $ bedToBigBed OUTBASE_sorted.bed OUTBASE.sizes OUTBASE_sorted.bb

    See https://github.com/ENCODE-DCC/kentUtils/tree/master/src/product/scripts
    for download & documentation of Kent utilities

------------------------------------------------------------------------------

positional arguments:
  ebwt                  Bowtie index of genome against which crossmap will be
                        made. In most cases, should be generated from the same
                        sequences that are in `sequence_file`.
  outbase               Basename for output files

optional arguments:
  -h, --help            show this help message and exit
  -k READ_LENGTH        K-mer length to generate from input file. (Default:
                        29)
  --offset OFFSET       Offset from 5' end of plus-strand read at which to
                        attribute score (Default: 14)
  --mismatches N        Number of mismatches tolerated in alignment. (Default:
                        0)
  --bowtie BOWTIE       Location of bowtie binary (Default: /usr/bin/bowtie)
  --have_kmers          If specified, use k-mer files from previous run. In
                        this case 'sequence_file' should be the value
                        'outbase' from the k-mer files you want to use.
                        (Default: False)
  --save_kmers          Save k-mer files for reuse in a subsequent run.
  -p N, --processes N   Number of processes to use (should be <= number of
                        chromosomes; default: 2)

warning/error options:
  -q, --quiet           Suppress all warning messages. Cannot use with '-v'.
  -v, --verbose         Increase verbosity. With '-v', show every warning.
                        With '-vv', turn warnings into exceptions. Cannot use
                        with '-q'. (Default: show each type of warning once)

sequence options:

  --sequence_file infile.[fasta | fastq | twobit | genbank | embl]
                        A file of DNA sequence
  --sequence_format {fasta,fastq,twobit,genbank,embl}
                        Format of sequence_file (Default: fasta).
```

## plastid_psite

### Tool Description
Estimate P-site offsets for each ribosome-protected footprint length from a ribosome profiling dataset.

### Metadata
- **Docker Image**: quay.io/biocontainers/plastid:0.6.1--py38h7d1810a_2
- **Homepage**: https://github.com/joshuagryphon/plastid
- **Package**: https://anaconda.org/channels/bioconda/packages/plastid/overview
- **Validation**: PASS

### Original Help Text
```text
usage: psite [-h] [-q] [-v] [--count_files COUNT_FILES [COUNT_FILES ...]]
             [--countfile_format {BAM}] [--sum SUM] [--min_length N]
             [--max_length N]
             [--figformat {eps,jpeg,jpg,pdf,pgf,png,ps,raw,rgba,svg,svgz,tif,tiff,webp}]
             [--figsize N N] [--title TITLE] [--cmap CMAP] [--dpi DPI]
             [--stylesheet {Solarize_Light2,_classic_test_patch,_mpl-gallery,_mpl-gallery-nogrid,bmh,classic,dark_background,fast,fivethirtyeight,ggplot,grayscale,seaborn-v0_8,seaborn-v0_8-bright,seaborn-v0_8-colorblind,seaborn-v0_8-dark,seaborn-v0_8-dark-palette,seaborn-v0_8-darkgrid,seaborn-v0_8-deep,seaborn-v0_8-muted,seaborn-v0_8-notebook,seaborn-v0_8-paper,seaborn-v0_8-pastel,seaborn-v0_8-poster,seaborn-v0_8-talk,seaborn-v0_8-ticks,seaborn-v0_8-white,seaborn-v0_8-whitegrid,tableau-colorblind10}]
             [--min_counts N] [--normalize_over N N] [--norm_region N N]
             [--require_upstream] [--constrain X X] [--aggregate] [--keep]
             [--default DEFAULT]
             roi_file outbase

------------------------------------------------------------------------------

This script estimates P-site offsets, stratified by read length,
in a ribosome profiling dataset. To do so, read alignments are mapped to
their fiveprime ends, and a metagene profile surrounding the start 
codon is calculated separately for each read length.

The start codon peak for each read length is heuristically identified as the
largest peak upstream of the start codon, or within a region defined by the user.
The distance between that peak and the start codon itself is taken to be the
P-site offset for that read length.

Notes
------
Generate an *ROI file first*
    This script requires an ROI file of maximal spanning windows
    surrounding each gene's start codon. This file can be generated by the
    ``generate`` subprogram of the metagene script.
    
Check the data
    Users should examine the graphical output to make sure the P-site estimates
    are reasonable, because if clear start codon peaks are not present in the
    data, the algorithm described above will have trouble.

For RNase I only
    This algorithm presumes that the RNase used to prepare the ribosome-protected
    footprints has no appreciable cutting bias, so that footprints may be
    clearly resolved to the edge of the ribosome.

Output files
------------
    OUTBASE_p_offsets.txt
        Tab-delimited text file with two columns. The first is read length,
        and the second the offset from the fiveprime end of that read length
        to the ribosomal P-site. This table can be supplied as the argument 
        for ``--offset`` when using ``--fiveprime_variable`` mapping in any
        of the other scripts in plastid.bin

    OUTBASE_p_offsets.[svg  png  pdf | et c]
        Plot of metagene profiles for each read length, when reads are mapped
        to their 5' ends, P-site offsets are applied.

    OUTBASE_metagene_profiles.txt
        Metagene profiles, stratified by read length, before P-site offsets
        are applied.

    OUTBASE_K_rawcounts.txt
        Saved if ``--keep`` is given on command line. Raw count vectors for each
        metagene window specified in input ROI file, without P-site
        mapping rules applied, for reads of length `K`

    OUTBASE_K_normcounts.txt
        Saved if ``--keep`` is given on command line. Normalized count vectors
        for each metagene window specified in input ROI file, without P-site
        mapping rules applied, for reads of length `K`

where `OUTBASE` is supplied by the user.

------------------------------------------------------------------------------

positional arguments:
  roi_file              ROI file surrounding start codons, from ``metagene
                        generate`` subprogram
  outbase               Basename for output files

optional arguments:
  -h, --help            show this help message and exit
  --min_counts N        Minimum counts required in normalization region to be
                        included in metagene average (Default: 10)
  --normalize_over N N  Portion of each window against which its individual
                        raw count profile will be normalized. Specify two
                        integers, in nucleotide distance from landmark
                        (negative for upstream, positive for downstream.
                        Surround negative numbers with quotes.). (Default: 20
                        50)
  --norm_region N N     Deprecated. Use ``--normalize_over`` instead.
                        Formerly, Portion of each window against which its
                        individual raw count profile will be normalized.
                        Specify two integers, in nucleotide distance, from 5'
                        end of window. (Default: 70 100)
  --require_upstream    If supplied, the P-site offset is taken to be the
                        distance between the largest peak upstream of the
                        start codon and the start codon itself. Otherwise, the
                        P-site offset is taken to be the distance between the
                        largest peak in the entire ROI and the start codon.
                        Ignored if ``--constrain`` is used.
  --constrain X X       Constrain P-site offset to be between specified
                        distance from start codon. Useful for noisy data.
                        (Reasonable set: 10 15; default: not constrained)
  --aggregate           Estimate P-site from aggregate reads at each position,
                        instead of median normalized read density. Noisier,
                        but helpful for lower-count data or read lengths with
                        few counts. (Default: False)
  --keep                Save intermediate count files. Useful for additional
                        computations (Default: False)
  --default DEFAULT     Default 5' P-site offset for read lengths that are not
                        present or evaluated in the dataset. Unaffected by
                        ``--constrain`` (Default: 13)

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

## plastid_metagene_generate

### Tool Description
Generate ROI file and genome-wide positions of start or stop codons (landmarks) for metagene analysis.

### Metadata
- **Docker Image**: quay.io/biocontainers/plastid:0.6.1--py38h7d1810a_2
- **Homepage**: https://github.com/joshuagryphon/plastid
- **Package**: https://anaconda.org/channels/bioconda/packages/plastid/overview
- **Validation**: PASS

### Original Help Text
```text
usage: metagene generate [-h] [-q] [-v]
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
                         [--landmark {cds_start,cds_stop}]
                         [--upstream UPSTREAM] [--downstream DOWNSTREAM]
                         [--group_by GROUP_BY]
                         outbase

------------------------------------------------------------------------------

Group regions of interest by a shared attribute, and generate
    maximal spanning windows for them. Results are given in a table
    suitable for use in ``count`` subprogram. Windows are generated by
    the following algorithm:

     1. Transcripts are grouped by `group_by` attribute (default: by gene).
        If all transcripts in a group share the same
        genomic coordinate for the landmark of interest (for example, if all 
        share the same start codon), then the set of transcripts is
        included in the analysis. If not, the set of transcripts and their
        associated gene are excluded from further processing.
    
     2. For each set of transcripts that pass step (1), the maximal spanning
        window is created by aligning the set of transcripts at the landmark, and
        adding nucleotide positions in transcript coordinates to the growing
        window in both 5' and 3' directions until either:
        
          - the next nucleotide position added is no longer corresponds to 
            the same genomic position in all transcripts
            
          - the window reaches the maximum user-specified size

------------------------------------------------------------------------------

positional arguments:
  outbase               Basename for output files

optional arguments:
  -h, --help            show this help message and exit
  --landmark {cds_start,cds_stop}
                        Landmark around which to build metagene profile
                        (Default: cds_start)
  --upstream UPSTREAM   Nucleotides to include upstream of landmark (Default:
                        50)
  --downstream DOWNSTREAM
                        Nucleotides to include downstream of landmark
                        (Default: 50)
  --group_by GROUP_BY   Attribute (e.g. in GTF2/GFF3 column 9) by which to
                        group regions before generating maximal spanning
                        windows (Default: group transcripts by gene using
                        'gene_id' attribute from GTF2, or 'Parent' attribute
                        in GFF3)

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

## plastid_metagene_count

### Tool Description
Count read densities around landmarks (for example start codons) and compute metagene profiles.

### Metadata
- **Docker Image**: quay.io/biocontainers/plastid:0.6.1--py38h7d1810a_2
- **Homepage**: https://github.com/joshuagryphon/plastid
- **Package**: https://anaconda.org/channels/bioconda/packages/plastid/overview
- **Validation**: PASS

### Original Help Text
```text
usage: metagene count [-h] [-q] [-v]
                      [--count_files COUNT_FILES [COUNT_FILES ...]]
                      [--countfile_format {BAM,bigwig,bowtie,wiggle}]
                      [--sum SUM] [--min_length N] [--max_length N]
                      [--maxmem MAXMEM] [--big_genome] [--fiveprime_variable]
                      [--fiveprime] [--threeprime] [--center]
                      [--offset OFFSET] [--nibble N]
                      [--figformat {eps,jpeg,jpg,pdf,pgf,png,ps,raw,rgba,svg,svgz,tif,tiff,webp}]
                      [--figsize N N] [--title TITLE] [--cmap CMAP]
                      [--dpi DPI]
                      [--stylesheet {Solarize_Light2,_classic_test_patch,_mpl-gallery,_mpl-gallery-nogrid,bmh,classic,dark_background,fast,fivethirtyeight,ggplot,grayscale,seaborn-v0_8,seaborn-v0_8-bright,seaborn-v0_8-colorblind,seaborn-v0_8-dark,seaborn-v0_8-dark-palette,seaborn-v0_8-darkgrid,seaborn-v0_8-deep,seaborn-v0_8-muted,seaborn-v0_8-notebook,seaborn-v0_8-paper,seaborn-v0_8-pastel,seaborn-v0_8-poster,seaborn-v0_8-talk,seaborn-v0_8-ticks,seaborn-v0_8-white,seaborn-v0_8-whitegrid,tableau-colorblind10}]
                      [--min_counts N] [--normalize_over N N]
                      [--norm_region N N] [--landmark LANDMARK] [--use_mean]
                      [--keep]
                      roi_file outbase

------------------------------------------------------------------------------

Calculate a metagene average over maximal spanning windows specified in `roi_table`, taking the following steps:

     1. The **raw counts** at each position in each maximal spanning window
        (from the ``generate`` subprogram) are totaled to create a raw count vector
        for the ROI.

     2. A **normalized count vector** is created fore each window by dividing
        its raw count vector by the total number of counts occurring within a
        user-defined normalization window within the window.
    
     3. A **metagene average** is created by taking aligning all of the
        normalized count vectors, and taking the median normalized counts
        over all vectors at each nucleotide position. Count vectors deriving
        from ROIs that don't meet a minimum count threshold (set via the
        ``--norm_region`` option) are excluded.

------------------------------------------------------------------------------

positional arguments:
  roi_file              Text file containing maximal spanning windows and
                        offsets, generated by the ``generate`` subprogram.
  outbase               Basename for output files

optional arguments:
  -h, --help            show this help message and exit
  --min_counts N        Minimum counts required in normalization region to be
                        included in metagene average (Default: 10)
  --normalize_over N N  Portion of each window against which its individual
                        raw count profile will be normalized. Specify two
                        integers, in nucleotide distance from landmark
                        (negative for upstream, positive for downstream.
                        Surround negative numbers with quotes.). (Default: 20
                        50)
  --norm_region N N     Deprecated. Use ``--normalize_over`` instead.
                        Formerly, Portion of each window against which its
                        individual raw count profile will be normalized.
                        Specify two integers, in nucleotide distance, from 5'
                        end of window. (Default: 70 100)
  --landmark LANDMARK   Name of landmark at zero point, optional.
  --use_mean            If supplied, use columnwise mean to generate profile
                        (Default: use median)
  --keep                Save intermediate count files. Useful for additional
                        computations (Default: False)

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
  --maxmem MAXMEM       Maximum desired memory footprint in MB to devote to
                        BigBed/BigWig files. May be exceeded by large queries.
                        (Default: 0, No maximum)
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

## plastid_cs_generate

### Tool Description
Generate a position file that assigns genomic positions to genes or transcripts for use with cs count.

### Metadata
- **Docker Image**: quay.io/biocontainers/plastid:0.6.1--py38h7d1810a_2
- **Homepage**: https://github.com/joshuagryphon/plastid
- **Package**: https://anaconda.org/channels/bioconda/packages/plastid/overview
- **Validation**: PASS

### Original Help Text
```text
usage: cs generate [-h] [-q] [-v]
                   [--annotation_files infile.[BED | BigBed | GTF2 | GFF3]
                   [infile.[BED | BigBed | GTF2 | GFF3] ...]]
                   [--annotation_format {BED,BigBed,GTF2,GFF3}] [--add_three]
                   [--tabix] [--sorted]
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
                   outbase

------------------------------------------------------------------------------

Generate gene position files from gene annotations.

     1. Genes whose transcripts share exons are first collapsed into merged
        genes.

     2. Within merged genes, all positions are classified. All positions are
        included in a set called *exon*. All positions that appear as coding
        regions in all transcripts (i.e. are never part of a 5'UTR or 3'UTR)
        included in a set called *CDS*. Similarly, all positions that appear
        as 5' UTR or 3' UTR in all transcripts are included in sets called
        *UTR5* or *UTR3*, respectively.

     3. Genomic positions that are overlapped by multiple merged genes are
        excluded from the position sets for those genes.

     4. If a mask file is supplied, positions annotated in the mask file
        are also excluded

     5. Output is given as a series of BED files and a `positions` file
        containing the same data.

------------------------------------------------------------------------------

positional arguments:
  outbase               Basename for output files

optional arguments:
  -h, --help            show this help message and exit

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

## plastid_cs_count

### Tool Description
Count read alignments and calculate read densities for genes and sub-regions (5' UTR, CDS, 3' UTR).

### Metadata
- **Docker Image**: quay.io/biocontainers/plastid:0.6.1--py38h7d1810a_2
- **Homepage**: https://github.com/joshuagryphon/plastid
- **Package**: https://anaconda.org/channels/bioconda/packages/plastid/overview
- **Validation**: PASS

### Original Help Text
```text
usage: cs count [-h] [-q] [-v] [--count_files COUNT_FILES [COUNT_FILES ...]]
                [--countfile_format {BAM,bigwig,bowtie,wiggle}] [--sum SUM]
                [--min_length N] [--max_length N] [--maxmem MAXMEM]
                [--big_genome] [--fiveprime_variable] [--fiveprime]
                [--threeprime] [--center] [--offset OFFSET] [--nibble N]
                file.positions outbase

------------------------------------------------------------------------------

Count the number and density covering each merged gene in an annotation
    made made using the `generate` subcommand).

------------------------------------------------------------------------------

positional arguments:
  file.positions        File assigning positions to genes or transcripts (made
                        using 'generate' subcommand)
  outbase               Basename for output files

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
  --maxmem MAXMEM       Maximum desired memory footprint in MB to devote to
                        BigBed/BigWig files. May be exceeded by large queries.
                        (Default: 0, No maximum)
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
```

## plastid_cs_chart

### Tool Description
Make charts of the output of cs count.

### Metadata
- **Docker Image**: quay.io/biocontainers/plastid:0.6.1--py38h7d1810a_2
- **Homepage**: https://github.com/joshuagryphon/plastid
- **Package**: https://anaconda.org/channels/bioconda/packages/plastid/overview
- **Validation**: PASS

### Original Help Text
```text
usage: cs chart [-h] [-q] [-v]
                [--figformat {eps,jpeg,jpg,pdf,pgf,png,ps,raw,rgba,svg,svgz,tif,tiff,webp}]
                [--figsize N N] [--title TITLE] [--cmap CMAP] [--dpi DPI]
                [--stylesheet {Solarize_Light2,_classic_test_patch,_mpl-gallery,_mpl-gallery-nogrid,bmh,classic,dark_background,fast,fivethirtyeight,ggplot,grayscale,seaborn-v0_8,seaborn-v0_8-bright,seaborn-v0_8-colorblind,seaborn-v0_8-dark,seaborn-v0_8-dark-palette,seaborn-v0_8-darkgrid,seaborn-v0_8-deep,seaborn-v0_8-muted,seaborn-v0_8-notebook,seaborn-v0_8-paper,seaborn-v0_8-pastel,seaborn-v0_8-poster,seaborn-v0_8-talk,seaborn-v0_8-ticks,seaborn-v0_8-white,seaborn-v0_8-whitegrid,tableau-colorblind10}]
                [-i INFILES [INFILES ...]] [--bins BINS [BINS ...]]
                [--regions REGIONS [REGIONS ...]]
                [--metrics METRICS [METRICS ...]]
                [gene_list.txt] outbase

------------------------------------------------------------------------------

Produce a set of charts comparing multiple samples pairwise.

    Charts include histograms of log2 fold changes and scatter plots with
    correlation coefficients, both generated for raw count and RPKM data.

------------------------------------------------------------------------------

positional arguments:
  gene_list.txt         Optional. File listing regions (genes or transcripts),
                        one per line, to include in comparisons. If not given,
                        all genes are included.
  outbase               Basename for output files

optional arguments:
  -h, --help            show this help message and exit
  -i INFILES [INFILES ...], --in INFILES [INFILES ...]
                        input files, made by 'count' subprogram
  --bins BINS [BINS ...]
                        Bins into which features are partitioned based on
                        counts
  --regions REGIONS [REGIONS ...]
                        Regions to compare (default: exon, utr5, cds, utr3)
  --metrics METRICS [METRICS ...]
                        Metrics to compare (default: rpkm, reads)

warning/error options:
  -q, --quiet           Suppress all warning messages. Cannot use with '-v'.
  -v, --verbose         Increase verbosity. With '-v', show every warning.
                        With '-vv', turn warnings into exceptions. Cannot use
                        with '-q'. (Default: show each type of warning once)

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

## plastid_get_count_vectors

### Tool Description
Get count vectors (per-nucleotide read counts) over regions of interest and save them as text or other formats.

### Metadata
- **Docker Image**: quay.io/biocontainers/plastid:0.6.1--py38h7d1810a_2
- **Homepage**: https://github.com/joshuagryphon/plastid
- **Package**: https://anaconda.org/channels/bioconda/packages/plastid/overview
- **Validation**: PASS

### Original Help Text
```text
usage: get_count_vectors [-h] [-q] [-v]
                         [--count_files COUNT_FILES [COUNT_FILES ...]]
                         [--countfile_format {BAM,bigwig,bowtie,wiggle}]
                         [--normalize] [--sum SUM] [--min_length N]
                         [--max_length N] [--big_genome]
                         [--fiveprime_variable] [--fiveprime] [--threeprime]
                         [--center] [--offset OFFSET] [--nibble N]
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
                         [--out_prefix OUT_PREFIX] [--format FORMAT]
                         out_folder

------------------------------------------------------------------------------

Fetch vectors of counts at each nucleotide position in one or more
regions of interest (ROIs).

Output files
------------
Vectors are saved as individual line-delimited files -- one position per line --
in a user-specified output folder. Each file is named for the ROI to which it
corresponds. If a mask file -- e.g. from  ~plastid.bin.crossmap
-- is provided, masked positions will be have value `nan` in output.

------------------------------------------------------------------------------

positional arguments:
  out_folder            Folder in which to save output vectors

optional arguments:
  -h, --help            show this help message and exit
  --out_prefix OUT_PREFIX
                        Prefix to prepend to output files (default: no prefix)
  --format FORMAT       printf-style format string for output (default:
                        '%.8f')

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
  --normalize           Whether counts should be normalized to counts per
                        million (usually not. default: False)
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

## plastid_gff_parent_types

### Tool Description
Export a table of parent-child feature relationships for all feature types found in a GFF3 file.

### Metadata
- **Docker Image**: quay.io/biocontainers/plastid:0.6.1--py38h7d1810a_2
- **Homepage**: https://github.com/joshuagryphon/plastid
- **Package**: https://anaconda.org/channels/bioconda/packages/plastid/overview
- **Validation**: PASS

### Original Help Text
```text
usage: gff_parent_types [-h] [-q] [-v] [--exclude EXCLUDE [EXCLUDE ...]]
                        infile.gff outfile.txt

------------------------------------------------------------------------------

Exports a table of parent-child feature relationships for all feature types
found in a GFF3 file. Features with multiple parents are sorted into a category
called `Multiple`.

------------------------------------------------------------------------------

positional arguments:
  infile.gff            Input GFF3 file
  outfile.txt           Name of output file

optional arguments:
  -h, --help            show this help message and exit
  --exclude EXCLUDE [EXCLUDE ...]
                        Feature types to exclude from consideration

warning/error options:
  -q, --quiet           Suppress all warning messages. Cannot use with '-v'.
  -v, --verbose         Increase verbosity. With '-v', show every warning.
                        With '-vv', turn warnings into exceptions. Cannot use
                        with '-q'. (Default: show each type of warning once)
```

## plastid_reformat_transcripts

### Tool Description
Convert transcript annotations between formats (BED, BigBed, GTF2, GFF3 to BED or GTF2).

### Metadata
- **Docker Image**: quay.io/biocontainers/plastid:0.6.1--py38h7d1810a_2
- **Homepage**: https://github.com/joshuagryphon/plastid
- **Package**: https://anaconda.org/channels/bioconda/packages/plastid/overview
- **Validation**: PASS

### Original Help Text
```text
usage: reformat_transcripts [-h] [-q] [-v]
                            [--annotation_files infile.[BED | BigBed | GTF2 | GFF3]
                            [infile.[BED | BigBed | GTF2 | GFF3] ...]]
                            [--annotation_format {BED,BigBed,GTF2,GFF3}]
                            [--add_three] [--tabix] [--sorted]
                            [--bed_extra_columns BED_EXTRA_COLUMNS [BED_EXTRA_COLUMNS ...]]
                            [--maxmem MAXMEM]
                            [--gff_transcript_types GFF_TRANSCRIPT_TYPES [GFF_TRANSCRIPT_TYPES ...]]
                            [--gff_exon_types GFF_EXON_TYPES [GFF_EXON_TYPES ...]]
                            [--gff_cds_types GFF_CDS_TYPES [GFF_CDS_TYPES ...]]
                            [--no_escape] [--output_format {BED,GTF2}]
                            [--extra_columns EXTRA_COLUMNS [EXTRA_COLUMNS ...]]
                            [--empty_value EMPTY_VALUE]
                            outfile.[bed | gtf]

------------------------------------------------------------------------------

Convert transcripts from BED, BigBed, GTF2, GFF3, or PSL format
to BED, extended BED, or GTF2 format.

 .. note::

    GFF3 schemas vary
        Different GFF3s have different schemas of hierarchy. By default, we
        assume the ontology used by the Sequence Ontology consortium. Users
        that require a different schema may supply `transcript_types` and
        `exon_types`, to indicate which sorts of features should be included.

    Identity relationships between elements vary between GFF3 files
        GFF3 files can represent discontiguous features using two strategies. In 
        one strategy, the exons of a transcript have unique IDs, but will share
        contain the same parent ID in their same `Parent` attribute in column 9
        of the GFF. In another strategy different exons of the same transcript
        simply share the same ID, and don't define a `Parent`. Here, both schemes
        are accepted, although what happens if they conflict within a single
        transcript is undefined.

------------------------------------------------------------------------------

positional arguments:
  outfile.[ bed | gtf ]
                        Output file

optional arguments:
  -h, --help            show this help message and exit
  --no_escape           If specified and output format is GTF2, special
                        characters in column 9 will be escaped (default: True)
  --output_format {BED,GTF2}
                        Format of output file. (default: GTF2)
  --extra_columns EXTRA_COLUMNS [EXTRA_COLUMNS ...]
                        Attributes (e.g. 'gene_id' to output as extra columns
                        in extended BED format (BED output only).
  --empty_value EMPTY_VALUE
                        Value to use of an attribute in `extra_columns` is not
                        defined for a particular record (Default: 'na'

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
```

## plastid_make_wiggle

### Tool Description
Convert read alignments or count files to wiggle or bedGraph files, applying a read mapping rule.

### Metadata
- **Docker Image**: quay.io/biocontainers/plastid:0.6.1--py38h7d1810a_2
- **Homepage**: https://github.com/joshuagryphon/plastid
- **Package**: https://anaconda.org/channels/bioconda/packages/plastid/overview
- **Validation**: PASS

### Original Help Text
```text
usage: make_wiggle [-h] [-q] [-v]
                   [--count_files COUNT_FILES [COUNT_FILES ...]]
                   [--countfile_format {BAM,bigwig,bowtie,wiggle}]
                   [--normalize] [--sum SUM] [--min_length N] [--max_length N]
                   [--maxmem MAXMEM] [--big_genome] [--fiveprime_variable]
                   [--fiveprime] [--threeprime] [--center] [--offset OFFSET]
                   [--nibble N] -o FILENAME [--window_size N] [--color COLOR]
                   [-t TRACK_NAME] [--output_format {bedgraph,variable_step}]

------------------------------------------------------------------------------

Create genome browser tracks from read alignments, using
mapping rules to extract the biology of interest
(e.g. ribosomal P-sites, et c) from the alignments.

Output files
------------
Tracks can be output in wiggle and bedGraph formats. Because these formats
are unstranded, two files are created:

    OUTBASE_fw.wig
        Counts at each position for the plus/forward strand of each chromosome
    
    OUTBASE_rc.wig
        Counts at each position for the minus/reverse strand of each chromosome

where `OUTBASE` is given by the user.

See also
--------
/concepts/mapping_rules
    Explanations of mapping rules and why they can be useful

plastid.genomics.map_factories
    For lists of mapping rules and their parameters

------------------------------------------------------------------------------

optional arguments:
  -h, --help            show this help message and exit
  -o FILENAME, --out FILENAME
                        Base name for output files
  --window_size N       Size of nucleotides to fetch at once for export. Large
                        values are faster but require more memory (Default:
                        100000)

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
  --normalize           Whether counts should be normalized to counts per
                        million (usually not. default: False)
  --sum SUM             Sum used in normalization of counts and RPKM/RPNT
                        calculations (Default: total mapped reads/counts in
                        dataset)
  --min_length N        Minimum read length required to be included (BAM &
                        bowtie files only. Default: 25)
  --max_length N        Maximum read length permitted to be included (BAM &
                        bowtie files only. Default: 100)
  --maxmem MAXMEM       Maximum desired memory footprint in MB to devote to
                        BigBed/BigWig files. May be exceeded by large queries.
                        (Default: 0, No maximum)
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

Browser track options:
  --color COLOR         An RGB hex string (`'#NNNNNN'`, `N` in `[0-9,A-F]`)
                        specifying the track color.
  -t TRACK_NAME, --track_name TRACK_NAME
                        Name to give browser track
  --output_format {bedgraph,variable_step}
                        Format of output file (Default: bedgraph)
```

## Metadata
- **Skill**: generated
