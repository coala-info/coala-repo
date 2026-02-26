# prooverlap CWL Generation Report

## prooverlap

### Tool Description
ProOvErlap

### Metadata
- **Docker Image**: quay.io/biocontainers/prooverlap:0.1.2--pyhdfd78af_0
- **Homepage**: https://github.com/ngualand/ProOvErlap
- **Package**: https://anaconda.org/channels/bioconda/packages/prooverlap/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/prooverlap/overview
- **Total Downloads**: 199
- **Last updated**: 2025-04-23
- **GitHub**: https://github.com/ngualand/ProOvErlap
- **Stars**: N/A
### Original Help Text
```text
usage: prooverlap [-h] --mode MODE --input INPUT --targets TARGETS
                  [--background BACKGROUND] [--randomization RANDOMIZATION]
                  [--genome GENOME] [--tmp TMP] --outfile OUTFILE --outdir
                  OUTDIR [--orientation ORIENTATION]
                  [--ov_fraction OV_FRACTION] [--generate_bg]
                  [--exclude_intervals EXCLUDE_INTERVALS] [--exclude_ov]
                  [--exclude_upstream] [--exclude_downstream] [--test_AT_GC]
                  [--test_lengths] [--GenomicLocalization] [--gtf GTF]
                  [--bed BED] [--RankTest] [--Ascending_RankOrder]
                  [--WeightRanking] [--alpha ALPHA] [--w W] [--thread THREAD]

ProOvErlap

options:
  -h, --help            show this help message and exit
  --mode MODE           Define mode: intersect or closest: intersect count the
                        number of overlapping elements while closest test the
                        distance. In closest mode if a feature overlap a
                        target the distance is 0, use --exclude_ov to test
                        only for non-overlapping regions
  --input INPUT         Input bed file, must contain 6 or more columns, name
                        and score can be placeholder but score is required in
                        --RankTest mode, strand is used only if some strandess
                        test are requested
  --targets TARGETS     Target bed file(s) (must contain 6 or more columns) to
                        test enrichement against, if multiple files are
                        supplied N independent test against each file are
                        conducted, file names must be comma separated, the
                        name of the file will be use as the name output
  --background BACKGROUND
                        Background bed file (must contain 6 or more columns),
                        should be a superset from wich input bed file is
                        derived
  --randomization RANDOMIZATION
                        Number of randomization, default: 100
  --genome GENOME       Genome fasta file used to retrieve sequence features
                        like AT or GC content and length, needed only for
                        length or AT/GC content tests
  --tmp TMP             Temporary directory for storing intermediate files.
                        Default is current working directory
  --outfile OUTFILE     Full path to the output file to store final results in
                        tab format
  --outdir OUTDIR       Full path to output directory to store tables for
                        plot, it is suggested to use a different directory for
                        each analysis. It will be created
  --orientation ORIENTATION
                        Name of test(s) to be performed: concordant,
                        discordant, strandless, or a combination of them. If
                        multiple tests are required tests names must be comma
                        separated, no space allowed
  --ov_fraction OV_FRACTION
                        Minimum overlap required as a fraction from input BED
                        file to consider 2 features as overlapping. Default is
                        1E-9 (i.e. 1bp)
  --generate_bg         This option activatates the generation of random bed
                        intervals to test enrichment against, use this instead
                        of background. Use only if background file cannot be
                        used or is not available
  --exclude_intervals EXCLUDE_INTERVALS
                        Exclude regions overlapping with regions in the
                        supplied BED file
  --exclude_ov          Exclude overlapping regions between Input and Target
                        file in closest mode
  --exclude_upstream    Exclude upstream region in closest mode, only for
                        stranded files, not compatible with exclude_downstream
  --exclude_downstream  Exclude downstream region in closest mode, only for
                        stranded files, not compatible with exclude_upstream
  --test_AT_GC          Test AT and GC content
  --test_lengths        Test feature length
  --GenomicLocalization
                        Test also the genomic localization and enrichment of
                        founded overlaps, i.e TSS,Promoter,exons,introns,UTRs
                        - Available only in intersect mode. Must provide a GTF
                        file to extract genomic regions (--gtf), alternatively
                        directly provide a bed file (--bed) with custom
                        annotations
  --gtf GTF             GTF file, only to test genomic localization of founded
                        overlap, gtf file will be used to create genomic
                        regions: promoter, tss, exons, intron, 3UTR and 5UTR
  --bed BED             BED file, only to test genomic localization of founded
                        overlap, bed file will be used to test enrichment in
                        different genomic regions, annotation must be stored
                        as 4th column in bed file, i.e name field
  --RankTest            Activates the Ranking analyis, require BED to contain
                        numerical value in 4th column
  --Ascending_RankOrder
                        Activate the Sort Ascending in RankTest analysis
  --WeightRanking       Weight the ranking test, this is done by increase or
                        decrease the score value in the BED file based on
                        their relative rank and/or distance and/or fractional
                        overlap
  --alpha ALPHA         Relative Influence of the overlap fraction/distance
                        (with respect to ranking) in weightRanked test, only
                        if --WeightRanking is active, must be between 0 and 1
  --w W                 Strength of the Weight for the ranking test, only if
                        --WeightRanking is active, must be between 0 and 1
  --thread THREAD       Number of Threads for parallel computation
```

