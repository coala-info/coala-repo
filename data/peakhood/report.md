# peakhood CWL Generation Report

## peakhood_extract

### Tool Description
Extract transcript and genomic context for CLIP-seq peak regions using BAM coverage and GTF annotations.

### Metadata
- **Docker Image**: quay.io/biocontainers/peakhood:0.3--pyhdfd78af_0
- **Homepage**: https://github.com/BackofenLab/Peakhood
- **Package**: https://anaconda.org/channels/bioconda/packages/peakhood/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/peakhood/overview
- **Total Downloads**: 8.2K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/BackofenLab/Peakhood
- **Stars**: N/A
### Original Help Text
```text
usage: peakhood extract [-h] --in str --bam str [str ...] --gtf str --gen str
                        --out str [--site-id str [str ...]] [--thr float]
                        [--thr-rev-filter] [--max-len int]
                        [--min-exon-overlap float] [--min-ei-ratio float]
                        [--min-eib-ratio float] [--eib-width int]
                        [--eibr-mode {1,2}] [--no-eibr-filter]
                        [--no-eir-wt-filter] [--no-eibr-wt-filter]
                        [--bam-pp-mode {1,2,3}] [--read-pos-mode {1,2,3}]
                        [--tbt-filter-ids str [str ...]] [--no-biotype-filter]
                        [--discard-single-ex-tr] [--isr-ext-mode {1,2}]
                        [--isr-max-reg-len int] [--no-isr-double-count]
                        [--no-isr-sub-count] [--min-exbs-isr-c int]
                        [--no-tis-filter] [--min-tis-sites int]
                        [--f1-filter str [str ...]] [--no-f1-filter]
                        [--f2-filter str [str ...]] [--f2-mode {1,2}]
                        [--isrn-prefilter int] [--merge-mode {1,2}]
                        [--merge-ext int] [--pre-merge]
                        [--seq-ext-mode {1,2,3}] [--seq-ext int]
                        [--rnaseq-bam str] [--rnaseq-bam-rev] [--keep-bam]
                        [--new-site-id str] [--data-id str] [--report]

optional arguments:
  -h, --help            show this help message and exit
  --site-id str [str ...]
                        Provide site ID(s) from --in (BED column 4) (e.g.
                        --site-id CLIP85 CLIP124 ) and run peakhood extract
                        only for these regions
  --thr float           Minimum site score (--in BED column 5) for filtering
                        (assuming higher score == better site) (default: None)
  --thr-rev-filter      Reverse --thr filtering (i.e. the lower the better,
                        e.g. for p-values) (default: False)
  --max-len int         Maximum length of --in sites (default: 250)
  --min-exon-overlap float
                        Minimum exon overlap of a site to be considered for
                        transcript context extraction (intersectBed -f
                        parameter) (default: 0.9)
  --min-ei-ratio float  Minimum exon to neighboring intron coverage for exonic
                        site to be reported as exonic site with transcript
                        context (default: 4)
  --min-eib-ratio float
                        Minimum exon border to neighboring intron border
                        region coverage for an exon to be considered for
                        transcript context selection (default: 4)
  --eib-width int       Width of exon-intron border regions (EIB) to calculate
                        coverage drops from exon to intron region (default:
                        20)
  --eibr-mode {1,2}     How to extract the exon-intron border ratio of an
                        exon. 1: return the exon-intro border ratio with the
                        higher coverage. 2: average the two exon-intron border
                        ratios of the exon (default: 1)
  --no-eibr-filter      Disable exon-intron border ratio (EIBR) filtering of
                        exons. By default, exons with low EIBR are not
                        considered for transcript context selection
  --no-eir-wt-filter    Disable exon-intron ratio filtering by checking the
                        ratios of whole transcripts (all transcript exons)
  --no-eibr-wt-filter   Disable exon-intron border ratio filtering by checking
                        the ratios of whole transcripts (all transcript exons)
  --bam-pp-mode {1,2,3}
                        Define type of preprocessing for read-in --bam files.
                        1: no preprocessing (just merge if several given). 2:
                        use only R2 reads for site context extraction (for
                        eCLIP data) 3: use only R1 reads for site context
                        extraction (e.g. for iCLIP data) (default: 1)
  --read-pos-mode {1,2,3}
                        Define which BAM read part to take for overlap and
                        coverage calculations. 1: full-length read. 2: 5' end
                        of the read. 2: center position of the read (default:
                        1)
  --tbt-filter-ids str [str ...]
                        Manually provide transcript biotype ID(s) to filter
                        out transcripts with these biotypes (e.g. --tbt-
                        filter-ids nonsense_mediated_decay retained_intron
                        non_stop_decay). By default,
                        "nonsense_mediated_decay", "retained_intron",
                        "non_stop_decay", and "processed_transcript" are used
                        for filtering
  --no-biotype-filter   Disable transcript biotype filter. By default, if
                        biotype information is given inside --gtf, transcripts
                        with biotypes "nonsense_mediated_decay",
                        "retained_intron", "non_stop_decay", and
                        "processed_transcript" are not considered for
                        transcript context selection
  --discard-single-ex-tr
                        Exclude single exon transcripts from transcript
                        context selection (default: False)
  --isr-ext-mode {1,2}  Define which portions of intron-spanning reads to use
                        for overlap calculations. 1: use whole matching
                        region. 2: use end positions only (at exon ends). If 1
                        is set, maximum region length is further controlled by
                        --isr-max-reg-len (default: 1)
  --isr-max-reg-len int
                        Set maximum region length for intron-spanning read
                        matches. This means that if intron-spanning read match
                        on exon is 15, and --isr-max-reg-len 10, shorten the
                        match region to 10. Set to 0 to deactivate, i.e.,
                        always use full match lengths for coverage
                        calculations (default: 10)
  --no-isr-double-count
                        Do not count intron-spanning reads twice for intron-
                        exon coverage calculations (default: False)
  --no-isr-sub-count    Do not substract the intron-spanning read count from
                        the intronic read count of the intron for intron-exon
                        coverage calculations (default: False)
  --min-exbs-isr-c int  Minimum intron-spanning read count to connect two
                        sites at adjacent exon borders. Exon border sites
                        featuring >= --min-exbs-isr-c will be merged into one
                        site (default: 2)
  --no-tis-filter       Do not discard transcripts containing intronic sites
                        from transcript context selection
  --min-tis-sites int   Minimum number of intronic sites needed per transcript
                        to assign all sites on the transcript to genomic
                        context (default: 2)
  --f1-filter str [str ...]
                        Define F1 filters to be applied for F1 transcript
                        selection filtering (F1: sequential filtering). e.g.
                        --f1-filter TSC ISRN (order matters!) (default: TSC)
  --no-f1-filter        Disable F1 sequential filtering step
  --f2-filter str [str ...]
                        Define F2 filters to be applied for F2 transcript
                        selection filtering (F2: sequential or majority vote
                        filtering, set with --f2-mode). Set order matters only
                        if --f2-mode 2 (default: EIR ISRN ISR ISRFC SEO FUCO
                        TCOV)
  --f2-mode {1,2}       Define transcript selection strategy for a given
                        exonic site during F2 filtering. (1) majority vote
                        filtering, (2) sequential filtering. (default: 1)
  --isrn-prefilter int  Enable prefilerting of exons (before F1, F2) by exon
                        neigbhorhood intron-spanning read count. A minimum
                        number of intron-spanning reads to neighboring exons
                        has to be provided, e.g. --isr-prefilter 5 (default:
                        False)
  --merge-mode {1,2}    Defines whether or how to merge nearby sites before
                        applying --seq-ext. The merge operation is done
                        separately for genomic and transcript context sites,
                        AFTER extracting transcript context extraction. For
                        pre-merging check out --pre-merge option. (1) Do NOT
                        merge sites, (2) merge overlapping and adjacent sites
                        (merge distance controlled by --merge-ext). For an
                        overlapping set of sites, the site with highest column
                        5 BED score is chosen, and the others discarded. NOTE
                        that if no BED scores are given, merge is done by
                        alphabetical ordering of site IDs (default: 1)
  --merge-ext int       Extend regions by --merge-ext before merging
                        overlapping regions (if --merge-mode 2) (default: 0)
  --pre-merge           Merge book-ended and overlapping --in sites BEFORE
                        transcript context extraction. In contrast to --merge-
                        mode 2, do not choose the best site from a set of
                        overlapping sites, but keep the entire region for each
                        overlapping set
  --seq-ext-mode {1,2,3}
                        Define mode for site context sequence extraction after
                        determining context. (1) Take the complete site, (2)
                        Take the center of each site, (3) Take the upstream
                        end for each site (default: 1)
  --seq-ext int         Up- and downstream sequence extension length of sites
                        (site definition by --seq-ext-mode) (default: 0)
  --rnaseq-bam str      RNA-Seq BAM file to extract additional intron-spanning
                        reads from
  --rnaseq-bam-rev      Enable if --rnaseq-bam reads are reverse strand-
                        specific (reads mapping to reverse strand of
                        corresponding transcript feature) (default: False)
  --keep-bam            Keep filtered BAM files in --out folder (default:
                        False)
  --new-site-id str     Generate new IDs with stem ID --new-site-id to
                        exchange --in BED column 4 site IDs. NOTE that site
                        IDs have to be unique if --new-site-id is not
                        provided. Defines first part of site ID for assigning
                        new site IDs, E.g. --new-site-id RBP1 will result in
                        new site IDs RBP1_1, RBP1_2, etc. (default: False)
  --data-id str         Define dataset ID for the input dataset to be stored
                        in --out folder. This will later be used as dataset ID
                        in peakhood merge for assigning new site IDs. By
                        default, the dataset ID is extracted from the --in
                        file name
  --report              Generate an .html report containing various additional
                        statistics and plots (default: False)

required arguments:
  --in str              Genomic CLIP-seq peak regions file in BED format
                        (6-column BED)
  --bam str [str ...]   BAM file or list of BAM files (--bam rep1.bam rep2.bam
                        .. ) containing CLIP-seq library reads used for
                        estimating --in site context
  --gtf str             Genomic annotations GTF file (.gtf or .gtf.gz)
  --gen str             Genomic sequences .2bit file
  --out str             Site context extraction results output folder
```


## peakhood_merge

### Tool Description
Merge peakhood results

### Metadata
- **Docker Image**: quay.io/biocontainers/peakhood:0.3--pyhdfd78af_0
- **Homepage**: https://github.com/BackofenLab/Peakhood
- **Package**: https://anaconda.org/channels/bioconda/packages/peakhood/overview
- **Validation**: PASS

### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
Matplotlib created a temporary config/cache directory at /tmp/matplotlib-spe9wxi_ because the default path (/user/qianghu/.cache/matplotlib) is not a writable directory; it is highly recommended to set the MPLCONFIGDIR environment variable to a writable directory, in particular to speed up the import of Matplotlib and to better support multiprocessing.
usage: peakhood merge [-h] --in str [str ...] --out str [--gtf str] [--report]
peakhood merge: error: argument -h/--help: ignored explicit argument 'elp'
```


## peakhood_batch

### Tool Description
Batch processing for peakhood to extract transcript context and genomic context for sites using BAM, BED, GTF, and genomic sequence files.

### Metadata
- **Docker Image**: quay.io/biocontainers/peakhood:0.3--pyhdfd78af_0
- **Homepage**: https://github.com/BackofenLab/Peakhood
- **Package**: https://anaconda.org/channels/bioconda/packages/peakhood/overview
- **Validation**: PASS

### Original Help Text
```text
usage: peakhood batch [-h] --in str --gtf str --gen str --out str
                      [--thr float] [--thr-rev-filter] [--max-len int]
                      [--min-exon-overlap float] [--min-ei-ratio float]
                      [--min-eib-ratio float] [--eib-width int]
                      [--eibr-mode {1,2}] [--no-eibr-filter]
                      [--no-eir-wt-filter] [--no-eibr-wt-filter]
                      [--bam-pp-mode {1,2,3}] [--read-pos-mode {1,2,3}]
                      [--tbt-filter-ids str [str ...]] [--no-biotype-filter]
                      [--min-exbs-isr-c int] [--no-tis-filter]
                      [--min-tis-sites int] [--f1-filter str [str ...]]
                      [--no-f1-filter] [--f2-filter str [str ...]]
                      [--f2-mode {1,2}] [--isrn-prefilter int]
                      [--isr-ext-mode {1,2}] [--isr-max-reg-len int]
                      [--merge-mode {1,2}] [--merge-ext int] [--pre-merge]
                      [--seq-ext-mode {1,2,3}] [--seq-ext int]
                      [--rnaseq-bam str] [--rnaseq-bam-rev] [--new-ids]
                      [--add-gtf str] [--threads int] [--report]

optional arguments:
  -h, --help            show this help message and exit
  --thr float           Minimum site score (--in BED files column 5) for
                        filtering (assuming higher score == better site)
                        (default: None)
  --thr-rev-filter      Reverse --thr filtering (i.e. the lower the better,
                        e.g. for p-values) (default: False)
  --max-len int         Maximum length of --in sites (default: 250)
  --min-exon-overlap float
                        Minimum exon overlap of a site to be considered for
                        transcript context extraction (intersectBed -f
                        parameter) (default: 0.9)
  --min-ei-ratio float  Minimum exon to neighboring intron coverage for exonic
                        site to be reported as exonic site with transcript
                        context (default: 4)
  --min-eib-ratio float
                        Minimum exon border to neighboring intron border
                        region coverage for an exon to be considered for
                        transcript context selection (default: 4)
  --eib-width int       Width of exon-intron border regions (EIB) to calculate
                        coverage drops from exon to intron region (default:
                        20)
  --eibr-mode {1,2}     How to extract the exon-intron border ratio of an
                        exon. 1: return the exon-intro border ratio with the
                        higher coverage. 2: average the two exon-intron border
                        ratios of the exon (default: 1)
  --no-eibr-filter      Disable exon-intron border ratio (EIBR) filtering of
                        exons. By default, exons with low EIBR are not
                        considered for transcript context selection
  --no-eir-wt-filter    Disable exon-intron ratio filtering by checking the
                        ratios of whole transcripts (all transcript exons)
  --no-eibr-wt-filter   Disable exon-intron border ratio filtering by checking
                        the ratios of whole transcripts (all transcript exons)
  --bam-pp-mode {1,2,3}
                        Define type of preprocessing for read-in --bam files.
                        1: no preprocessing (just merge if several given). 2:
                        use only R2 reads for site context extraction (for
                        eCLIP data) 3: use only R1 reads for site context
                        extraction (e.g. for iCLIP data) (default: 1)
  --read-pos-mode {1,2,3}
                        Define which BAM read part to take for overlap and
                        coverage calculations. 1: full-length read. 2: 5' end
                        of the read. 2: center position of the read (default:
                        1)
  --tbt-filter-ids str [str ...]
                        Manually provide transcript biotype ID(s) to filter
                        out transcripts with these biotypes (e.g. --tbt-
                        filter-ids nonsense_mediated_decay retained_intron
                        non_stop_decay). By default,
                        "nonsense_mediated_decay", "retained_intron",
                        "non_stop_decay", and "processed_transcript" are used
                        for filtering
  --no-biotype-filter   Disable transcript biotype filter. By default, if
                        biotype information is given inside --gtf, transcripts
                        with biotypes "nonsense_mediated_decay",
                        "retained_intron", "non_stop_decay", and
                        "processed_transcript" are not considered for
                        transcript context selection
  --min-exbs-isr-c int  Minimum intron-spanning read count to connect two
                        sites at adjacent exon borders. Exon border sites
                        featuring >= --min-exbs-isr-c will be merged into one
                        site (default: 2)
  --no-tis-filter       Do not discard transcripts containing intronic sites
                        from transcript context selection
  --min-tis-sites int   Minimum number of intronic sites needed per transcript
                        to assign all sites on the transcript to genomic
                        context (default: 2)
  --f1-filter str [str ...]
                        Define F1 filters to be applied for F1 transcript
                        selection filtering (F1: sequential filtering). e.g.
                        --f1-filter TSC ISRN (order matters!) (default: TSC)
  --no-f1-filter        Disable F1 sequential filtering step
  --f2-filter str [str ...]
                        Define F2 filters to be applied for F2 transcript
                        selection filtering (F2: sequential or majority vote
                        filtering, set with --f2-mode). Set order matters only
                        if --f2-mode 2 (default: EIR ISRN ISR ISRFC SEO FUCO
                        TCOV)
  --f2-mode {1,2}       Define transcript selection strategy for a given
                        exonic site during F2 filtering. (1) majority vote
                        filtering, (2) sequential filtering. (default: 1)
  --isrn-prefilter int  Enable prefilerting of exons (before F1, F2) by exon
                        neigbhorhood intron-spanning read count. A minimum
                        number of intron-spanning reads to neighboring exons
                        has to be provided, e.g. --isr-prefilter 5 (default:
                        False)
  --isr-ext-mode {1,2}  Define which portions of intron-spanning reads to use
                        for overlap calculations. 1: use whole matching
                        region. 2: use end positions only (at exon ends). If 1
                        is set, maximum region length is further controlled by
                        --isr-max-reg-len (default: 1)
  --isr-max-reg-len int
                        Set maximum region length for intron-spanning read
                        matches. This means that if intron-spanning read match
                        on exon is 15, and --isr-max-reg-len 10, shorten the
                        match region to 10. Set to 0 to deactivate, i.e.,
                        always use full match lengths for coverage
                        calculations (default: 10)
  --merge-mode {1,2}    Defines whether or how to merge nearby sites before
                        applying --seq-ext. The merge operation is done
                        separately for genomic and transcript context sites,
                        AFTER extracting transcript context extraction. For
                        pre-merging check out --pre-merge option. (1) Do NOT
                        merge sites, (2) merge overlapping and adjacent sites
                        (merge distance controlled by --merge-ext). For an
                        overlapping set of sites, the site with highest column
                        5 BED score is chosen, and the others discarded. NOTE
                        that if no BED scores are given, merge is done by
                        alphabetical ordering of site IDs (default: 1)
  --merge-ext int       Extend regions by --merge-ext before merging
                        overlapping regions (if --merge-mode 2) (default: 0)
  --pre-merge           Merge book-ended and overlapping --in sites BEFORE
                        transcript context extraction. In contrast to --merge-
                        mode 2, do not choose the best site from a set of
                        overlapping sites, but keep the entire region for each
                        overlapping set
  --seq-ext-mode {1,2,3}
                        Define mode for site context sequence extraction after
                        determining context. (1) Take the complete site, (2)
                        Take the center of each site, (3) Take the upstream
                        end for each site (default: 1)
  --seq-ext int         Up- and downstream sequence extension length of sites
                        (site definition by --seq-ext-mode) (default: 0)
  --rnaseq-bam str      RNA-Seq BAM file to extract additional intron-spanning
                        reads from
  --rnaseq-bam-rev      Enable if --rnaseq-bam reads are reverse strand-
                        specific (reads mapping to reverse strand of
                        corresponding transcript feature) (default: False)
  --new-ids             Generate new IDs to exchange --in BED column 4 site
                        IDs. Use dataset ID from --in file names as stem (see
                        --in option). NOTE that site IDs have to be unique if
                        --new-site-id is not set (default: False)
  --add-gtf str         Additional genomic annotations GTF file (.gtf or
                        .gtf.gz) for transcript to gene region annotation
                        (corresponding to peakhood merge --gtf)
  --threads int         Number of threads used for batch processing. --threads
                        determines the maximum number of extraction jobs run
                        in parallel (depending on number of CPU threads and
                        number of --in datasets available). Note that the more
                        jobs are run in parallel, the higher the memory
                        consumption (default: 1)
  --report              Generate .html reports for extract and merge,
                        containing dataset statistics and plots (default:
                        False)

required arguments:
  --in str              Input folder containing BAM and BED files for batch
                        processing. Naming convention: datasetid_rep1.bam,
                        datasetid_rep2.bam, ... and datasetid.bed
  --gtf str             Genomic annotations GTF file (.gtf or .gtf.gz)
  --gen str             Genomic sequences .2bit file
  --out str             Results output folder
```


## peakhood_motif

### Tool Description
Search for motifs or regular expressions in genomic or transcript sequences based on peakhood extract output, BED files, or transcript lists.

### Metadata
- **Docker Image**: quay.io/biocontainers/peakhood:0.3--pyhdfd78af_0
- **Homepage**: https://github.com/BackofenLab/Peakhood
- **Package**: https://anaconda.org/channels/bioconda/packages/peakhood/overview
- **Validation**: PASS

### Original Help Text
```text
usage: peakhood motif [-h] --in str --motif str [--gtf str] [--gen str]
                      [--out str] [--stats-out str] [--data-id str]

optional arguments:
  -h, --help       show this help message and exit
  --gtf str        Genomic annotations GTF file (.gtf or .gtf.gz). Required
                   for --in type (2) or (3)
  --gen str        Genomic sequences .2bit file. Required for --in type (2) or
                   (3)
  --out str        Output results folder, to store motif hit regions in BED
                   files
  --stats-out str  Output table to store motif search results in (for --in
                   type (1) (requires --data-id to be set). If table exists,
                   append results row to table
  --data-id str    Data ID (column 1) for --stats-out output table to store
                   motif search results (requires --stats-out to be set)

required arguments:
  --in str         Three different inputs possible: (1) output folder of
                   peakhood extract with genomic and transcript context
                   sequence sets in which to look for given --motif. (2) BED
                   file (genomic or transcript regions) in which to look for
                   given --motif. (3) Transcript list file, to search for
                   --motif in the respective transcript sequences. Note that
                   (2)+(3) need --gtf and --gen.
  --motif str      Motif or regular expression (RNA letters!) to search for in
                   --in folder context sequences (e.g. --motif '[AC]UGCUAA')
```


## Metadata
- **Skill**: generated
