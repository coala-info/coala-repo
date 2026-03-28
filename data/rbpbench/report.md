# rbpbench CWL Generation Report

## rbpbench_search

### Tool Description
Search for RBP motifs in genomic regions.

### Metadata
- **Docker Image**: quay.io/biocontainers/rbpbench:1.1.0--pyhdfd78af_0
- **Homepage**: https://github.com/michauhl/RBPBench
- **Package**: https://anaconda.org/channels/bioconda/packages/rbpbench/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/rbpbench/overview
- **Total Downloads**: 14.9K
- **Last updated**: 2026-01-26
- **GitHub**: https://github.com/michauhl/RBPBench
- **Stars**: N/A
### Original Help Text
```text
usage: rbpbench search [-h] --in str --rbps str [str ...] --genome str --out
                       str [--data-id str] [--method-id str] [--run-id str]
                       [--user-rbp-id str] [--user-meme-xml str]
                       [--user-cm str] [--ext str] [--motif-db {1,2,3}]
                       [--custom-db str] [--custom-db-id str]
                       [--custom-db-meme-xml str] [--custom-db-cm str]
                       [--custom-db-info str] [--motifs str [str ...]]
                       [--motif-min-len int] [--motif-max-len int]
                       [--functions str [str ...]] [--regex str]
                       [--regex-id str] [--motif-regex-id]
                       [--regex-type {1,2,3}] [--regex-search-mode {1,2}]
                       [--regex-min-gc float] [--regex-max-gu float]
                       [--regex-spacer-min int] [--regex-spacer-max int]
                       [--fimo-ntf-file str] [--fimo-ntf-mode {1,2,3}]
                       [--fimo-pval float] [--cmsearch-bs float]
                       [--cmsearch-mode {1,2}] [--greatest-hits]
                       [--bed-score-col int] [--bed-sc-thr float]
                       [--bed-sc-thr-rev] [--wrs-mode {1,2}]
                       [--fisher-mode {1,2,3}] [--unstranded]
                       [--unstranded-ct] [--plot-motifs] [--top-n-matched int]
                       [--cooc-pval-thr float] [--cooc-pval-mode {1,2,3}]
                       [--min-motif-dist int] [--max-motif-dist int]
                       [--disable-len-dist-plot] [--disable-kmer-tb-plot]
                       [--kmer-tb-plot-top-n int]
                       [--kmer-tb-plot-bottom-n int] [--disable-kmer-var-plot]
                       [--kmer-var-color-mode {1,2}] [--kmer-plot-k int]
                       [--enable-upset-plot] [--upset-plot-min-degree int]
                       [--upset-plot-max-degree int]
                       [--upset-plot-min-subset-size int]
                       [--upset-plot-max-subset-rank int]
                       [--upset-plot-max-rbp-rank int]
                       [--upset-plot-min-rbp-count int] [--gtf str]
                       [--tr-list str] [--tr-types str [str ...]]
                       [--gtf-feat-min-overlap float]
                       [--gtf-intron-border-len int]
                       [--gtf-min-mrna-overlap float] [--exp-gene-list str]
                       [--exp-gene-filter] [--exp-gene-filter-mode {1,2}]
                       [--mrna-norm-mode {1,2}] [--disable-all-reg-bar]
                       [--disable-kmer-pca-plot] [--kmer-pca-plot-k int]
                       [--kmer-pca-plot-no-comp]
                       [--kmer-pca-plot-comp-k {1,2}]
                       [--kmer-pca-plot-no-motifs] [--set-rbp-id str]
                       [--motif-distance-plot-range int]
                       [--motif-min-pair-count int] [--rbp-min-pair-count int]
                       [--goa] [--goa-obo-mode {1,2,3}] [--goa-obo-file str]
                       [--goa-gene2go-file str] [--goa-pval float]
                       [--goa-cooc-mode {1,2,3}] [--goa-bg-gene-list str]
                       [--goa-max-child int] [--goa-min-depth int]
                       [--goa-filter-purified] [--plot-abs-paths]
                       [--prom-min-tr-len int] [--prom-mrna-only]
                       [--prom-both-str] [--prom-ext str]
                       [--add-annot-bed str] [--add-annot-comp]
                       [--add-annot-id str] [--plot-pdf] [--meme-no-check]
                       [--meme-no-pgc] [--plotly-js-mode {1,2,3,4,5,6,7}]
                       [--sort-js-mode {1,2,3}]

options:
  -h, --help            show this help message and exit
  --data-id str         Dataset ID to describe dataset, e.g. --data-id
                        PUM2_eCLIP_K562, used in output tables and for
                        generating the comparison reports (rbpbench compare)
  --method-id str       Method ID to describe peak calling method, e.g.
                        --method-id clipper_idr, used in output tables and for
                        generating the comparison reports (rbpbench compare)
  --run-id str          Run ID to describe rbpbench search job, e.g. --run-id
                        RBP1_eCLIP_tool1, used in output tables and reports
  --user-rbp-id str     Provide RBP ID belonging to provided sequence or
                        structure motif(s) (mandatory for --rbps USER)
  --user-meme-xml str   Provide MEME/DREME XML file containing sequence
                        motif(s) to be used for the run (needs --rbps USER)
  --user-cm str         Provide covariance model (.cm) file containing
                        covariance model(s) to be used for the run (needs
                        --rbps USER)
  --ext str             Up- and downstream extension of --in sites in
                        nucleotides (nt). Set e.g. --ext 30 for 30 nt on both
                        sides, or --ext 20,10 for different up- and downstream
                        extension (default: 0)
  --motif-db {1,2,3}    Built-in motif database to use. 1: human RBP motifs
                        (257 RBPs, 599 motifs,
                        "catrapid_omics_v2.1_human_6plus_ext"), 2: human RBP
                        motifs + 23 ucRBP motifs (277 RBPs, 622 motifs,
                        "catrapid_omics_v2.1_human_6plus_ext_ucrbps"), 3:
                        human RBP motifs from Ray et al 2013 (80 RBPs, 102
                        motifs, "ray2013_human_rbps_rnacompete") (default: 1)
  --custom-db str       Provide custom motif database folder. Alternatively,
                        provide single files via --custom-db-meme-xml,
                        --custom-db-cm, --custom-db-info
  --custom-db-id str    Set ID/name for provided custom motif database via
                        --custom-db (default: "custom")
  --custom-db-meme-xml str
                        Provide custom motif database MEME/DREME XML file
                        containing sequence motifs
  --custom-db-cm str    Provide custom motif database covariance model (.cm)
                        file containing covariance model(s)
  --custom-db-info str  Provide custom motif database info table file
                        containing RBP ID -> motif ID -> motif type
                        assignments
  --motifs str [str ...]
                        Provide IDs for motifs of interest (need to be in
                        database and loaded). All other RBP motifs will be
                        discarded (except --regex)
  --motif-min-len int   Minimum MEME/DREME motif length to include in search.
                        By default all selected RBP motifs are used
  --motif-max-len int   Maximum MEME/DREME motif length to include in search.
                        By default all selected RBP motifs are used
  --functions str [str ...]
                        Filter defined RBPs (via --rbps) by their molecular
                        functions (annotations available for most database
                        RBPs). E.g. for RBPs in splicing regulation, set
                        --functions SR, for RBPs in RNA stability & decay plus
                        translation regulation, set --functions RSD TR (see
                        rbpbench info for full function descriptions). NOTE
                        that --regex is not affected by filtering
  --regex str           Define regular expression (regex) DNA motif to include
                        in search, e.g. --regex AAACC, --regex
                        'C[ACGT]AC[AC]', .. IUPAC code is also supported, e.g.
                        AAARN resolves to AAA[AG][ACGT]. Alternatively, supply
                        structure pattern, e.g. AA((((ARA))))AA or
                        CC(((A...R)))CC with variable spacer
  --regex-id str        Set regex ID used as RBP ID and database ID associated
                        to -regex hits (default: "regex")
  --motif-regex-id      Use --regex-id for motif ID as well. By default,
                        regular expression string is used as motif ID for
                        regex motif hits
  --regex-type {1,2,3}  Set type of supplied --regex string 1: auto-detect
                        type (standard regex or structure pattern). 2: given
                        --regex string is standard regex, e.g. AC[AG]T. 3:
                        given --regex string is structure pattern string, e.g.
                        ((AA(((...)))AA)) (default: 1)
  --regex-search-mode {1,2}
                        Define regex search mode. 1: when motif hit
                        encountered, continue +1 after motif hit start
                        position, 2: when motif hit encountered, continue +1
                        after motif hit end position. NOTE that structure
                        pattern regex currently always uses mode 1 (default:
                        1)
  --regex-min-gc float  Minimum GC base pair fraction to report structure
                        pattern regex hits (default: 0.0)
  --regex-max-gu float  Maximum GU (GT) base pair fraction to report structure
                        pattern regex hits (default: 1.0)
  --regex-spacer-min int
                        Minimum spacer length for structure pattern regex
                        search (default: 5)
  --regex-spacer-max int
                        Maximum spacer length for structure pattern regex
                        search (default: 200)
  --fimo-ntf-file str   Provide FIMO nucleotide frequencies (FIMO option:
                        --bfile) file (default: use internal frequencies file,
                        define which with --fimo-ntf-mode)
  --fimo-ntf-mode {1,2,3}
                        Set which internal nucleotide frequencies to use for
                        FIMO search. 1: use frequencies from human ENSEMBL
                        transcripts (excluding introns, A most prominent) 2:
                        use frequencies from human ENSEMBL transcripts
                        (including introns, resulting in lower G+C and T most
                        prominent) 3: use uniform frequencies (same for every
                        nucleotide) (default: 1)
  --fimo-pval float     FIMO p-value threshold (FIMO option: --thresh)
                        (default: 0.0005)
  --cmsearch-bs float   CMSEARCH bit score threshold (CMSEARCH options: -T
                        --incT). The higher the more strict (default: 1.0)
  --cmsearch-mode {1,2}
                        Set CMSEARCH mode to control strictness of filtering.
                        1: default setting (CMSEARCH option: --default). 2:
                        max setting (CMSEARCH option: --max), i.e., turn all
                        heuristic filters off, slower and more sensitive /
                        more hits) (default: 1)
  --greatest-hits       Keep only best FIMO/CMSEARCH motif hits (i.e., hit
                        with lowest p-value / highest bit score for each motif
                        sequence/site combination). By default, report all
                        hits (default: False)
  --bed-score-col int   --in BED score column used for p-value calculations.
                        BED score can be e.g. log2 fold change or -log10
                        p-value of the region (default: 5)
  --bed-sc-thr float    Minimum site score (by default: --in BED column 5, or
                        set via --bed-score-col) for filtering (assuming
                        higher score == better site) (default: None)
  --bed-sc-thr-rev      Reverse --bed-sc-thr filtering (i.e. the lower the
                        better, e.g. if score column contains p-values)
                        (default: False)
  --wrs-mode {1,2}      Defines Wilcoxon rank-sum test alternative hypothesis
                        for testing whether motif-containing regions have
                        significantly different scores. 1: test for higher
                        (greater) scores, 2: test for lower (less) scores
                        (default: 1)
  --fisher-mode {1,2,3}
                        Defines Fisher exact test alternative hypothesis for
                        testing co-occurrences of RBP motifs. 1: greater, 2:
                        two-sided, 3: less (default: 1)
  --unstranded          Set if --in BED regions are NOT strand-specific, i.e.,
                        to look for motifs on both strands of the provided
                        regions. Note that the two strands of a region will
                        still be counted as one region (change with
                        --unstranded-ct) (default: False)
  --unstranded-ct       Count each --in region twice for RBP hit statistics
                        when --unstranded is enabled. By default, two strands
                        of one region are counted as one region for RBP hit
                        statistics
  --plot-motifs         Visualize selected sequence motifs, by outputting
                        sequence logos and motif hit statistics into a
                        separate .html file (default: False)
  --top-n-matched int   Set top n matched sequences to be displayed in motif
                        hit statistics HTML report (create via --plot-motifs)
                        (default: 10)
  --cooc-pval-thr float
                        RBP co-occurrence p-value threshold for reporting
                        significant co-occurrences. NOTE that if --cooc-pval-
                        mode Bonferroni is selected, this threshold gets
                        further adjusted by Bonferroni correction (i.e.
                        divided by number of tests). Threshold applies
                        unchanged for BH corrected p-values as well as for
                        disabled correction (default: 0.005)
  --cooc-pval-mode {1,2,3}
                        Defines multiple testing correction mode for co-
                        occurrence p-values. 1: Benjamini-Hochberg (BH), 2:
                        Bonferroni, 3: no correction (default: 1)
  --min-motif-dist int  Set minimum mean motif distance for an RBP pair to be
                        reported significant in RBP co-occurrence heatmap
                        plot. By default (value 0), all RBP pairs <= set
                        p-value are reported significant. So setting --min-
                        motif-dist >= 0 acts as a second filter to show only
                        RBP pairs with signficiant p-values as significant if
                        there is the specified minimum average distance
                        between their motifs (default: 0)
  --max-motif-dist int  Set maximum motif distance for RBP co-occurrence plot
                        statistic inside hover boxes (default: 20)
  --disable-len-dist-plot
                        Disable input sequence length distribution plot in
                        HTML report (default: False)
  --disable-kmer-tb-plot
                        Disable top vs bottom scoring sites k-mer distribution
                        plot. By default, plot is generated with split point
                        as the middle point, i.e., top 50 percent vs bottom 50
                        percent scoring sites (default: False)
  --kmer-tb-plot-top-n int
                        Set number of top scoring sites to use for top vs
                        bottom scoring sites distribution k-mer plot. By
                        default, top and bottom is split in half (default:
                        False)
  --kmer-tb-plot-bottom-n int
                        Set number of bottom scoring sites to use for top vs
                        bottom scoring sites k-mer distribution plot. By
                        default, top and bottom is split in half (default:
                        False)
  --disable-kmer-var-plot
                        Disable sequence k-mer variation plot (default: False)
  --kmer-var-color-mode {1,2}
                        Define which attribute to use for coloring sequence
                        k-mer variation plot. 1: correlation (Spearman)
                        between k-mer ratios and site scores. 2: k-mer
                        percentage in dataset (default: 1)
  --kmer-plot-k int     Define k for k-mer distribution plots, including top
                        k-mers plot, top vs bottom scoring sites plot, and
                        k-mer variation plot (default: 4)
  --enable-upset-plot   Enable upset plot in HTML report (default: False)
  --upset-plot-min-degree int
                        Upset plot minimum degree parameter (default: 2)
  --upset-plot-max-degree int
                        Upset plot maximum degree. By default no maximum
                        degree is set. Useful to look at specific degrees only
                        (together with --upset-plot-min-degree), e.g. 2 or 2
                        to 3 (default: None)
  --upset-plot-min-subset-size int
                        Upset plot minimum subset size (default: 5)
  --upset-plot-max-subset-rank int
                        Upset plot maximum subset rank to plot. All tied
                        subsets are included (default: 25)
  --upset-plot-max-rbp-rank int
                        Maximum RBP hit region count rank. Set this to limit
                        the amount of RBPs included in upset plot (+ statistic
                        !) to top --upset-plot-max-rbp-rank RBPs. By default
                        all RBPs are included (default: None)
  --upset-plot-min-rbp-count int
                        Minimum amount of input sites containing motifs for an
                        RBP in order for the RBP to be included in upset plot
                        (+ statistic !). By default, all RBPs are included,
                        also RBPs without hit regions (default: 0)
  --gtf str             Input GTF file for genomic region annotations +
                        related plots (e.g. from GENCODE or Ensembl). By
                        default the most prominent transcripts will be
                        extracted and used for functional annotation.
                        Alternatively, provide a list of expressed transcripts
                        via --tr-list (together with --gtf containing the
                        transcripts). Note that only features on standard
                        chromosomes (1,2,..,X,Y,MT) are currently used for
                        annotation
  --tr-list str         Supply file with transcript IDs (one ID per row) to
                        define which transcripts to use from --gtf for genomic
                        annotation of input regions
  --tr-types str [str ...]
                        List of transcript biotypes to consider for genomic
                        region annotations. By default an internal selection
                        of transcript biotypes is used (in addition to intron,
                        CDS, UTR, intergenic). Note that provided biotype
                        strings need to be in GTF file
  --gtf-feat-min-overlap float
                        Minimum amount of overlap required for a region to be
                        assigned to a GTF feature (if less or no overlap,
                        region will be assigned to "intergenic"). If there is
                        overlap with several features, assign the one with
                        highest overlap (default: 0.1)
  --gtf-intron-border-len int
                        Set intron border region length (up- + downstream
                        ends) for exon intron overlap statistics (default:
                        250)
  --gtf-min-mrna-overlap float
                        Minimum amount of overlap required for a region to be
                        considered in mRNA region site coverage profile (i.e.,
                        overlap with mRNA exons) (default: 0.5)
  --exp-gene-list str   Supply file with gene IDs (one ID per row) of
                        expressed genes for filtering selected RBPs (supported
                        gene ID format: ENSG00000100320, no version numbers).
                        E.g. if --rbps ALL selected, using --exp-gene-list
                        allows filtering RBPs by expression (default: False)
  --exp-gene-filter     Filter out --in regions not overlapping with --exp-
                        gene-list gene regions. Note that --exp-gene-list gene
                        IDs have to be compatible with --gtf file (default:
                        False)
  --exp-gene-filter-mode {1,2}
                        Define --exp-gene-filter behavior. 1: filter out --in
                        regions NOT OVERLAPPING with --exp-gene-list gene
                        regions. 2: filter out --in regions OVERLAPPING with
                        --exp-gene-list gene regions (default: 1)
  --mrna-norm-mode {1,2}
                        Define whether to use median or mean mRNA region
                        lengths for plotting. 1: median. 2: mean (default: 1)
  --disable-all-reg-bar
                        Disable adding region annotations for all input
                        regions (irrespective of motif hits) to stacked bar
                        plot (default: False)
  --disable-kmer-pca-plot
                        Disable input sequences by k-mer content PCA plot
                        (default: False)
  --kmer-pca-plot-k int
                        Set k for k-mer usage in sequences by k-mer content
                        PCA plot (default: 3)
  --kmer-pca-plot-no-comp
                        Disable adding sequence complexity as feature to
                        sequences by k-mer content PCA plot (default: False)
  --kmer-pca-plot-comp-k {1,2}
                        Set k for sequence complexity (Shannon entropy)
                        calculation. 1 == mono-nucleotides, 2 == di-
                        nucleotides (default: 1)
  --kmer-pca-plot-no-motifs
                        Disable adding motif hits information to sequences by
                        k-mer content PCA plot (default: False)
  --set-rbp-id str      Set reference RBP ID to plot motif distances relative
                        to motifs from this RBP (needs to be one of the
                        selected RBP IDs!). Motif plot will be centered on
                        best scoring motif of the RBP for each region
  --motif-distance-plot-range int
                        Set range of motif distance plot. I.e., centered on
                        the set RBP (--set-rbp-id) motifs, motifs within minus
                        and plus --motif-distance-plot-range will be plotted
                        (default: 50)
  --motif-min-pair-count int
                        On single motif level, minimum count of co-occurrences
                        of a motif with set RBP ID (--set-rbp-id) motif to be
                        reported and plotted (default: 10)
  --rbp-min-pair-count int
                        On RBP level, minimum amount of co-occurrences of
                        motifs for an RBP ID compared to set RBP ID (--set-
                        rbp-id) motifs to be reported and plotted (default:
                        10)
  --goa                 Run gene ontology (GO) enrichment analysis on genes
                        occupied by --in regions. Requires --gtf (default:
                        False)
  --goa-obo-mode {1,2,3}
                        Define how to obtain GO DAG (directed acyclic graph)
                        obo file. 1: download most recent file from internet,
                        2: use local file, 3: provide file via --goa-obo-file
                        (default: 1)
  --goa-obo-file str    Provide GO DAG obo file (default: False)
  --goa-gene2go-file str
                        Provide gene ID to GO IDs mapping table (row format:
                        gene_id<tab>go_id1,go_id2). By default, a local file
                        with ENSEMBL gene IDs is used. NOTE that gene IDs need
                        to be compatible with --gtf (default: False)
  --goa-pval float      GO enrichment analysis p-value threshold (applied on
                        corrected p-value) (default: 0.05)
  --goa-cooc-mode {1,2,3}
                        Define what input regions to consider in GOA, in
                        relation to motif hit (co-)occurrences. 1: Perform GOA
                        on all input regions (no motif (co-)occurrences
                        required). 2: perform GOA only on input regions with
                        motif hits from ANY specified RBP. 3: perform GOA only
                        on input regions with motif hits from ALL specified
                        RBPs. GOA on input regions translates to GOA on the
                        underlying genes (default: 1)
  --goa-bg-gene-list str
                        Supply file with gene IDs (one ID per row) to use as
                        background gene list for GOA. NOTE that gene IDs need
                        to be compatible with --gtf (default: False)
  --goa-max-child int   Specify maximum number of children for a significant
                        GO term to be reported in HTML table, e.g. --goa-max-
                        child 100. This allows filtering out very broad terms
                        (default: None)
  --goa-min-depth int   Specify minimum depth number for a significant GO term
                        to be reported in HTML table, e.g. --goa-min-depth 5
                        (default: None)
  --goa-filter-purified
                        Filter out GOA results labeled as purified (i.e., GO
                        terms with significantly lower concentration) in HTML
                        table (default: False)
  --plot-abs-paths      Store plot files with absolute paths in HTML files.
                        Default is relative paths (default: False)
  --prom-min-tr-len int
                        Minimum transcript length for promoter region
                        extraction. By default consider all transcript regions
  --prom-mrna-only      Consider only mRNA transcript regions for promoter
                        region extraction
  --prom-both-str       Use both strands for promoter region overlap
                        calculation. By default, use transcript strand
  --prom-ext str        Up- and downstream extension of transcript start site
                        (TSS) to define putative promoter regions, e.g.
                        --prom-ext 500,0 for 500 upstream and 0 downstream
                        extension (default: 1000,100)
  --add-annot-bed str   Specify additional genomic regions in BED format for
                        which to calculate the percentage of input regions
                        that overlap with them
  --add-annot-comp      Get the complement percentage, i.e., the percentage of
                        input regions NOT overlapping with --add-annot-bed
                        regions
  --add-annot-id str    Label to use for additional regions in HTML report
                        (default: "custom")
  --plot-pdf            Also output .png plots as .pdf in plotting subfolder
                        (default: False)
  --meme-no-check       Disable MEME version check. Make sure --meme-no-pgc is
                        set if MEME version >= 5.5.4 is installed! (default:
                        False)
  --meme-no-pgc         Manually set MEME's FIMO --no-pgc option (required for
                        MEME version >= 5.5.4). Make sure that MEME >= 5.5.4
                        is installed! (default: False)
  --plotly-js-mode {1,2,3,4,5,6,7}
                        Define how to provide plotly .js file. 1: use online
                        version via "cdn" (requires internet connection). 2:
                        link to packaged plotly .js file. 3: copy plotly .js
                        file to plots output folder. 4: include plotly .js
                        code in plotly HTML. 5: put web version link and
                        plotly plot codes into main HTML. 6: put local version
                        link and plotly plot codes in main HTML. 7: put plotly
                        js and plotly plot codes into main HTML! (default: 1)
  --sort-js-mode {1,2,3}
                        Define how to provide sorttable.js file. 1: link to
                        packaged .js file. 2: copy .js file to plots output
                        folder. 3: include .js code in HTML (default: 1)

required arguments:
  --in str              Genomic RBP binding sites (peak regions) file in BED
                        format
  --rbps str [str ...]  List of RBP names to define RBP motifs used for search
                        (--rbps rbp1 rbp2 .. ). To search with all available
                        motifs, use --rbps ALL. NOTE: to search with user-
                        provided motifs, set --rbps USER and provide --user-
                        meme-xml and/or --user-cm. To search only for --regex,
                        set --rbps REGEX
  --genome str          Genomic sequences file (currently supported formats:
                        FASTA)
  --out str             Results output folder
```


## rbpbench_batch

### Tool Description
Batch job for RBP motif analysis

### Metadata
- **Docker Image**: quay.io/biocontainers/rbpbench:1.1.0--pyhdfd78af_0
- **Homepage**: https://github.com/michauhl/RBPBench
- **Package**: https://anaconda.org/channels/bioconda/packages/rbpbench/overview
- **Validation**: PASS

### Original Help Text
```text
usage: rbpbench batch [-h] --bed str [str ...] --genome str --out str
                      [--rbp-list str [str ...]] [--data-list str [str ...]]
                      [--data-id str] [--method-list str [str ...]]
                      [--method-id str] [--run-id str] [--ext str]
                      [--motif-db {1,2,3}] [--custom-db str]
                      [--custom-db-id str] [--custom-db-meme-xml str]
                      [--custom-db-cm str] [--custom-db-info str]
                      [--regex str] [--regex-search-mode {1,2}]
                      [--regex-type {1,2,3}] [--regex-min-gc float]
                      [--regex-max-gu float] [--regex-spacer-min int]
                      [--regex-spacer-max int] [--max-motif-dist int]
                      [--fimo-ntf-file str] [--fimo-ntf-mode {1,2,3}]
                      [--fimo-pval float] [--cmsearch-bs float]
                      [--cmsearch-mode {1,2}] [--greatest-hits]
                      [--bed-score-col int] [--bed-sc-thr float]
                      [--bed-sc-thr-rev] [--wrs-mode {1,2}]
                      [--fisher-mode {1,2,3}] [--unstranded] [--unstranded-ct]
                      [--kmer-size int] [--disable-heatmap-cluster-olo]
                      [--gtf str] [--tr-list str] [--tr-types str [str ...]]
                      [--gtf-feat-min-overlap float]
                      [--gtf-intron-border-len int] [--no-occ-heatmap]
                      [--hk-gene-list str] [--no-comp-feat]
                      [--seq-comp-k {1,2}] [--seq-var-kmer-size int]
                      [--seq-var-feat-mode {1,2}] [--seq-var-color-mode {1,2}]
                      [--goa] [--goa-obo-mode {1,2,3}] [--goa-obo-file str]
                      [--goa-gene2go-file str] [--goa-pval float]
                      [--goa-only-cooc] [--goa-bg-gene-list str]
                      [--goa-max-child int] [--goa-min-depth int]
                      [--goa-filter-purified] [--prom-min-tr-len int]
                      [--prom-mrna-only] [--prom-both-str] [--prom-ext str]
                      [--add-annot-bed str] [--add-annot-comp]
                      [--add-annot-id str] [--plot-abs-paths] [--plot-pdf]
                      [--plotly-js-mode {1,2,3,4,5,6,7}]
                      [--sort-js-mode {1,2,3}] [--meme-no-check]
                      [--meme-no-pgc]

options:
  -h, --help            show this help message and exit
  --rbp-list str [str ...]
                        List of RBP names to define RBP motifs used for
                        search. One --rbp-list RBP ID for each --bed BED file
                        (NOTE: order needs to correspond to --bed-list)
  --data-list str [str ...]
                        List of data IDs to describe datasets given by -bed-
                        list (NOTE: order needs to correspond to --bed order).
                        Alternatively, use --data-id to set method for all
                        datasets
  --data-id str         Data ID to describe data for given datasets, e.g.
                        --method-id k562_eclip, used in output tables and for
                        generating the comparison reports (rbpbench compare)
  --method-list str [str ...]
                        List of method IDs to describe datasets given by -bed-
                        list (NOTE: order needs to correspond to --bed order).
                        Alternatively, use --method-id to set method for all
                        datasets
  --method-id str       Method ID to describe peak calling method for given
                        datasets, e.g. --method-id clipper_idr, used in output
                        tables and for generating the comparison reports
                        (rbpbench compare)
  --run-id str          Run ID to describe rbpbench search job, e.g. --run-id
                        RBP1_eCLIP_tool1, used in output tables and reports
  --ext str             Up- and downstream extension of --in sites in
                        nucleotides (nt). Set e.g. --ext 30 for 30 nt on both
                        sides, or --ext 20,10 for different up- and downstream
                        extension (default: 0)
  --motif-db {1,2,3}    Built-in motif database to use. 1: human RBP motifs
                        (257 RBPs, 599 motifs,
                        "catrapid_omics_v2.1_human_6plus_ext"), 2: human RBP
                        motifs + 23 ucRBP motifs (277 RBPs, 622 motifs,
                        "catrapid_omics_v2.1_human_6plus_ext_ucrbps"), 3:
                        human RBP motifs from Ray et al. 2013 (80 RBPs, 102
                        motifs, "ray2013_human_rbps_rnacompete") (default: 1)
  --custom-db str       Provide custom motif database folder
  --custom-db-id str    Set ID/name for provided custom motif database via
                        --custom-db (default: "custom")
  --custom-db-meme-xml str
                        Provide custom motif database MEME/DREME XML file
                        containing sequence motifs
  --custom-db-cm str    Provide custom motif database covariance model (.cm)
                        file containing covariance model(s)
  --custom-db-info str  Provide custom motif database info table file
                        containing RBP ID -> motif ID -> motif type
                        assignments
  --regex str           Define regular expression (regex) DNA motif to include
                        in search, e.g. --regex AAACC, --regex
                        'C[ACGT]AC[AC]', .. IUPAC code is also supported, e.g.
                        AAARN resolves to AAA[AG][ACGT]. Alternatively, supply
                        structure pattern, e.g. AA((((ARA))))AA or
                        CC(((A...R)))CC with variable spacer
  --regex-search-mode {1,2}
                        Define regex search mode. 1: when motif hit
                        encountered, continue +1 after motif hit start
                        position, 2: when motif hit encountered, continue +1
                        after motif hit end position. NOTE that structure
                        pattern regex currently always uses mode 1 (default:
                        1)
  --regex-type {1,2,3}  Set type of supplied --regex string 1: auto-detect
                        type (standard regex or structure pattern). 2: given
                        --regex string is standard regex, e.g. AC[AG]T. 3:
                        given --regex string is structure pattern string, e.g.
                        ((AA(((...)))AA)) (default: 1)
  --regex-min-gc float  Minimum GC base pair fraction to report structure
                        pattern regex hits (default: 0.0)
  --regex-max-gu float  Maximum GU (GT) base pair fraction to report structure
                        pattern regex hits (default: 1.0)
  --regex-spacer-min int
                        Minimum spacer length for structure pattern regex
                        search (default: 5)
  --regex-spacer-max int
                        Maximum spacer length for structure pattern regex
                        search (default: 200)
  --max-motif-dist int  Set maximum motif distance for regex-RBP co-occurrence
                        statistic in HTML report (default: 20)
  --fimo-ntf-file str   Provide FIMO nucleotide frequencies (FIMO option:
                        --bfile) file (default: use internal frequencies file,
                        define which with --fimo-ntf-mode)
  --fimo-ntf-mode {1,2,3}
                        Set which internal nucleotide frequencies to use for
                        FIMO search. 1: use frequencies from human ENSEMBL
                        transcripts (excluding introns, A most prominent) 2:
                        use frequencies from human ENSEMBL transcripts
                        (including introns, resulting in lower G+C and T most
                        prominent) 3: use uniform frequencies (same for every
                        nucleotide) (default: 1)
  --fimo-pval float     FIMO p-value threshold (FIMO option: --thresh)
                        (default: 0.0005)
  --cmsearch-bs float   CMSEARCH bit score threshold (CMSEARCH options: -T
                        --incT). The higher the more strict (default: 1.0)
  --cmsearch-mode {1,2}
                        Set CMSEARCH mode to control strictness of filtering.
                        1: default setting (CMSEARCH option: --default). 2:
                        max setting (CMSEARCH option: --max), i.e., turn all
                        heuristic filters off, slower and more sensitive /
                        more hits) (default: 1)
  --greatest-hits       Keep only best FIMO/CMSEARCH motif hits (i.e., hit
                        with lowest p-value / highest bit score for each motif
                        sequence/site combination). By default, report all
                        hits (default: False)
  --bed-score-col int   --in BED score column used for p-value calculations.
                        BED score can be e.g. log2 fold change or -log10
                        p-value of the region (default: 5)
  --bed-sc-thr float    Minimum site score (by default: --in BED column 5, or
                        set via --bed-score-col) for filtering (assuming
                        higher score == better site) (default: None)
  --bed-sc-thr-rev      Reverse --bed-sc-thr filtering (i.e. the lower the
                        better, e.g. if score column contains p-values)
                        (default: False)
  --wrs-mode {1,2}      Defines Wilcoxon rank-sum test alternative hypothesis
                        for testing whether motif-containing regions have
                        significantly different scores. 1: test for higher
                        (greater) scores, 2: test for lower (less) scores
                        (default: 1)
  --fisher-mode {1,2,3}
                        Defines Fisher exact test alternative hypothesis for
                        testing co-occurrences of RBP motifs. 1: greater, 2:
                        two-sided, 3: less (default: 1)
  --unstranded          Set if --in BED regions are NOT strand-specific, i.e.,
                        to look for motifs on both strands of the provided
                        regions. Note that the two strands of a region will
                        still be counted as one region (change with
                        --unstranded-ct) (default: False)
  --unstranded-ct       Count each --in region twice for RBP hit statistics
                        when --unstranded is enabled. By default, two strands
                        of one region are counted as one region for RBP hit
                        statistics
  --kmer-size int       K-mer size for comparative plots (default: 5)
  --disable-heatmap-cluster-olo
                        Disable optimal leave ordering (OLO) for clustering
                        gene region occupancy heatmap. By default, OLO is
                        enabled
  --gtf str             Input GTF file with genomic annotations to generate
                        genomic region annotation plots for each input BED
                        file (output to HTML report). By default the most
                        prominent transcripts will be extracted and used for
                        functional annotation. Alternatively, provide a list
                        of expressed transcripts via --tr-list (together with
                        --gtf containing the transcripts). Note that only
                        features on standard chromosomes (1,2,..,X,Y,MT) are
                        currently used for annotation
  --tr-list str         Supply file with transcript IDs (one ID per row) to
                        define which transcripts to use from --gtf for genomic
                        region annotations plots
  --tr-types str [str ...]
                        List of transcript biotypes to consider for genomic
                        region annotations plots. By default an internal
                        selection of transcript biotypes is used (in addition
                        to intron, CDS, UTR, intergenic). Note that provided
                        biotype strings need to be in --gtf GTF file
  --gtf-feat-min-overlap float
                        Minimum amount of overlap required for a region to be
                        assigned to a GTF feature (if less or no overlap,
                        region will be assigned to "intergenic"). If there is
                        overlap with several features, assign the one with
                        highest overlap (default: 0.1)
  --gtf-intron-border-len int
                        Set intron border region length (up- + downstream
                        ends) for exon intron overlap statistics (default:
                        250)
  --no-occ-heatmap      Do not produce gene region occupancy heatmap plot in
                        HTML report (default: False)
  --hk-gene-list str    Supply file with gene IDs (one ID per row) of
                        housekeeping genes as additional plotting info. ID
                        format needs to be compatible with provided --gtf file
                        (default: False)
  --no-comp-feat        Disable sequence complexity info to be added to plot
                        (default: False)
  --seq-comp-k {1,2}    Set k for sequence complexity (Shannon entropy)
                        calculation. 1 == mono-nucleotides, 2 == di-
                        nucleotides (default: 1)
  --seq-var-kmer-size int
                        K-mer size for sequence variation statistics and plot
                        (default: 3)
  --seq-var-feat-mode {1,2}
                        Define what sequence k-mer variation plot to create 1:
                        plot using site percentages for each k-mer as
                        dimensions. 2: plot using k-mer variations as
                        dimensions (default: 1)
  --seq-var-color-mode {1,2}
                        Define which attribute to use for coloring k-mer
                        variation plot. 1: average k-mer site percentage. 2:
                        present k-mers percentage (default: 1)
  --goa                 Run gene ontology (GO) enrichment analysis on genes
                        occupied by sites in input datasets. Requires --gtf
                        (default: False)
  --goa-obo-mode {1,2,3}
                        Define how to obtain GO DAG (directed acyclic graph)
                        obo file. 1: download most recent file from internet,
                        2: use local file, 3: provide file via --goa-obo-file
                        (default: 1)
  --goa-obo-file str    Provide GO DAG obo file (default: False)
  --goa-gene2go-file str
                        Provide gene ID to GO IDs mapping table (row format:
                        gene_id<tab>go_id1,go_id2). By default, a local file
                        with ENSEMBL gene IDs is used. NOTE that gene IDs need
                        to be compatible with --gtf (default: False)
  --goa-pval float      GO enrichment analysis p-value threshold (applied on
                        corrected p-value) (default: 0.05)
  --goa-only-cooc       Only look at genes in GO enrichment analysis which
                        contain motif hits for all input datasets. By default,
                        GO enrichment analysis is performed on the genes
                        covered by sites from all input datasets (default:
                        False)
  --goa-bg-gene-list str
                        Supply file with gene IDs (one ID per row) to use as
                        background gene list for GOA. NOTE that gene IDs need
                        to be compatible with --gtf (default: False)
  --goa-max-child int   Specify maximum number of children for a significant
                        GO term to be reported in HTML table, e.g. --goa-max-
                        child 100. This allows filtering out very broad terms
                        (default: None)
  --goa-min-depth int   Specify minimum depth number for a significant GO term
                        to be reported in HTML table, e.g. --goa-min-depth 5
                        (default: None)
  --goa-filter-purified
                        Filter out GOA results labeled as purified (i.e., GO
                        terms with significantly lower concentration) in HTML
                        table (default: False)
  --prom-min-tr-len int
                        Minimum transcript length for promoter region
                        extraction. By default consider all transcript regions
  --prom-mrna-only      Consider only mRNA transcript regions for promoter
                        region extraction
  --prom-both-str       Use both strands for promoter region overlap
                        calculation. By default, use transcript strand
  --prom-ext str        Up- and downstream extension of transcript start site
                        (TSS) to define putative promoter regions, e.g.
                        --prom-ext 500,0 for 500 upstream and 0 downstream
                        extension (default: 1000,100)
  --add-annot-bed str   Specify additional genomic regions in BED format for
                        which to calculate the percentages of input regions
                        that overlap with them
  --add-annot-comp      Get the complement percentages, i.e., the percentages
                        of input regions NOT overlapping with --add-annot-bed
                        regions
  --add-annot-id str    Label to use for additional regions in HTML report
                        (default: "custom")
  --plot-abs-paths      Store plot files with absolute paths in HTML files.
                        Default is relative paths (default: False)
  --plot-pdf            Also output .png plots as .pdf in plotting subfolder
                        (default: False)
  --plotly-js-mode {1,2,3,4,5,6,7}
                        Define how to provide plotly .js file. 1: use online
                        version via "cdn" (requires internet connection). 2:
                        link to packaged plotly .js file. 3: copy plotly .js
                        file to plots output folder. 4: include plotly .js
                        code in plotly HTML. 5: put web version link and
                        plotly plot codes into main HTML. 6: put local version
                        link and plotly plot codes in main HTML. 7: put plotly
                        js and plotly plot codes into main HTML! (default: 1)
  --sort-js-mode {1,2,3}
                        Define how to provide sorttable.js file. 1: link to
                        packaged .js file. 2: copy .js file to plots output
                        folder. 3: include .js code in HTML (default: 1)
  --meme-no-check       Disable MEME version check. Make sure --meme-no-pgc is
                        set if MEME version >= 5.5.4 is installed! (default:
                        False)
  --meme-no-pgc         Manually set MEME's FIMO --no-pgc option (required for
                        MEME version >= 5.5.4). Make sure that MEME >= 5.5.4
                        is installed! (default: False)

required arguments:
  --bed str [str ...]   Provide either: a folder with BED files (e.g. --bed
                        clipper_bed), a list of BED files to search for
                        motifs, or a table file defining files and settings.
                        If folder, RBP IDs should be part of BED file names,
                        like: RBP1_...bed, RBP2_...bed. If list of BED files,
                        define RBP IDs with --rbp-list. If table file, see
                        manual for the correct format
  --genome str          Genomic sequences file (currently supported formats:
                        FASTA)
  --out str             Batch job results output folder
```


## rbpbench_compare

### Tool Description
Compare motif search results from rbpbench.

### Metadata
- **Docker Image**: quay.io/biocontainers/rbpbench:1.1.0--pyhdfd78af_0
- **Homepage**: https://github.com/michauhl/RBPBench
- **Package**: https://anaconda.org/channels/bioconda/packages/rbpbench/overview
- **Validation**: PASS

### Original Help Text
```text
usage: rbpbench compare [-h] --in str [str ...] --out str [--plot-abs-paths]
                        [--plot-pdf] [--sort-js-mode {1,2,3}]

options:
  -h, --help            show this help message and exit
  --plot-abs-paths      Store plot files with absolute paths in HTML files.
                        Default is relative paths (default: False)
  --plot-pdf            Also output .png plots as .pdf in plotting subfolder
                        (default: False)
  --sort-js-mode {1,2,3}
                        Define how to provide sorttable.js file. 1: link to
                        packaged .js file. 2: copy .js file to plots output
                        folder. 3: include .js code in HTML (default: 1)

required arguments:
  --in str [str ...]    Supply motif search results data, either as folders
                        (--out folders of rbpbench search or batch), or as
                        files (both RBP and motif hit stats files needed!).
                        Order of files does NOT matter
  --out str             Comparison results output folder
```


## rbpbench_searchseq

### Tool Description
Search for sequence motifs in DNA/RNA sequences.

### Metadata
- **Docker Image**: quay.io/biocontainers/rbpbench:1.1.0--pyhdfd78af_0
- **Homepage**: https://github.com/michauhl/RBPBench
- **Package**: https://anaconda.org/channels/bioconda/packages/rbpbench/overview
- **Validation**: PASS

### Original Help Text
```text
usage: rbpbench searchseq [-h] --in str --rbps str [str ...] --out str
                          [--data-id str] [--method-id str]
                          [--user-rbp-id str] [--user-meme-xml str]
                          [--user-cm str] [--motif-db {1,2,3}]
                          [--custom-db str] [--custom-db-id str]
                          [--custom-db-meme-xml str] [--custom-db-cm str]
                          [--custom-db-info str] [--regex str]
                          [--regex-id str] [--motif-regex-id]
                          [--regex-type {1,2,3}] [--regex-search-mode {1,2}]
                          [--regex-min-gc float] [--regex-max-gu float]
                          [--regex-spacer-min int] [--regex-spacer-max int]
                          [--motifs str [str ...]] [--motif-min-len int]
                          [--motif-max-len int] [--functions str [str ...]]
                          [--fimo-ntf-file str] [--fimo-ntf-mode {1,2,3}]
                          [--fimo-pval float] [--cmsearch-bs float]
                          [--cmsearch-mode {1,2}] [--greatest-hits]
                          [--meme-no-check] [--meme-no-pgc]
                          [--make-uniq-headers] [--header-id str]
                          [--min-seq-len int] [--max-seq-len int] [--profiles]
                          [--profiles-level {1,2}] [--profiles-norm {1,2}]
                          [--profiles-k int] [--profiles-seq-id str]
                          [--profiles-top-n int] [--plot-motifs]
                          [--top-n-matched int] [--plot-abs-paths]
                          [--plot-pdf] [--plotly-js-mode {1,2,3,4,5,6,7}]
                          [--sort-js-mode {1,2,3}]

options:
  -h, --help            show this help message and exit
  --data-id str         Dataset ID to describe dataset, e.g. --data-id
                        PUM2_eCLIP_K562, used in output tables and for
                        generating the comparison reports (rbpbench compare)
  --method-id str       Method ID to describe peak calling method, e.g.
                        --method-id clipper_idr, used in output tables and for
                        generating the comparison reports (rbpbench compare)
  --user-rbp-id str     Provide RBP ID belonging to provided sequence or
                        structure motif(s) (mandatory for --rbps USER)
  --user-meme-xml str   Provide MEME/DREME XML file containing sequence
                        motif(s) to be used for the run (needs --rbps USER)
  --user-cm str         Provide covariance model (.cm) file containing
                        covariance model(s) to be used for the run (needs
                        --rbps USER)
  --motif-db {1,2,3}    Built-in motif database to use. 1: human RBP motifs
                        (257 RBPs, 599 motifs,
                        "catrapid_omics_v2.1_human_6plus_ext"), 2: human RBP
                        motifs + 23 ucRBP motifs (277 RBPs, 622 motifs,
                        "catrapid_omics_v2.1_human_6plus_ext_ucrbps"), 3:
                        human RBP motifs from Ray et al. 2013 (80 RBPs, 102
                        motifs, "ray2013_human_rbps_rnacompete") (default: 1)
  --custom-db str       Provide custom motif database folder. Alternatively,
                        provide single files via --custom-db-meme-xml,
                        --custom-db-cm, --custom-db-info
  --custom-db-id str    Set ID/name for provided custom motif database via
                        --custom-db (default: "custom")
  --custom-db-meme-xml str
                        Provide custom motif database MEME/DREME XML file
                        containing sequence motifs
  --custom-db-cm str    Provide custom motif database covariance model (.cm)
                        file containing covariance model(s)
  --custom-db-info str  Provide custom motif database info table file
                        containing RBP ID -> motif ID -> motif type
                        assignments
  --regex str           Define regular expression (regex) DNA motif to include
                        in search, e.g. --regex AAACC, --regex
                        'C[ACGT]AC[AC]', .. IUPAC code is also supported, e.g.
                        AAARN resolves to AAA[AG][ACGT]. Alternatively, supply
                        structure pattern, e.g. AA((((ARA))))AA or
                        CC(((A...R)))CC with variable spacer
  --regex-id str        Set regex ID used as RBP ID and database ID associated
                        to -regex hits (default: "regex")
  --motif-regex-id      Use --regex-id for motif ID as well. By default,
                        regular expression string is used as motif ID for
                        regex motif hits
  --regex-type {1,2,3}  Set type of supplied --regex string 1: auto-detect
                        type (standard regex or structure pattern). 2: given
                        --regex string is standard regex, e.g. AC[AG]T. 3:
                        given --regex string is structure pattern string, e.g.
                        ((AA(((...)))AA)) (default: 1)
  --regex-search-mode {1,2}
                        Define regex search mode. 1: when motif hit
                        encountered, continue +1 after motif hit start
                        position, 2: when motif hit encountered, continue +1
                        after motif hit end position. NOTE that structure
                        pattern regex currently always uses mode 1 (default:
                        1)
  --regex-min-gc float  Minimum GC base pair fraction to report structure
                        pattern regex hits (default: 0.0)
  --regex-max-gu float  Maximum GU (GT) base pair fraction to report structure
                        pattern regex hits (default: 1.0)
  --regex-spacer-min int
                        Minimum spacer length for structure pattern regex
                        search (default: 5)
  --regex-spacer-max int
                        Maximum spacer length for structure pattern regex
                        search (default: 200)
  --motifs str [str ...]
                        Provide IDs for motifs of interest (need to be in
                        database and loaded). All other RBP motifs will be
                        discarded (except --regex)
  --motif-min-len int   Minimum MEME/DREME motif length to include in search.
                        By default all selected RBP motifs are used
  --motif-max-len int   Maximum MEME/DREME motif length to include in search.
                        By default all selected RBP motifs are used
  --functions str [str ...]
                        Filter defined RBPs (via --rbps) by their molecular
                        functions (annotations available for most database
                        RBPs). E.g. for RBPs in splicing regulation, set
                        --functions SR, for RBPs in RNA stability & decay plus
                        translation regulation, set --functions RSD TR (see
                        rbpbench info for full function descriptions). NOTE
                        that --regex is not affected by filtering
  --fimo-ntf-file str   Provide FIMO nucleotide frequencies (FIMO option:
                        --bfile) file (default: use internal frequencies file,
                        define which with --fimo-ntf-mode)
  --fimo-ntf-mode {1,2,3}
                        Set which internal nucleotide frequencies to use for
                        FIMO search. 1: use frequencies from human ENSEMBL
                        transcripts (excluding introns, A most prominent) 2:
                        use frequencies from human ENSEMBL transcripts
                        (including introns, resulting in lower G+C and T most
                        prominent) 3: use uniform frequencies (same for every
                        nucleotide) (default: 1)
  --fimo-pval float     FIMO p-value threshold (FIMO option: --thresh)
                        (default: 0.0005)
  --cmsearch-bs float   CMSEARCH bit score threshold (CMSEARCH options: -T
                        --incT). The higher the more strict (default: 1.0)
  --cmsearch-mode {1,2}
                        Set CMSEARCH mode to control strictness of filtering.
                        1: default setting (CMSEARCH option: --default). 2:
                        max setting (CMSEARCH option: --max), i.e., turn all
                        heuristic filters off, slower and more sensitive /
                        more hits) (default: 1)
  --greatest-hits       Keep only best FIMO/CMSEARCH motif hits (i.e., hit
                        with lowest p-value / highest bit score for each motif
                        sequence/site combination). By default, report all
                        hits (default: False)
  --meme-no-check       Disable MEME version check. Make sure --meme-no-pgc is
                        set if MEME version >= 5.5.4 is installed! (default:
                        False)
  --meme-no-pgc         Manually set MEME's FIMO --no-pgc option (required for
                        MEME version >= 5.5.4). Make sure that MEME >= 5.5.4
                        is installed! (default: False)
  --make-uniq-headers   Make FASTA headers unique. By default, an error is
                        thrown if identical FASTA headers are encountered
                        (default: False)
  --header-id str       Constant header ID part used if --make-uniq-headers
                        set (default: "seq")
  --min-seq-len int     Minimum sequence length required for input sequences
                        to be included in search (default: False)
  --max-seq-len int     Maximum sequence length required for input sequences
                        to be included in search (default: False)
  --profiles            Generate motif hit + k-mer profiles for each input
                        sequence, and compare profiles between sequences in
                        PCA plot. Generates an HTML report (default: False)
  --profiles-level {1,2}
                        Define on which hit level to generate motif hit
                        profile. 1: on RBP hit level (merging all motif hits
                        for one RBP). 2: on individual motif level (default:
                        1)
  --profiles-norm {1,2}
                        Define how to normalize RBP/motif hit counts included
                        in hit profile. 1: use hits per 1000 nt. 2: set 1 if
                        hits present and 0 if no hits on sequence (default: 1)
  --profiles-k int      Set k-mer size k for k-mer profiles, output in
                        addition to hit profiles in HTML report (default: 5)
  --profiles-seq-id str
                        Specify sequence ID to highlight in profile PCA plots
                        and to report top --profiles-top-n similar other
                        sequences for, based on motif hit and k-mer profiles
                        (default: False, i.e., no sequence ID is highlighted)
  --profiles-top-n int  Set top n similar sequences (similar to --profiles-
                        seq-id sequence, using cosine similarity and euclidean
                        distance) to be reported in HTML report (--profiles-
                        seq-id needs to be set) (default: 20)
  --plot-motifs         Visualize selected sequence motifs, by outputting
                        sequence logos and motif hit statistics into .html
                        file (default: False)
  --top-n-matched int   Set top n matched sequences to be displayed in motif
                        hit statistics HTML report (create via --plot-motifs)
                        (default: 10)
  --plot-abs-paths      Store plot files with absolute paths in HTML files.
                        Default is relative paths (default: False)
  --plot-pdf            Also output .png plots as .pdf in plotting subfolder
                        (default: False)
  --plotly-js-mode {1,2,3,4,5,6,7}
                        Define how to provide plotly .js file. 1: use online
                        version via "cdn" (requires internet connection). 2:
                        link to packaged plotly .js file. 3: copy plotly .js
                        file to plots output folder. 4: include plotly .js
                        code in plotly HTML. 5: put web version link and
                        plotly plot codes into main HTML. 6: put local version
                        link and plotly plot codes in main HTML. 7: put plotly
                        js and plotly plot codes into main HTML! (default: 1)
  --sort-js-mode {1,2,3}
                        Define how to provide sorttable.js file. 1: link to
                        packaged .js file. 2: copy .js file to plots output
                        folder. 3: include .js code in HTML (default: 1)

required arguments:
  --in str              Input FASTA file with DNA/RNA sequences used for motif
                        search
  --rbps str [str ...]  List of RBP names to define RBP motifs used for search
                        (--rbps rbp1 rbp2 .. ). To search with all available
                        motifs, use --rbps ALL. NOTE: to search with user-
                        provided motifs, set --rbps USER and provide --user-
                        meme-xml and/or --user-cm
  --out str             Results output folder
```


## rbpbench_searchregex

### Tool Description
Search for DNA/RNA motifs using regular expressions in FASTA or BED files.

### Metadata
- **Docker Image**: quay.io/biocontainers/rbpbench:1.1.0--pyhdfd78af_0
- **Homepage**: https://github.com/michauhl/RBPBench
- **Package**: https://anaconda.org/channels/bioconda/packages/rbpbench/overview
- **Validation**: PASS

### Original Help Text
```text
usage: rbpbench searchregex [-h] --in str --regex str --out str [--genome str]
                            [--make-uniq-headers] [--header-id str]
                            [--regex-search-mode {1,2}] [--regex-min-gc float]
                            [--regex-max-gu float] [--regex-spacer-min int]
                            [--regex-spacer-max int] [--ext str]
                            [--add-zero-hits]

options:
  -h, --help            show this help message and exit
  --genome str          Genomic sequences FASTA file (required if --in is BED)
  --make-uniq-headers   Make sequence IDs (FASTA header or BED column 4 IDs)
                        unique. By default, an error is thrown if identical
                        IDs are encountered (default: False)
  --header-id str       Constant header ID part used if --make-uniq-headers
                        set (default: "reg")
  --regex-search-mode {1,2}
                        Define regex search mode. 1: when motif hit
                        encountered, continue +1 after motif hit start
                        position, 2: when motif hit encountered, continue +1
                        after motif hit end position. NOTE that structure
                        pattern regex currently always uses mode 1 (default:
                        1)
  --regex-min-gc float  Minimum GC base pair fraction to report structure
                        pattern regex hits (default: 0.0)
  --regex-max-gu float  Maximum GU (GT) base pair fraction to report structure
                        pattern regex hits (default: 1.0)
  --regex-spacer-min int
                        Minimum spacer length for structure pattern regex
                        search (default: 5)
  --regex-spacer-max int
                        Maximum spacer length for structure pattern regex
                        search (default: 200)
  --ext str             Up- and downstream extension of --in sites in
                        nucleotides (nt), if --in are genomic regions in BED
                        format. Set e.g. --ext 30 for 30 nt on both sides, or
                        --ext 20,10 for different up- and downstream extension
                        (default: 0)
  --add-zero-hits       Also add regions with 0 hits to output BED file (hit
                        count in column 5) (default: False)

required arguments:
  --in str              Input FASTA file with DNA/RNA sequences or BED file
                        (>= 6 column format) with genomic regions used for
                        regex search. NOTE that sequences will be converted to
                        DNA and uppercased before search. If BED file, also
                        provide --genome FASTA file
  --regex str           Define regular expression (regex) DNA motif used for
                        search, e.g. --regex AAAAA, --regex 'C[ACGT]AC[AC]' ..
                        IUPAC code is also supported, e.g. AAARN resolves to
                        AAA[AG][ACGT]. Moreover, structure patterns can be
                        supplied, e.g. AA((((ARA))))AA or CC(((A...R)))CC with
                        variable spacer. Alternatively, provide a file with
                        regexes (first column regex ID, second column regex),
                        e.g. --regex regexes.txt
  --out str             Results output folder
```


## rbpbench_searchlong

### Tool Description
Search for RBP motifs in genomic regions.

### Metadata
- **Docker Image**: quay.io/biocontainers/rbpbench:1.1.0--pyhdfd78af_0
- **Homepage**: https://github.com/michauhl/RBPBench
- **Package**: https://anaconda.org/channels/bioconda/packages/rbpbench/overview
- **Validation**: PASS

### Original Help Text
```text
usage: rbpbench searchlong [-h] --in str --rbps str [str ...] --genome str
                           --out str [--data-id str] [--method-id str]
                           [--run-id str] [--user-rbp-id str]
                           [--user-meme-xml str] [--user-cm str]
                           [--motif-db {1,2,3}] [--custom-db str]
                           [--custom-db-id str] [--custom-db-meme-xml str]
                           [--custom-db-cm str] [--custom-db-info str]
                           [--motifs str [str ...]] [--motif-min-len int]
                           [--motif-max-len int] [--functions str [str ...]]
                           [--regex str] [--regex-id str] [--motif-regex-id]
                           [--regex-type {1,2,3}] [--regex-search-mode {1,2}]
                           [--regex-min-gc float] [--regex-max-gu float]
                           [--regex-spacer-min int] [--regex-spacer-max int]
                           [--fimo-ntf-file str] [--fimo-ntf-mode {1,2,3}]
                           [--fimo-pval float] [--cmsearch-bs float]
                           [--cmsearch-mode {1,2}] [--greatest-hits]
                           [--gtf str] [--tr-list str]
                           [--tr-types str [str ...]]
                           [--gtf-feat-min-overlap float]
                           [--top-n-matched int] [--plot-abs-paths]
                           [--plot-pdf] [--meme-no-check] [--meme-no-pgc]
                           [--sort-js-mode {1,2,3}]

options:
  -h, --help            show this help message and exit
  --data-id str         Dataset ID
  --method-id str       Method ID
  --run-id str          Run ID
  --user-rbp-id str     Provide RBP ID belonging to provided sequence or
                        structure motif(s) (mandatory for --rbps USER)
  --user-meme-xml str   Provide MEME/DREME XML file containing sequence
                        motif(s) to be used for the run (needs --rbps USER)
  --user-cm str         Provide covariance model (.cm) file containing
                        covariance model(s) to be used for the run (needs
                        --rbps USER)
  --motif-db {1,2,3}    Built-in motif database to use. 1: human RBP motifs
                        (257 RBPs, 599 motifs,
                        "catrapid_omics_v2.1_human_6plus_ext"), 2: human RBP
                        motifs + 23 ucRBP motifs (277 RBPs, 622 motifs,
                        "catrapid_omics_v2.1_human_6plus_ext_ucrbps"), 3:
                        human RBP motifs from Ray et al. 2013 (80 RBPs, 102
                        motifs, "ray2013_human_rbps_rnacompete") (default: 1)
  --custom-db str       Provide custom motif database folder. Alternatively,
                        provide single files via --custom-db-meme-xml,
                        --custom-db-cm, --custom-db-info
  --custom-db-id str    Set ID/name for provided custom motif database via
                        --custom-db (default: "custom")
  --custom-db-meme-xml str
                        Provide custom motif database MEME/DREME XML file
                        containing sequence motifs
  --custom-db-cm str    Provide custom motif database covariance model (.cm)
                        file containing covariance model(s)
  --custom-db-info str  Provide custom motif database info table file
                        containing RBP ID -> motif ID -> motif type
                        assignments
  --motifs str [str ...]
                        Provide IDs for motifs of interest (need to be in
                        database and loaded). All other RBP motifs will be
                        discarded (except --regex)
  --motif-min-len int   Minimum MEME/DREME motif length to include in search.
                        By default all selected RBP motifs are used
  --motif-max-len int   Maximum MEME/DREME motif length to include in search.
                        By default all selected RBP motifs are used
  --functions str [str ...]
                        Filter defined RBPs (via --rbps) by their molecular
                        functions (annotations available for most database
                        RBPs). E.g. for RBPs in splicing regulation, set
                        --functions SR, for RBPs in RNA stability & decay plus
                        translation regulation, set --functions RSD TR (see
                        rbpbench info for full function descriptions). NOTE
                        that --regex is not affected by filtering
  --regex str           Define regular expression (regex) DNA motif to include
                        in search, e.g. --regex AAACC, --regex
                        'C[ACGT]AC[AC]', .. IUPAC code is also supported, e.g.
                        AAARN resolves to AAA[AG][ACGT]. Alternatively, supply
                        structure pattern, e.g. AA((((ARA))))AA or
                        CC(((A...R)))CC with variable spacer
  --regex-id str        Set regex ID used as RBP ID and database ID associated
                        to -regex hits (default: "regex")
  --motif-regex-id      Use --regex-id for motif ID as well. By default,
                        regular expression string is used as motif ID for
                        regex motif hits
  --regex-type {1,2,3}  Set type of supplied --regex string 1: auto-detect
                        type (standard regex or structure pattern). 2: given
                        --regex string is standard regex, e.g. AC[AG]T. 3:
                        given --regex string is structure pattern string, e.g.
                        ((AA(((...)))AA)) (default: 1)
  --regex-search-mode {1,2}
                        Define regex search mode. 1: when motif hit
                        encountered, continue +1 after motif hit start
                        position, 2: when motif hit encountered, continue +1
                        after motif hit end position. NOTE that structure
                        pattern regex currently always uses mode 1 (default:
                        1)
  --regex-min-gc float  Minimum GC base pair fraction to report structure
                        pattern regex hits (default: 0.0)
  --regex-max-gu float  Maximum GU (GT) base pair fraction to report structure
                        pattern regex hits (default: 1.0)
  --regex-spacer-min int
                        Minimum spacer length for structure pattern regex
                        search (default: 5)
  --regex-spacer-max int
                        Maximum spacer length for structure pattern regex
                        search (default: 200)
  --fimo-ntf-file str   Provide FIMO nucleotide frequencies (FIMO option:
                        --bfile) file (default: use internal frequencies file,
                        define which with --fimo-ntf-mode)
  --fimo-ntf-mode {1,2,3}
                        Set which internal nucleotide frequencies to use for
                        FIMO search. 1: use frequencies from human ENSEMBL
                        transcripts (excluding introns, A most prominent) 2:
                        use frequencies from human ENSEMBL transcripts
                        (including introns, resulting in lower G+C and T most
                        prominent) 3: use uniform frequencies (same for every
                        nucleotide) (default: 1)
  --fimo-pval float     FIMO p-value threshold (FIMO option: --thresh)
                        (default: 0.0005)
  --cmsearch-bs float   CMSEARCH bit score threshold (CMSEARCH options: -T
                        --incT). The higher the more strict (default: 1.0)
  --cmsearch-mode {1,2}
                        Set CMSEARCH mode to control strictness of filtering.
                        1: default setting (CMSEARCH option: --default). 2:
                        max setting (CMSEARCH option: --max), i.e., turn all
                        heuristic filters off, slower and more sensitive /
                        more hits) (default: 1)
  --greatest-hits       Keep only best FIMO/CMSEARCH motif hits (i.e., hit
                        with lowest p-value / highest bit score for each motif
                        sequence/site combination). By default, report all
                        hits (default: False)
  --gtf str             Input GTF file with genomic annotations to generate
                        genomic region annotation plots (output to motif
                        statistics HTML). By default the most prominent
                        transcripts will be extracted and used for functional
                        annotation. Alternatively, provide a list of expressed
                        transcripts via --tr-list (together with --gtf
                        containing the transcripts). Note that only features
                        on standard chromosomes (1,2,..,X,Y,MT) are currently
                        used for annotation
  --tr-list str         Supply file with transcript IDs (one ID per row) to
                        define which transcripts to use from --gtf for genomic
                        region annotations plots
  --tr-types str [str ...]
                        List of transcript biotypes to consider for genomic
                        region annotations plots. By default an internal
                        selection of transcript biotypes is used (in addition
                        to intron, CDS, UTR, intergenic). Note that provided
                        biotype strings need to be in --gtf GTF file
  --gtf-feat-min-overlap float
                        Minimum amount of overlap required for a region to be
                        assigned to a GTF feature (if less or no overlap,
                        region will be assigned to "intergenic"). If there is
                        overlap with several features, assign the one with
                        highest overlap (default: 0.1)
  --top-n-matched int   Set top n matched sequences to be displayed in motif
                        hit statistics HTML report (create via --plot-motifs)
                        (default: 10)
  --plot-abs-paths      Store plot files with absolute paths in HTML report.
                        Default is relative paths (default: False)
  --plot-pdf            Also output .png plots as .pdf in plotting subfolder
                        (default: False)
  --meme-no-check       Disable MEME version check. Make sure --meme-no-pgc is
                        set if MEME version >= 5.5.4 is installed! (default:
                        False)
  --meme-no-pgc         Manually set MEME's FIMO --no-pgc option (required for
                        MEME version >= 5.5.4). Make sure that MEME >= 5.5.4
                        is installed! (default: False)
  --sort-js-mode {1,2,3}
                        Define how to provide sorttable.js file. 1: link to
                        packaged .js file. 2: copy .js file to plots output
                        folder. 3: include .js code in HTML (default: 1)

required arguments:
  --in str              Genomic regions file in BED format OR file with
                        transcript IDs (one ID per row) to define genomic
                        regions in which to search for motifs (requires --gtf)
  --rbps str [str ...]  List of RBP names to define RBP motifs used for search
                        (--rbps rbp1 rbp2 .. ). To search with all available
                        motifs, use --rbps ALL. NOTE: to search with user-
                        provided motifs, set --rbps USER and provide --user-
                        meme-xml and/or --user-cm. To search only for --regex,
                        set --rbps REGEX
  --genome str          Genomic sequences file (currently supported formats:
                        FASTA)
  --out str             Results output folder
```


## rbpbench_searchrna

### Tool Description
Search for RNA-binding protein (RBP) motifs in transcript sites.

### Metadata
- **Docker Image**: quay.io/biocontainers/rbpbench:1.1.0--pyhdfd78af_0
- **Homepage**: https://github.com/michauhl/RBPBench
- **Package**: https://anaconda.org/channels/bioconda/packages/rbpbench/overview
- **Validation**: PASS

### Original Help Text
```text
usage: rbpbench searchrna [-h] --in str --rbps str [str ...] --gtf str
                          --genome str --out str [--data-id str]
                          [--method-id str] [--run-id str] [--ext str]
                          [--fisher-mode {1,2,3}] [--cooc-pval-thr float]
                          [--cooc-pval-mode {1,2,3}] [--min-motif-dist int]
                          [--max-motif-dist int] [--user-rbp-id str]
                          [--user-meme-xml str] [--user-cm str]
                          [--motif-db {1,2,3}] [--custom-db str]
                          [--custom-db-id str] [--custom-db-meme-xml str]
                          [--custom-db-cm str] [--custom-db-info str]
                          [--motifs str [str ...]] [--motif-min-len int]
                          [--motif-max-len int] [--functions str [str ...]]
                          [--regex str] [--regex-id str] [--motif-regex-id]
                          [--regex-type {1,2,3}] [--regex-search-mode {1,2}]
                          [--regex-min-gc float] [--regex-max-gu float]
                          [--regex-spacer-min int] [--regex-spacer-max int]
                          [--bed-score-col int] [--bed-sc-thr float]
                          [--bed-sc-thr-rev] [--fimo-ntf-file str]
                          [--fimo-ntf-mode {1,2,3}] [--fimo-pval float]
                          [--cmsearch-bs float] [--cmsearch-mode {1,2}]
                          [--greatest-hits] [--disable-kmer-pca-plot]
                          [--kmer-pca-plot-k int] [--kmer-pca-plot-no-comp]
                          [--kmer-pca-plot-comp-k {1,2}]
                          [--kmer-pca-plot-no-motifs] [--kmer-plot-k int]
                          [--set-rbp-id str] [--disable-len-dist-plot]
                          [--enable-upset-plot] [--upset-plot-min-degree int]
                          [--upset-plot-max-degree int]
                          [--upset-plot-min-subset-size int]
                          [--upset-plot-max-subset-rank int]
                          [--upset-plot-max-rbp-rank int]
                          [--upset-plot-min-rbp-count int]
                          [--motif-distance-plot-range int]
                          [--motif-min-pair-count int]
                          [--rbp-min-pair-count int] [--goa]
                          [--goa-obo-mode {1,2,3}] [--goa-obo-file str]
                          [--goa-gene2go-file str] [--goa-pval float]
                          [--goa-cooc-mode {1,2,3}] [--goa-bg-gene-list str]
                          [--goa-max-child int] [--goa-min-depth int]
                          [--goa-filter-purified] [--plot-abs-paths]
                          [--plot-pdf] [--meme-no-check] [--meme-no-pgc]
                          [--plot-motifs] [--top-n-matched int]
                          [--plotly-js-mode {1,2,3,4,5,6,7}]
                          [--sort-js-mode {1,2,3}]

options:
  -h, --help            show this help message and exit
  --data-id str         Dataset ID
  --method-id str       Method ID
  --run-id str          Run ID
  --ext str             Up- and downstream extension of --in transcript sites
                        in nucleotides (nt). Set e.g. --ext 30 for 30 nt on
                        both sides, or --ext 20,10 for different up- and
                        downstream extension. Note that complete extension
                        might not always be possible, e.g. for sites on short
                        transcripts or sites at transcript ends (default: 0)
  --fisher-mode {1,2,3}
                        Defines Fisher exact test alternative hypothesis for
                        testing co-occurrences of RBP motifs on --in sites. 1:
                        greater, 2: two-sided, 3: less (default: 1)
  --cooc-pval-thr float
                        RBP co-occurrence p-value threshold for reporting
                        significant co-occurrences. NOTE that if --cooc-pval-
                        mode Bonferroni is selected, this threshold gets
                        further adjusted by Bonferroni correction (i.e.
                        divided by number of tests). Threshold applies
                        unchanged for BH corrected p-values as well as for
                        disabled correction (default: 0.005)
  --cooc-pval-mode {1,2,3}
                        Defines multiple testing correction mode for co-
                        occurrence p-values. 1: Benjamini-Hochberg (BH), 2:
                        Bonferroni, 3: no correction (default: 1)
  --min-motif-dist int  Set minimum mean motif distance for an RBP pair to be
                        reported significant in RBP co-occurrence heatmap
                        plot. By default (value 0), all RBP pairs <= set
                        p-value are reported significant. So setting --min-
                        motif-dist >= 0 acts as a second filter to show only
                        RBP pairs with signficiant p-values as significant if
                        there is the specified minimum average distance
                        between their motifs (default: 0)
  --max-motif-dist int  Set maximum motif distance for RBP co-occurrence plot
                        statistic inside hover boxes (default: 20)
  --user-rbp-id str     Provide RBP ID belonging to provided sequence or
                        structure motif(s) (mandatory for --rbps USER)
  --user-meme-xml str   Provide MEME/DREME XML file containing sequence
                        motif(s) to be used for the run (needs --rbps USER)
  --user-cm str         Provide covariance model (.cm) file containing
                        covariance model(s) to be used for the run (needs
                        --rbps USER)
  --motif-db {1,2,3}    Built-in motif database to use. 1: human RBP motifs
                        (257 RBPs, 599 motifs,
                        "catrapid_omics_v2.1_human_6plus_ext"), 2: human RBP
                        motifs + 23 ucRBP motifs (277 RBPs, 622 motifs,
                        "catrapid_omics_v2.1_human_6plus_ext_ucrbps"), 3:
                        human RBP motifs from Ray et al. 2013 (80 RBPs, 102
                        motifs, "ray2013_human_rbps_rnacompete") (default: 1)
  --custom-db str       Provide custom motif database folder. Alternatively,
                        provide single files via --custom-db-meme-xml,
                        --custom-db-cm, --custom-db-info
  --custom-db-id str    Set ID/name for provided custom motif database via
                        --custom-db (default: "custom")
  --custom-db-meme-xml str
                        Provide custom motif database MEME/DREME XML file
                        containing sequence motifs
  --custom-db-cm str    Provide custom motif database covariance model (.cm)
                        file containing covariance model(s)
  --custom-db-info str  Provide custom motif database info table file
                        containing RBP ID -> motif ID -> motif type
                        assignments
  --motifs str [str ...]
                        Provide IDs for motifs of interest (need to be in
                        database and loaded). All other RBP motifs will be
                        discarded (except --regex)
  --motif-min-len int   Minimum MEME/DREME motif length to include in search.
                        By default all selected RBP motifs are used
  --motif-max-len int   Maximum MEME/DREME motif length to include in search.
                        By default all selected RBP motifs are used
  --functions str [str ...]
                        Filter defined RBPs (via --rbps) by their molecular
                        functions (annotations available for most database
                        RBPs). E.g. for RBPs in splicing regulation, set
                        --functions SR, for RBPs in RNA stability & decay plus
                        translation regulation, set --functions RSD TR (see
                        rbpbench info for full function descriptions). NOTE
                        that --regex is not affected by filtering
  --regex str           Define regular expression (regex) DNA motif to include
                        in search, e.g. --regex AAACC, --regex
                        'C[ACGT]AC[AC]', .. IUPAC code is also supported, e.g.
                        AAARN resolves to AAA[AG][ACGT]. Alternatively, supply
                        structure pattern, e.g. AA((((ARA))))AA or
                        CC(((A...R)))CC with variable spacer
  --regex-id str        Set regex ID used as RBP ID and database ID associated
                        to -regex hits (default: "regex")
  --motif-regex-id      Use --regex-id for motif ID as well. By default,
                        regular expression string is used as motif ID for
                        regex motif hits
  --regex-type {1,2,3}  Set type of supplied --regex string 1: auto-detect
                        type (standard regex or structure pattern). 2: given
                        --regex string is standard regex, e.g. AC[AG]T. 3:
                        given --regex string is structure pattern string, e.g.
                        ((AA(((...)))AA)) (default: 1)
  --regex-search-mode {1,2}
                        Define regex search mode. 1: when motif hit
                        encountered, continue +1 after motif hit start
                        position, 2: when motif hit encountered, continue +1
                        after motif hit end position. NOTE that structure
                        pattern regex currently always uses mode 1 (default:
                        1)
  --regex-min-gc float  Minimum GC base pair fraction to report structure
                        pattern regex hits (default: 0.0)
  --regex-max-gu float  Maximum GU (GT) base pair fraction to report structure
                        pattern regex hits (default: 1.0)
  --regex-spacer-min int
                        Minimum spacer length for structure pattern regex
                        search (default: 5)
  --regex-spacer-max int
                        Maximum spacer length for structure pattern regex
                        search (default: 200)
  --bed-score-col int   --in BED score column used for p-value calculations.
                        BED score can be e.g. log2 fold change or -log10
                        p-value of the region (default: 5)
  --bed-sc-thr float    Minimum site score (by default: --in BED column 5, or
                        set via --bed-score-col) for filtering (assuming
                        higher score == better site) (default: None)
  --bed-sc-thr-rev      Reverse --bed-sc-thr filtering (i.e. the lower the
                        better, e.g. if score column contains p-values)
                        (default: False)
  --fimo-ntf-file str   Provide FIMO nucleotide frequencies (FIMO option:
                        --bfile) file (default: use internal frequencies file,
                        define which with --fimo-ntf-mode)
  --fimo-ntf-mode {1,2,3}
                        Set which internal nucleotide frequencies to use for
                        FIMO search. 1: use frequencies from human ENSEMBL
                        transcripts (excluding introns, A most prominent) 2:
                        use frequencies from human ENSEMBL transcripts
                        (including introns, resulting in lower G+C and T most
                        prominent) 3: use uniform frequencies (same for every
                        nucleotide) (default: 1)
  --fimo-pval float     FIMO p-value threshold (FIMO option: --thresh)
                        (default: 0.0005)
  --cmsearch-bs float   CMSEARCH bit score threshold (CMSEARCH options: -T
                        --incT). The higher the more strict (default: 1.0)
  --cmsearch-mode {1,2}
                        Set CMSEARCH mode to control strictness of filtering.
                        1: default setting (CMSEARCH option: --default). 2:
                        max setting (CMSEARCH option: --max), i.e., turn all
                        heuristic filters off, slower and more sensitive /
                        more hits) (default: 1)
  --greatest-hits       Keep only best FIMO/CMSEARCH motif hits (i.e., hit
                        with lowest p-value / highest bit score for each motif
                        sequence/site combination). By default, report all
                        hits (default: False)
  --disable-kmer-pca-plot
                        Disable input sequences by k-mer content PCA plot
                        (default: False)
  --kmer-pca-plot-k int
                        Set k for k-mer usage in sequences by k-mer content
                        PCA plot (default: 3)
  --kmer-pca-plot-no-comp
                        Disable adding sequence complexity as feature to
                        sequences by k-mer content PCA plot (default: False)
  --kmer-pca-plot-comp-k {1,2}
                        Set k for sequence complexity (Shannon entropy)
                        calculation. 1 == mono-nucleotides, 2 == di-
                        nucleotides (default: 1)
  --kmer-pca-plot-no-motifs
                        Disable adding motif hits information to sequences by
                        k-mer content PCA plot (default: False)
  --kmer-plot-k int     Define k for k-mer distribution plots, including top
                        k-mers plot, top vs bottom scoring sites plot, and
                        k-mer variation plot (default: 4)
  --set-rbp-id str      Set reference RBP ID to plot motif distances relative
                        to motifs from this RBP (needs to be one of the
                        selected RBP IDs!). Motif plot will be centered on
                        best scoring motif of the RBP for each region
  --disable-len-dist-plot
                        Disable input sequence length distribution plot in
                        HTML report (default: False)
  --enable-upset-plot   Enable upset plot in HTML report (default: False)
  --upset-plot-min-degree int
                        Upset plot minimum degree parameter (default: 2)
  --upset-plot-max-degree int
                        Upset plot maximum degree. By default no maximum
                        degree is set. Useful to look at specific degrees only
                        (together with --upset-plot-min-degree), e.g. 2 or 2
                        to 3 (default: None)
  --upset-plot-min-subset-size int
                        Upset plot minimum subset size (default: 5)
  --upset-plot-max-subset-rank int
                        Upset plot maximum subset rank to plot. All tied
                        subsets are included (default: 25)
  --upset-plot-max-rbp-rank int
                        Maximum RBP hit region count rank. Set this to limit
                        the amount of RBPs included in upset plot (+ statistic
                        !) to top --upset-plot-max-rbp-rank RBPs. By default
                        all RBPs are included (default: None)
  --upset-plot-min-rbp-count int
                        Minimum amount of input sites containing motifs for an
                        RBP in order for the RBP to be included in upset plot
                        (+ statistic !). By default, all RBPs are included,
                        also RBPs without hit regions (default: 0)
  --motif-distance-plot-range int
                        Set range of motif distance plot. I.e., centered on
                        the set RBP (--set-rbp-id) motifs, motifs within minus
                        and plus --motif-distance-plot-range will be plotted
                        (default: 50)
  --motif-min-pair-count int
                        On single motif level, minimum count of co-occurrences
                        of a motif with set RBP ID (--set-rbp-id) motif to be
                        reported and plotted (default: 10)
  --rbp-min-pair-count int
                        On RBP level, minimum amount of co-occurrences of
                        motifs for an RBP ID compared to set RBP ID (--set-
                        rbp-id) motifs to be reported and plotted (default:
                        10)
  --goa                 Run gene ontology (GO) enrichment analysis on genes
                        occupied by --in regions. Requires --gtf (default:
                        False)
  --goa-obo-mode {1,2,3}
                        Define how to obtain GO DAG (directed acyclic graph)
                        obo file. 1: download most recent file from internet,
                        2: use local file, 3: provide file via --goa-obo-file
                        (default: 1)
  --goa-obo-file str    Provide GO DAG obo file (default: False)
  --goa-gene2go-file str
                        Provide gene ID to GO IDs mapping table (row format:
                        gene_id<tab>go_id1,go_id2). By default, a local file
                        with ENSEMBL gene IDs is used. NOTE that gene IDs need
                        to be compatible with --gtf (default: False)
  --goa-pval float      GO enrichment analysis p-value threshold (applied on
                        corrected p-value) (default: 0.05)
  --goa-cooc-mode {1,2,3}
                        Define what input regions to consider in GOA, in
                        relation to motif hit (co-)occurrences. 1: Perform GOA
                        on all input regions (no motif (co-)occurrences
                        required). 2: perform GOA only on input regions with
                        motif hits from ANY specified RBP. 3: perform GOA only
                        on input regions with motif hits from ALL specified
                        RBPs. GOA on input regions translates to GOA on the
                        underlying genes (default: 1)
  --goa-bg-gene-list str
                        Supply file with gene IDs (one ID per row) to use as
                        background gene list for GOA. NOTE that gene IDs need
                        to be compatible with --gtf (default: False)
  --goa-max-child int   Specify maximum number of children for a significant
                        GO term to be reported in HTML table, e.g. --goa-max-
                        child 100. This allows filtering out very broad terms
                        (default: None)
  --goa-min-depth int   Specify minimum depth number for a significant GO term
                        to be reported in HTML table, e.g. --goa-min-depth 5
                        (default: None)
  --goa-filter-purified
                        Filter out GOA results labeled as purified (i.e., GO
                        terms with significantly lower concentration) in HTML
                        table (default: False)
  --plot-abs-paths      Store plot files with absolute paths in HTML report.
                        Default is relative paths (default: False)
  --plot-pdf            Also output .png plots as .pdf in plotting subfolder
                        (default: False)
  --meme-no-check       Disable MEME version check. Make sure --meme-no-pgc is
                        set if MEME version >= 5.5.4 is installed! (default:
                        False)
  --meme-no-pgc         Manually set MEME's FIMO --no-pgc option (required for
                        MEME version >= 5.5.4). Make sure that MEME >= 5.5.4
                        is installed! (default: False)
  --plot-motifs         Visualize selected sequence motifs, by outputting
                        sequence logos and motif hit statistics into a
                        separate .html file (default: False)
  --top-n-matched int   Set top n matched sequences to be displayed in motif
                        hit statistics HTML report (create via --plot-motifs)
                        (default: 10)
  --plotly-js-mode {1,2,3,4,5,6,7}
                        Define how to provide plotly .js file. 1: use online
                        version via "cdn" (requires internet connection). 2:
                        link to packaged plotly .js file. 3: copy plotly .js
                        file to plots output folder. 4: include plotly .js
                        code in plotly HTML. 5: put web version link and
                        plotly plot codes into main HTML. 6: put local version
                        link and plotly plot codes in main HTML. 7: put plotly
                        js and plotly plot codes into main HTML! (default: 1)
  --sort-js-mode {1,2,3}
                        Define how to provide sorttable.js file. 1: link to
                        packaged .js file. 2: copy .js file to plots output
                        folder. 3: include .js code in HTML (default: 1)

required arguments:
  --in str              Transcript sites file in BED format. Column 1 is
                        transcript ID (ID needs to be in --gtf), column 2 and
                        3 are start and end coordinates of site on the
                        transcript
  --rbps str [str ...]  List of RBP names to define RBP motifs used for search
                        (--rbps rbp1 rbp2 .. ). To search with all available
                        motifs, use --rbps ALL. NOTE: to search with user-
                        provided motifs, set --rbps USER and provide --user-
                        meme-xml and/or --user-cm. To search only for --regex,
                        set --rbps REGEX
  --gtf str             Input GTF file with genomic annotations to extract
                        spliced transcript sequences for provided --in
                        transcript sites. Note that only features on standard
                        chromosomes (1,2,..,X,Y,MT) are currently considered
  --genome str          Genomic sequences file (currently supported formats:
                        FASTA)
  --out str             Results output folder
```


## rbpbench_searchlongrna

### Tool Description
Search for RBP motifs in long RNA sequences.

### Metadata
- **Docker Image**: quay.io/biocontainers/rbpbench:1.1.0--pyhdfd78af_0
- **Homepage**: https://github.com/michauhl/RBPBench
- **Package**: https://anaconda.org/channels/bioconda/packages/rbpbench/overview
- **Validation**: PASS

### Original Help Text
```text
usage: rbpbench searchlongrna [-h] --rbps str [str ...] --gtf str --genome str
                              --out str [--data-id str] [--method-id str]
                              [--run-id str] [--user-rbp-id str]
                              [--user-meme-xml str] [--user-cm str]
                              [--motif-db {1,2,3}] [--custom-db str]
                              [--custom-db-id str] [--custom-db-meme-xml str]
                              [--custom-db-cm str] [--custom-db-info str]
                              [--motifs str [str ...]] [--motif-min-len int]
                              [--motif-max-len int]
                              [--functions str [str ...]] [--regex str]
                              [--regex-id str] [--motif-regex-id]
                              [--regex-type {1,2,3}]
                              [--regex-search-mode {1,2}]
                              [--regex-min-gc float] [--regex-max-gu float]
                              [--regex-spacer-min int]
                              [--regex-spacer-max int] [--fimo-ntf-file str]
                              [--fimo-ntf-mode {1,2,3}] [--fimo-pval float]
                              [--cmsearch-bs float] [--cmsearch-mode {1,2}]
                              [--greatest-hits] [--tr-list str]
                              [--gtf-feat-min-overlap float] [--goa]
                              [--goa-obo-mode {1,2,3}] [--goa-obo-file str]
                              [--goa-gene2go-file str] [--goa-pval float]
                              [--goa-max-child int] [--goa-min-depth int]
                              [--goa-filter-purified] [--goa-only-cooc]
                              [--goa-rna-region {1,2,3,4}]
                              [--top-n-matched int] [--plot-abs-paths]
                              [--plot-pdf] [--meme-no-check] [--meme-no-pgc]
                              [--mrna-only] [--mrna-norm-mode {1,2}]
                              [--sort-js-mode {1,2,3}]

options:
  -h, --help            show this help message and exit
  --data-id str         Dataset ID
  --method-id str       Method ID
  --run-id str          Run ID
  --user-rbp-id str     Provide RBP ID belonging to provided sequence or
                        structure motif(s) (mandatory for --rbps USER)
  --user-meme-xml str   Provide MEME/DREME XML file containing sequence
                        motif(s) to be used for the run (needs --rbps USER)
  --user-cm str         Provide covariance model (.cm) file containing
                        covariance model(s) to be used for the run (needs
                        --rbps USER)
  --motif-db {1,2,3}    Built-in motif database to use. 1: human RBP motifs
                        (257 RBPs, 599 motifs,
                        "catrapid_omics_v2.1_human_6plus_ext"), 2: human RBP
                        motifs + 23 ucRBP motifs (277 RBPs, 622 motifs,
                        "catrapid_omics_v2.1_human_6plus_ext_ucrbps"), 3:
                        human RBP motifs from Ray et al. 2013 (80 RBPs, 102
                        motifs, "ray2013_human_rbps_rnacompete") (default: 1)
  --custom-db str       Provide custom motif database folder. Alternatively,
                        provide single files via --custom-db-meme-xml,
                        --custom-db-cm, --custom-db-info
  --custom-db-id str    Set ID/name for provided custom motif database via
                        --custom-db (default: "custom")
  --custom-db-meme-xml str
                        Provide custom motif database MEME/DREME XML file
                        containing sequence motifs
  --custom-db-cm str    Provide custom motif database covariance model (.cm)
                        file containing covariance model(s)
  --custom-db-info str  Provide custom motif database info table file
                        containing RBP ID -> motif ID -> motif type
                        assignments
  --motifs str [str ...]
                        Provide IDs for motifs of interest (need to be in
                        database and loaded). All other RBP motifs will be
                        discarded (except --regex)
  --motif-min-len int   Minimum MEME/DREME motif length to include in search.
                        By default all selected RBP motifs are used
  --motif-max-len int   Maximum MEME/DREME motif length to include in search.
                        By default all selected RBP motifs are used
  --functions str [str ...]
                        Filter defined RBPs (via --rbps) by their molecular
                        functions (annotations available for most database
                        RBPs). E.g. for RBPs in splicing regulation, set
                        --functions SR, for RBPs in RNA stability & decay plus
                        translation regulation, set --functions RSD TR (see
                        rbpbench info for full function descriptions). NOTE
                        that --regex is not affected by filtering
  --regex str           Define regular expression (regex) DNA motif to include
                        in search, e.g. --regex AAACC, --regex
                        'C[ACGT]AC[AC]', .. IUPAC code is also supported, e.g.
                        AAARN resolves to AAA[AG][ACGT]. Alternatively, supply
                        structure pattern, e.g. AA((((ARA))))AA or
                        CC(((A...R)))CC with variable spacer
  --regex-id str        Set regex ID used as RBP ID and database ID associated
                        to -regex hits (default: "regex")
  --motif-regex-id      Use --regex-id for motif ID as well. By default,
                        regular expression string is used as motif ID for
                        regex motif hits
  --regex-type {1,2,3}  Set type of supplied --regex string 1: auto-detect
                        type (standard regex or structure pattern). 2: given
                        --regex string is standard regex, e.g. AC[AG]T. 3:
                        given --regex string is structure pattern string, e.g.
                        ((AA(((...)))AA)) (default: 1)
  --regex-search-mode {1,2}
                        Define regex search mode. 1: when motif hit
                        encountered, continue +1 after motif hit start
                        position, 2: when motif hit encountered, continue +1
                        after motif hit end position. NOTE that structure
                        pattern regex currently always uses mode 1 (default:
                        1)
  --regex-min-gc float  Minimum GC base pair fraction to report structure
                        pattern regex hits (default: 0.0)
  --regex-max-gu float  Maximum GU (GT) base pair fraction to report structure
                        pattern regex hits (default: 1.0)
  --regex-spacer-min int
                        Minimum spacer length for structure pattern regex
                        search (default: 5)
  --regex-spacer-max int
                        Maximum spacer length for structure pattern regex
                        search (default: 200)
  --fimo-ntf-file str   Provide FIMO nucleotide frequencies (FIMO option:
                        --bfile) file (default: use internal frequencies file,
                        define which with --fimo-ntf-mode)
  --fimo-ntf-mode {1,2,3}
                        Set which internal nucleotide frequencies to use for
                        FIMO search. 1: use frequencies from human ENSEMBL
                        transcripts (excluding introns, A most prominent) 2:
                        use frequencies from human ENSEMBL transcripts
                        (including introns, resulting in lower G+C and T most
                        prominent) 3: use uniform frequencies (same for every
                        nucleotide) (default: 1)
  --fimo-pval float     FIMO p-value threshold (FIMO option: --thresh)
                        (default: 0.0005)
  --cmsearch-bs float   CMSEARCH bit score threshold (CMSEARCH options: -T
                        --incT). The higher the more strict (default: 1.0)
  --cmsearch-mode {1,2}
                        Set CMSEARCH mode to control strictness of filtering.
                        1: default setting (CMSEARCH option: --default). 2:
                        max setting (CMSEARCH option: --max), i.e., turn all
                        heuristic filters off, slower and more sensitive /
                        more hits) (default: 1)
  --greatest-hits       Keep only best FIMO/CMSEARCH motif hits (i.e., hit
                        with lowest p-value / highest bit score for each motif
                        sequence/site combination). By default, report all
                        hits (default: False)
  --tr-list str         Supply file with transcript IDs (one ID per row) to
                        define which transcripts to use from --gtf
  --gtf-feat-min-overlap float
                        Minimum amount of overlap required for a motif hit to
                        be assigned to a GTF feature (if less or no overlap,
                        region will be assigned to "intergenic") (default:
                        0.1)
  --goa                 Run gene ontology (GO) enrichment analysis on
                        transcripts (i.e., their corresponding genes) with
                        motif hits. Requires --gtf (default: False)
  --goa-obo-mode {1,2,3}
                        Define how to obtain GO DAG (directed acyclic graph)
                        obo file. 1: download most recent file from internet,
                        2: use local file, 3: provide file via --goa-obo-file
                        (default: 1)
  --goa-obo-file str    Provide GO DAG obo file (default: False)
  --goa-gene2go-file str
                        Provide gene ID to GO IDs mapping table (row format:
                        gene_id<tab>go_id1,go_id2). By default, a local file
                        with ENSEMBL gene IDs is used. NOTE that gene IDs need
                        to be compatible with --gtf (default: False)
  --goa-pval float      GO enrichment analysis p-value threshold (applied on
                        corrected p-value) (default: 0.05)
  --goa-max-child int   Specify maximum number of children for a significant
                        GO term to be reported in HTML table, e.g. --goa-max-
                        child 200. This allows filtering out very broad terms
                        (default: None)
  --goa-min-depth int   Specify minimum depth number for a significant GO term
                        to be reported in HTML table, e.g. --goa-min-depth 5
                        (default: None)
  --goa-filter-purified
                        Filter out GOA results labeled as purified (i.e., GO
                        terms with significantly lower concentration) in HTML
                        table (default: False)
  --goa-only-cooc       Only look at regions in GO enrichment analysis which
                        contain motifs by all specified RBPs (default: False)
  --goa-rna-region {1,2,3,4}
                        Define which (m)RNA region to use for motif hit GO
                        enrichment analysis. 1: whole transcript, 2: only
                        3'UTR regions, 3: only CDS regions, 4: only 5'UTR
                        regions (default: 1)
  --top-n-matched int   Set top n matched sequences to be displayed in motif
                        hit statistics HTML report (create via --plot-motifs)
                        (default: 10)
  --plot-abs-paths      Store plot files with absolute paths in HTML report.
                        Default is relative paths (default: False)
  --plot-pdf            Also output .png plots as .pdf in plotting subfolder
                        (default: False)
  --meme-no-check       Disable MEME version check. Make sure --meme-no-pgc is
                        set if MEME version >= 5.5.4 is installed! (default:
                        False)
  --meme-no-pgc         Manually set MEME's FIMO --no-pgc option (required for
                        MEME version >= 5.5.4). Make sure that MEME >= 5.5.4
                        is installed! (default: False)
  --mrna-only           Set if only mRNAs should be extracted from --gtf file
                        for motif search and plotting of mRNA region
                        occupancies. To look only at specific mRNAs, use --tr-
                        list and --mrna-only (default: False)
  --mrna-norm-mode {1,2}
                        Define whether to use median or mean mRNA region
                        lengths for plotting. 1: median. 2: mean (default: 1)
  --sort-js-mode {1,2,3}
                        Define how to provide sorttable.js file. 1: link to
                        packaged .js file. 2: copy .js file to plots output
                        folder. 3: include .js code in HTML (default: 1)

required arguments:
  --rbps str [str ...]  List of RBP names to define RBP motifs used for search
                        (--rbps rbp1 rbp2 .. ). To search with all available
                        motifs, use --rbps ALL. NOTE: to search with user-
                        provided motifs, set --rbps USER and provide --user-
                        meme-xml and/or --user-cm. To search only for --regex,
                        set --rbps REGEX
  --gtf str             Input GTF file with genomic annotations to extract
                        spliced RNA sequences. By default the most prominent
                        transcript will be extracted and used for each gene.
                        Alternatively, provide a list of expressed transcripts
                        via --tr-list (together with --gtf containing the
                        transcripts). Note that only features on standard
                        chromosomes (1,2,..,X,Y,MT) are currently considered
  --genome str          Genomic sequences file (currently supported formats:
                        FASTA)
  --out str             Results output folder
```


## rbpbench_enmo

### Tool Description
Performs motif enrichment analysis on specified regions.

### Metadata
- **Docker Image**: quay.io/biocontainers/rbpbench:1.1.0--pyhdfd78af_0
- **Homepage**: https://github.com/michauhl/RBPBench
- **Package**: https://anaconda.org/channels/bioconda/packages/rbpbench/overview
- **Validation**: PASS

### Original Help Text
```text
usage: rbpbench enmo [-h] --in str --rbps str [str ...] --gtf str --genome str
                     --out str [--user-rbp-id str] [--user-meme-xml str]
                     [--user-cm str] [--ext str] [--motif-db {1,2,3}]
                     [--custom-db str] [--custom-db-id str]
                     [--custom-db-meme-xml str] [--custom-db-cm str]
                     [--custom-db-info str] [--motifs str [str ...]]
                     [--motif-min-len int] [--motif-max-len int]
                     [--functions str [str ...]] [--regex str]
                     [--regex-id str] [--motif-regex-id]
                     [--regex-type {1,2,3}] [--regex-search-mode {1,2}]
                     [--regex-min-gc float] [--regex-max-gu float]
                     [--regex-spacer-min int] [--regex-spacer-max int]
                     [--bed-score-col int] [--bed-sc-thr float]
                     [--bed-sc-thr-rev] [--bg-mode {1,2}] [--bg-min-size int]
                     [--bg-mask-bed str] [--bg-mask-blacklist]
                     [--bg-incl-bed str] [--bg-ada-sampling]
                     [--bg-shuff-factor int] [--bg-shuff-k int]
                     [--random-seed int] [--tr-list str]
                     [--gtf-feat-min-overlap float] [--fimo-ntf-file str]
                     [--fimo-ntf-mode {1,2,3}] [--fimo-pval float]
                     [--cmsearch-bs float] [--cmsearch-mode {1,2}]
                     [--greatest-hits] [--fisher-mode {1,2,3}]
                     [--enmo-pval-thr float] [--enmo-pval-mode {1,2,3}]
                     [--cooc-pval-thr float] [--cooc-pval-mode {1,2,3}]
                     [--min-motif-dist int] [--max-motif-dist int]
                     [--motif-sim-thr float] [--motif-sim-cap float]
                     [--motif-sim-norm] [--plot-abs-paths] [--plot-pdf]
                     [--meme-no-check] [--meme-no-pgc]
                     [--plotly-js-mode {1,2,3,4,5,6,7}]
                     [--sort-js-mode {1,2,3}]

options:
  -h, --help            show this help message and exit
  --user-rbp-id str     Provide RBP ID belonging to provided sequence or
                        structure motif(s) (mandatory for --rbps USER)
  --user-meme-xml str   Provide MEME/DREME XML file containing sequence
                        motif(s) to be used for the run (needs --rbps USER)
  --user-cm str         Provide covariance model (.cm) file containing
                        covariance model(s) to be used for the run (needs
                        --rbps USER)
  --ext str             Up- and downstream extension of --in sites in
                        nucleotides (nt). Set e.g. --ext 30 for 30 nt on both
                        sides, or --ext 20,10 for different up- and downstream
                        extension (default: 0)
  --motif-db {1,2,3}    Built-in motif database to use. 1: human RBP motifs
                        (257 RBPs, 599 motifs,
                        "catrapid_omics_v2.1_human_6plus_ext"), 2: human RBP
                        motifs + 23 ucRBP motifs (277 RBPs, 622 motifs,
                        "catrapid_omics_v2.1_human_6plus_ext_ucrbps"), 3:
                        human RBP motifs from Ray et al. 2013 (80 RBPs, 102
                        motifs, "ray2013_human_rbps_rnacompete") (default: 1)
  --custom-db str       Provide custom motif database folder. Alternatively,
                        provide single files via --custom-db-meme-xml,
                        --custom-db-cm, --custom-db-info
  --custom-db-id str    Set ID/name for provided custom motif database via
                        --custom-db (default: "custom")
  --custom-db-meme-xml str
                        Provide custom motif database MEME/DREME XML file
                        containing sequence motifs
  --custom-db-cm str    Provide custom motif database covariance model (.cm)
                        file containing covariance model(s)
  --custom-db-info str  Provide custom motif database info table file
                        containing RBP ID -> motif ID -> motif type
                        assignments
  --motifs str [str ...]
                        Provide IDs for motifs of interest (need to be in
                        database and loaded). All other RBP motifs will be
                        discarded (except --regex)
  --motif-min-len int   Minimum MEME/DREME motif length to include in search.
                        By default all selected RBP motifs are used
  --motif-max-len int   Maximum MEME/DREME motif length to include in search.
                        By default all selected RBP motifs are used
  --functions str [str ...]
                        Filter defined RBPs (via --rbps) by their molecular
                        functions (annotations available for most database
                        RBPs). E.g. for RBPs in splicing regulation, set
                        --functions SR, for RBPs in RNA stability & decay plus
                        translation regulation, set --functions RSD TR (see
                        rbpbench info for full function descriptions). NOTE
                        that --regex is not affected by filtering
  --regex str           Define regular expression (regex) DNA motif to include
                        in search, e.g. --regex AAACC, --regex
                        'C[ACGT]AC[AC]', .. IUPAC code is also supported, e.g.
                        AAARN resolves to AAA[AG][ACGT]. Alternatively, supply
                        structure pattern, e.g. AA((((ARA))))AA or
                        CC(((A...R)))CC with variable spacer
  --regex-id str        Set regex ID used as RBP ID and database ID associated
                        to -regex hits (default: "regex")
  --motif-regex-id      Use --regex-id for motif ID as well. By default,
                        regular expression string is used as motif ID for
                        regex motif hits
  --regex-type {1,2,3}  Set type of supplied --regex string 1: auto-detect
                        type (standard regex or structure pattern). 2: given
                        --regex string is standard regex, e.g. AC[AG]T. 3:
                        given --regex string is structure pattern string, e.g.
                        ((AA(((...)))AA)) (default: 1)
  --regex-search-mode {1,2}
                        Define regex search mode. 1: when motif hit
                        encountered, continue +1 after motif hit start
                        position, 2: when motif hit encountered, continue +1
                        after motif hit end position. NOTE that structure
                        pattern regex currently always uses mode 1 (default:
                        1)
  --regex-min-gc float  Minimum GC base pair fraction to report structure
                        pattern regex hits (default: 0.0)
  --regex-max-gu float  Maximum GU (GT) base pair fraction to report structure
                        pattern regex hits (default: 1.0)
  --regex-spacer-min int
                        Minimum spacer length for structure pattern regex
                        search (default: 5)
  --regex-spacer-max int
                        Maximum spacer length for structure pattern regex
                        search (default: 200)
  --bed-score-col int   --in BED score column used for p-value calculations.
                        BED score can be e.g. log2 fold change or -log10
                        p-value of the region (default: 5)
  --bed-sc-thr float    Minimum site score (by default: --in BED column 5, or
                        set via --bed-score-col) for filtering (assuming
                        higher score == better site) (default: None)
  --bed-sc-thr-rev      Reverse --bed-sc-thr filtering (i.e. the lower the
                        better, e.g. if score column contains p-values)
                        (default: False)
  --bg-mode {1,2}       Define how to generate the background regions dataset
                        1: depending on type of --in sites (transcript,
                        genomic), sample random regions with same length
                        distribution from transcript or gene regions (based on
                        given --gtf), 2: shuffle --in site sequences (di-
                        nucleotide shuffling) and use these as background
                        (default: 1)
  --bg-min-size int     Minimum size of background set to be used for
                        calculating motif enrichment. If size <= --in set
                        size, use --in set size. If size > --in set size,
                        double the --in set until it is <= size. Only applies
                        for --bg-mode 1. For --bg-mode 2, you can use --bg-
                        shuff-factor (default: 5000)
  --bg-mask-bed str     Additional BED regions file (6-column format) for
                        masking regions (i.e. no background sites should be
                        extracted from --bg-mask-bed regions)
  --bg-mask-blacklist   Add ENCODE blacklist regions (hg38) to excluded
                        regions set, i.e. do not sample from these blacklisted
                        regions (default: False)
  --bg-incl-bed str     Supply BED regions file (6-column format) to define
                        from which regions to extract background sites. Make
                        sure that regions are compatible with --in sites
                        (genomic or transcript). By default, representative
                        transcript regions for all genes from --gtf are used
                        for this. Note that if extraction of needed number of
                        background sites from --bg-incl-bed fails, all
                        transcripts will be used in second try (or define
                        which to use with --tr-list). Also note that --ada-
                        sampling only applies to interally generated list of
                        regions
  --bg-ada-sampling     If --bg-mode 1 and input sites genomic, instead of
                        random background sampling, sample adjusted to intron
                        ratio of input sites (default: False)
  --bg-shuff-factor int
                        Define number of times the size of the shuffled set
                        (--bg-mode 2 set) should be compared to --in set
                        (default: 1)
  --bg-shuff-k int      Define k for k-nt shuffling --in set to create
                        background set (default: 2)
  --random-seed int     Set a fixed random seed number (e.g. --random-seed 1)
                        to obtain reproducible sampling results (default:
                        None)
  --tr-list str         Supply file with transcript IDs (one ID per row) to
                        define which transcripts to use from --gtf to extract
                        background sites
  --gtf-feat-min-overlap float
                        Minimum amount of overlap required for a region to be
                        assigned to a GTF feature (default: 0.1)
  --fimo-ntf-file str   Provide FIMO nucleotide frequencies (FIMO option:
                        --bfile) file (default: use internal frequencies file,
                        define which with --fimo-ntf-mode)
  --fimo-ntf-mode {1,2,3}
                        Set which internal nucleotide frequencies to use for
                        FIMO search. 1: use frequencies from human ENSEMBL
                        transcripts (excluding introns, A most prominent) 2:
                        use frequencies from human ENSEMBL transcripts
                        (including introns, resulting in lower G+C and T most
                        prominent) 3: use uniform frequencies (same for every
                        nucleotide) (default: 1)
  --fimo-pval float     FIMO p-value threshold (FIMO option: --thresh)
                        (default: 0.0005)
  --cmsearch-bs float   CMSEARCH bit score threshold (CMSEARCH options: -T
                        --incT). The higher the more strict (default: 1.0)
  --cmsearch-mode {1,2}
                        Set CMSEARCH mode to control strictness of filtering.
                        1: default setting (CMSEARCH option: --default). 2:
                        max setting (CMSEARCH option: --max), i.e., turn all
                        heuristic filters off, slower and more sensitive /
                        more hits) (default: 1)
  --greatest-hits       Keep only best FIMO/CMSEARCH motif hits (i.e., hit
                        with lowest p-value / highest bit score for each motif
                        sequence/site combination). By default, report all
                        hits (default: False)
  --fisher-mode {1,2,3}
                        Defines Fisher exact test alternative hypothesis for
                        testing motif enrichment in --in sites compared to
                        generated background / control sites. 1: greater, 2:
                        two-sided, 3: less. Setting is used both for motif
                        enrichment and co-occurrence Fisher test (default: 1)
  --enmo-pval-thr float
                        P-value threshold for reporting significantly enriched
                        motifs. NOTE that if --enmo-pval-mode Bonferroni is
                        selected, this threshold gets further adjusted by
                        Bonferroni correction (i.e. divided by number of
                        tests). Threshold applies unchanged for BH corrected
                        p-values as well as for disabled correction (default:
                        0.001)
  --enmo-pval-mode {1,2,3}
                        Defines multiple testing correction mode for motif
                        enrichment p-values. 1: Benjamini-Hochberg (BH), 2:
                        Bonferroni, 3: no correction (default: 1)
  --cooc-pval-thr float
                        Motif co-occurrence p-value threshold for reporting
                        significant motif co-occurrences. NOTE that if --cooc-
                        pval-mode Bonferroni is selected, this threshold gets
                        further adjusted by Bonferroni correction (i.e.
                        divided by number of tests). Threshold applies
                        unchanged for BH corrected p-values as well as for
                        disabled correction (default: 0.005)
  --cooc-pval-mode {1,2,3}
                        Defines multiple testing correction mode for co-
                        occurrence p-values. 1: Benjamini-Hochberg (BH), 2:
                        Bonferroni, 3: no correction (default: 1)
  --min-motif-dist int  Set minimum mean motif distance for motif pair to be
                        reported significant in motif co-occurrence heatmap
                        plot. By default (value 0), all motif pairs <= set
                        p-value are reported significant. So setting --min-
                        motif-dist >= 0 acts as a second filter to show only
                        motif pairs with signficiant p-values as significant
                        if there is the specified minimum average distance
                        between their motif hits (default: 0)
  --max-motif-dist int  Set maximum motif distance for motif co-occurrence
                        plot statistic inside hover boxes (default: 20)
  --motif-sim-thr float
                        Set motif pair similarity threshold for to filter out
                        significantly co-occurring motifs that are similar to
                        each other. Similarity between motifs is measured in
                        -log10(TOMTOM p-value), so the larger the pair
                        similarity value of two motifs, the more similar they
                        are. E.g., --motif-sim-thr 2 corresponds to TOMTOM
                        p-value of 0.01, to filter out motif pairs > 2
                        similarity (default: None)
  --motif-sim-cap float
                        Cap maximum motif similarity value to given value
                        (default: 50)
  --motif-sim-norm      Normalize motif similarities (min-max normalization)
                        for PCA plot (default: False)
  --plot-abs-paths      Store plot files with absolute paths in HTML files.
                        Default is relative paths (default: False)
  --plot-pdf            Also output .png plots as .pdf in plotting subfolder
                        (default: False)
  --meme-no-check       Disable MEME version check. Make sure --meme-no-pgc is
                        set if MEME version >= 5.5.4 is installed! (default:
                        False)
  --meme-no-pgc         Manually set MEME's FIMO --no-pgc option (required for
                        MEME version >= 5.5.4). Make sure that MEME >= 5.5.4
                        is installed! (default: False)
  --plotly-js-mode {1,2,3,4,5,6,7}
                        Define how to provide plotly .js file. 1: use online
                        version via "cdn" (requires internet connection). 2:
                        link to packaged plotly .js file. 3: copy plotly .js
                        file to plots output folder. 4: include plotly .js
                        code in plotly HTML. 5: put web version link and
                        plotly plot codes into main HTML. 6: put local version
                        link and plotly plot codes in main HTML. 7: put plotly
                        js and plotly plot codes into main HTML! (default: 1)
  --sort-js-mode {1,2,3}
                        Define how to provide sorttable.js file. 1: link to
                        packaged .js file. 2: copy .js file to plots output
                        folder. 3: include .js code in HTML (default: 1)

required arguments:
  --in str              Genomic or transcript regions file in BED format. Use
                        these regions together with a generated set of
                        background regions to check for enriched motifs
  --rbps str [str ...]  List of RBP names to define RBP motifs used for search
                        (--rbps rbp1 rbp2 .. ). To search with all available
                        motifs, use --rbps ALL. NOTE: to search with user-
                        provided motifs, set --rbps USER and provide --user-
                        meme-xml and/or --user-cm. To search only for --regex,
                        set --rbps REGEX
  --gtf str             Input GTF file with genomic region annotations. Used
                        to extract gene or transcript background regions,
                        taking the most prominent transcript regions. Note
                        that only features on standard chromosomes
                        (1,2,..,X,Y,MT) are currently used for annotation
  --genome str          Genomic sequences file (currently supported formats:
                        FASTA)
  --out str             Results output folder
```


## rbpbench_nemo

### Tool Description
Nemo subcommand for rbpbench

### Metadata
- **Docker Image**: quay.io/biocontainers/rbpbench:1.1.0--pyhdfd78af_0
- **Homepage**: https://github.com/michauhl/RBPBench
- **Package**: https://anaconda.org/channels/bioconda/packages/rbpbench/overview
- **Validation**: PASS

### Original Help Text
```text
usage: rbpbench nemo [-h] --in str --rbps str [str ...] --gtf str --genome str
                     --out str [--user-rbp-id str] [--user-meme-xml str]
                     [--user-cm str] [--ext str] [--motif-db {1,2,3}]
                     [--custom-db str] [--custom-db-id str]
                     [--custom-db-meme-xml str] [--custom-db-cm str]
                     [--custom-db-info str] [--motifs str [str ...]]
                     [--motif-min-len int] [--motif-max-len int]
                     [--functions str [str ...]] [--regex str]
                     [--regex-id str] [--motif-regex-id]
                     [--regex-type {1,2,3}] [--regex-search-mode {1,2}]
                     [--regex-min-gc float] [--regex-max-gu float]
                     [--regex-spacer-min int] [--regex-spacer-max int]
                     [--bed-score-col int] [--bed-sc-thr float]
                     [--bed-sc-thr-rev] [--bg-mode {1,2}] [--bg-min-size int]
                     [--bg-mask-bed str] [--bg-mask-blacklist]
                     [--bg-incl-bed str] [--bg-ada-sampling]
                     [--bg-shuff-factor int] [--bg-shuff-k int]
                     [--random-seed int] [--tr-list str]
                     [--gtf-feat-min-overlap float] [--fimo-ntf-file str]
                     [--fimo-ntf-mode {1,2,3}] [--fimo-pval float]
                     [--cmsearch-bs float] [--cmsearch-mode {1,2}]
                     [--greatest-hits] [--fisher-mode {1,2,3}]
                     [--nemo-pval-thr float] [--nemo-pval-mode {1,2,3}]
                     [--allow-overlaps] [--cooc-pval-thr float]
                     [--cooc-pval-mode {1,2,3}] [--min-motif-dist int]
                     [--max-motif-dist int] [--motif-sim-thr float]
                     [--motif-sim-cap float] [--motif-sim-norm]
                     [--plot-abs-paths] [--plot-pdf] [--meme-no-check]
                     [--meme-no-pgc] [--plotly-js-mode {1,2,3,4,5,6,7}]
                     [--sort-js-mode {1,2,3}]

options:
  -h, --help            show this help message and exit
  --user-rbp-id str     Provide RBP ID belonging to provided sequence or
                        structure motif(s) (mandatory for --rbps USER)
  --user-meme-xml str   Provide MEME/DREME XML file containing sequence
                        motif(s) to be used for the run (needs --rbps USER)
  --user-cm str         Provide covariance model (.cm) file containing
                        covariance model(s) to be used for the run (needs
                        --rbps USER)
  --ext str             Up- and downstream extension of --in motif sites in
                        nucleotides (nt). Set e.g. --ext 30 for 30 nt on both
                        sides, or --ext 60,0 for only looking at upstream
                        context (default: 30)
  --motif-db {1,2,3}    Built-in motif database to use. 1: human RBP motifs
                        (257 RBPs, 599 motifs,
                        "catrapid_omics_v2.1_human_6plus_ext"), 2: human RBP
                        motifs + 23 ucRBP motifs (277 RBPs, 622 motifs,
                        "catrapid_omics_v2.1_human_6plus_ext_ucrbps"), 3:
                        human RBP motifs from Ray et al. 2013 (80 RBPs, 102
                        motifs, "ray2013_human_rbps_rnacompete") (default: 1)
  --custom-db str       Provide custom motif database folder. Alternatively,
                        provide single files via --custom-db-meme-xml,
                        --custom-db-cm, --custom-db-info
  --custom-db-id str    Set ID/name for provided custom motif database via
                        --custom-db (default: "custom")
  --custom-db-meme-xml str
                        Provide custom motif database MEME/DREME XML file
                        containing sequence motifs
  --custom-db-cm str    Provide custom motif database covariance model (.cm)
                        file containing covariance model(s)
  --custom-db-info str  Provide custom motif database info table file
                        containing RBP ID -> motif ID -> motif type
                        assignments
  --motifs str [str ...]
                        Provide IDs for motifs of interest (need to be in
                        database and loaded). All other RBP motifs will be
                        discarded (except --regex)
  --motif-min-len int   Minimum MEME/DREME motif length to include in search.
                        By default all selected RBP motifs are used
  --motif-max-len int   Maximum MEME/DREME motif length to include in search.
                        By default all selected RBP motifs are used
  --functions str [str ...]
                        Filter defined RBPs (via --rbps) by their molecular
                        functions (annotations available for most database
                        RBPs). E.g. for RBPs in splicing regulation, set
                        --functions SR, for RBPs in RNA stability & decay plus
                        translation regulation, set --functions RSD TR (see
                        rbpbench info for full function descriptions). NOTE
                        that --regex is not affected by filtering
  --regex str           Define regular expression (regex) DNA motif to include
                        in search, e.g. --regex AAACC, --regex
                        'C[ACGT]AC[AC]', .. IUPAC code is also supported, e.g.
                        AAARN resolves to AAA[AG][ACGT]. Alternatively, supply
                        structure pattern, e.g. AA((((ARA))))AA or
                        CC(((A...R)))CC with variable spacer
  --regex-id str        Set regex ID used as RBP ID and database ID associated
                        to -regex hits (default: "regex")
  --motif-regex-id      Use --regex-id for motif ID as well. By default,
                        regular expression string is used as motif ID for
                        regex motif hits
  --regex-type {1,2,3}  Set type of supplied --regex string 1: auto-detect
                        type (standard regex or structure pattern). 2: given
                        --regex string is standard regex, e.g. AC[AG]T. 3:
                        given --regex string is structure pattern string, e.g.
                        ((AA(((...)))AA)) (default: 1)
  --regex-search-mode {1,2}
                        Define regex search mode. 1: when motif hit
                        encountered, continue +1 after motif hit start
                        position, 2: when motif hit encountered, continue +1
                        after motif hit end position. NOTE that structure
                        pattern regex currently always uses mode 1 (default:
                        1)
  --regex-min-gc float  Minimum GC base pair fraction to report structure
                        pattern regex hits (default: 0.0)
  --regex-max-gu float  Maximum GU (GT) base pair fraction to report structure
                        pattern regex hits (default: 1.0)
  --regex-spacer-min int
                        Minimum spacer length for structure pattern regex
                        search (default: 5)
  --regex-spacer-max int
                        Maximum spacer length for structure pattern regex
                        search (default: 200)
  --bed-score-col int   --in BED score column used for p-value calculations.
                        BED score can be e.g. log2 fold change or -log10
                        p-value of the region (default: 5)
  --bed-sc-thr float    Minimum site score (by default: --in BED column 5, or
                        set via --bed-score-col) for filtering (assuming
                        higher score == better site) (default: None)
  --bed-sc-thr-rev      Reverse --bed-sc-thr filtering (i.e. the lower the
                        better, e.g. if score column contains p-values)
                        (default: False)
  --bg-mode {1,2}       Define how to generate the background regions dataset
                        1: depending on type of --in sites (transcript,
                        genomic), sample random regions with same length
                        distribution (after applying --ext to input sites)
                        from transcript or gene regions (based on given
                        --gtf), 2: shuffle --in site sequences (di-nucleotide
                        shuffling) and use these as background (default: 1)
  --bg-min-size int     Minimum size of background set to be used for
                        calculating motif enrichment. If size <= --in set
                        size, use --in set size. If size > --in set size,
                        double the --in set until it is <= size. Only applies
                        for --bg-mode 1. For --bg-mode 2, you can use --bg-
                        shuff-factor (default: 5000)
  --bg-mask-bed str     Additional BED regions file (6-column format) for
                        masking regions (i.e. no background sites should be
                        extracted from --bg-mask-bed regions)
  --bg-mask-blacklist   Add ENCODE blacklist regions (hg38) to excluded
                        regions set, i.e. do not sample from these blacklisted
                        regions (default: False)
  --bg-incl-bed str     Supply BED regions file (6-column format) to define
                        from which regions to extract background sites. Make
                        sure that regions are compatible with --in sites
                        (genomic or transcript). By default, representative
                        transcript regions for all genes from --gtf are used
                        for this. Note that if extraction of needed number of
                        background sites from --bg-incl-bed fails, all
                        transcripts will be used in second try (or define
                        which to use with --tr-list). Also note that --ada-
                        sampling only applies to interally generated list of
                        regions
  --bg-ada-sampling     If --bg-mode 1 and input sites genomic, instead of
                        random background sampling, sample adjusted to intron
                        ratio of input sites (default: False)
  --bg-shuff-factor int
                        Define number of times the size of the shuffled set
                        (--bg-mode 2 set) should be compared to --in set
                        (default: 1)
  --bg-shuff-k int      Define k for k-nt shuffling --in set to create
                        background set (default: 2)
  --random-seed int     Set a fixed random seed number (e.g. --random-seed 1)
                        to obtain reproducible sampling results (default:
                        None)
  --tr-list str         Supply file with transcript IDs (one ID per row) to
                        define which transcripts to use from --gtf to extract
                        control regions
  --gtf-feat-min-overlap float
                        Minimum amount of overlap required for a region to be
                        assigned to a GTF feature (default: 0.1)
  --fimo-ntf-file str   Provide FIMO nucleotide frequencies (FIMO option:
                        --bfile) file (default: use internal frequencies file,
                        define which with --fimo-ntf-mode)
  --fimo-ntf-mode {1,2,3}
                        Set which internal nucleotide frequencies to use for
                        FIMO search. 1: use frequencies from human ENSEMBL
                        transcripts (excluding introns, A most prominent) 2:
                        use frequencies from human ENSEMBL transcripts
                        (including introns, resulting in lower G+C and T most
                        prominent) 3: use uniform frequencies (same for every
                        nucleotide) (default: 1)
  --fimo-pval float     FIMO p-value threshold (FIMO option: --thresh)
                        (default: 0.0005)
  --cmsearch-bs float   CMSEARCH bit score threshold (CMSEARCH options: -T
                        --incT). The higher the more strict (default: 1.0)
  --cmsearch-mode {1,2}
                        Set CMSEARCH mode to control strictness of filtering.
                        1: default setting (CMSEARCH option: --default). 2:
                        max setting (CMSEARCH option: --max), i.e., turn all
                        heuristic filters off, slower and more sensitive /
                        more hits) (default: 1)
  --greatest-hits       Keep only best FIMO/CMSEARCH motif hits (i.e., hit
                        with lowest p-value / highest bit score for each motif
                        sequence/site combination). By default, report all
                        hits (default: False)
  --fisher-mode {1,2,3}
                        Defines Fisher exact test alternative hypothesis for
                        testing motif enrichment in --in sites compared to
                        generated background / control sites. 1: greater, 2:
                        two-sided, 3: less. Setting is used both for motif
                        enrichment and co-occurrence Fisher test (default: 1)
  --nemo-pval-thr float
                        P-value threshold for reporting significantly enriched
                        motifs. NOTE that if --nemo-pval-mode Bonferroni is
                        selected, this threshold gets further adjusted by
                        Bonferroni correction (i.e. divided by number of
                        tests). Threshold applies unchanged for BH corrected
                        p-values as well as for disabled correction (default:
                        0.001)
  --nemo-pval-mode {1,2,3}
                        Defines multiple testing correction mode for motif
                        enrichment p-values. 1: Benjamini-Hochberg (BH), 2:
                        Bonferroni, 3: no correction (default: 1)
  --allow-overlaps      Allow overlaps of motif hit regions with provided --in
                        sites. By default, motif hits overlapping with --in
                        sites are filtered out (default: False)
  --cooc-pval-thr float
                        Motif co-occurrence p-value threshold for reporting
                        significant motif co-occurrences. NOTE that if --cooc-
                        pval-mode Bonferroni is selected, this threshold gets
                        further adjusted by Bonferroni correction (i.e.
                        divided by number of tests). Threshold applies
                        unchanged for BH corrected p-values as well as for
                        disabled correction (default: 0.005)
  --cooc-pval-mode {1,2,3}
                        Defines multiple testing correction mode for co-
                        occurrence p-values. 1: Benjamini-Hochberg (BH), 2:
                        Bonferroni, 3: no correction (default: 1)
  --min-motif-dist int  Set minimum mean motif distance for motif pair to be
                        reported significant in motif co-occurrence heatmap
                        plot. By default (value 0), all motif pairs <= set
                        p-value are reported significant. So setting --min-
                        motif-dist >= 0 acts as a second filter to show only
                        motif pairs with signficiant p-values as significant
                        if there is the specified minimum average distance
                        between their motif hits (default: 0)
  --max-motif-dist int  Set maximum motif distance for motif co-occurrence
                        plot statistic inside hover boxes (default: 20)
  --motif-sim-thr float
                        Set motif pair similarity threshold for to filter out
                        significantly co-occurring motifs that are similar to
                        each other. Similarity between motifs is measured in
                        -log10(TOMTOM p-value), so the larger the pair
                        similarity value of two motifs, the more similar they
                        are. E.g., --motif-sim-thr 2 corresponds to TOMTOM
                        p-value of 0.01, to filter out motif pairs > 2
                        similarity (default: None)
  --motif-sim-cap float
                        Cap maximum motif similarity value to given value
                        (default: 50)
  --motif-sim-norm      Normalize motif similarities (min-max normalization)
                        for PCA plot (default: False)
  --plot-abs-paths      Store plot files with absolute paths in HTML files.
                        Default is relative paths (default: False)
  --plot-pdf            Also output .png plots as .pdf in plotting subfolder
                        (default: False)
  --meme-no-check       Disable MEME version check. Make sure --meme-no-pgc is
                        set if MEME version >= 5.5.4 is installed! (default:
                        False)
  --meme-no-pgc         Manually set MEME's FIMO --no-pgc option (required for
                        MEME version >= 5.5.4). Make sure that MEME >= 5.5.4
                        is installed! (default: False)
  --plotly-js-mode {1,2,3,4,5,6,7}
                        Define how to provide plotly .js file. 1: use online
                        version via "cdn" (requires internet connection). 2:
                        link to packaged plotly .js file. 3: copy plotly .js
                        file to plots output folder. 4: include plotly .js
                        code in plotly HTML. 5: put web version link and
                        plotly plot codes into main HTML. 6: put local version
                        link and plotly plot codes in main HTML. 7: put plotly
                        js and plotly plot codes into main HTML! (default: 1)
  --sort-js-mode {1,2,3}
                        Define how to provide sorttable.js file. 1: link to
                        packaged .js file. 2: copy .js file to plots output
                        folder. 3: include .js code in HTML (default: 1)

required arguments:
  --in str              Genomic or transcript motif sites file in BED format.
                        Use these motif sites as centers to check for
                        significant motifs in proxmimity, i.e., motifs found
                        in context but of motif sites but not overlapping with
                        them (set context size via --ext). Significance is
                        checked compared to generated background regions (see
                        --bg-mode etc.)
  --rbps str [str ...]  List of RBP names to define RBP motifs used for search
                        (--rbps rbp1 rbp2 .. ). To search with all available
                        motifs, use --rbps ALL. NOTE: to search with user-
                        provided motifs, set --rbps USER and provide --user-
                        meme-xml and/or --user-cm. To search only for --regex,
                        set --rbps REGEX
  --gtf str             Input GTF file with genomic region annotations. Used
                        to extract gene or transcript background regions,
                        taking the most prominent transcript regions. Note
                        that only features on standard chromosomes
                        (1,2,..,X,Y,MT) are currently used for annotation
  --genome str          Genomic sequences file (currently supported formats:
                        FASTA)
  --out str             Results output folder
```


## rbpbench_con

### Tool Description
Compares conservation scores between two sets of genomic sites.

### Metadata
- **Docker Image**: quay.io/biocontainers/rbpbench:1.1.0--pyhdfd78af_0
- **Homepage**: https://github.com/michauhl/RBPBench
- **Package**: https://anaconda.org/channels/bioconda/packages/rbpbench/overview
- **Validation**: PASS

### Original Help Text
```text
usage: rbpbench con [-h] --in str --ctrl-in str --out str [--phastcons str]
                    [--phylop str] [--use-regions] [--no-id-check]
                    [--wrs-mode {1,2}] [--plot-abs-paths] [--plot-pdf]
                    [--sort-js-mode {1,2,3}]

options:
  -h, --help            show this help message and exit
  --phastcons str       Genomic .bigWig file with phastCons conservation
                        scores
  --phylop str          Genomic .bigWig file with phyloP conservation scores
  --use-regions         Use genomic regions as --in / --ctrl-in input site IDs
                        instead of BED col4 IDs (default: False)
  --no-id-check         Do not check region IDs, instead overwriting existing
                        regions if they have identical IDs (default: False)
  --wrs-mode {1,2}      Defines Wilcoxon rank-sum test alternative hypothesis
                        for testing whether --in sites have significantly
                        different average conservation scores compared to
                        --ctrl-in sites. 1: test for higher (greater) scores,
                        2: test for lower (less) scores (default: 1)
  --plot-abs-paths      Store plot files with absolute paths in HTML files.
                        Default is relative paths (default: False)
  --plot-pdf            Also output .png plots as .pdf in plotting subfolder
                        (default: False)
  --sort-js-mode {1,2,3}
                        Define how to provide sorttable.js file. 1: link to
                        packaged .js file. 2: copy .js file to output folder.
                        3: include .js code in HTML (default: 1)

required arguments:
  --in str              Genomic sites of interest in BED format
  --ctrl-in str         Genomic control sites to compare to --in genomic sites
                        regarding conservation scores in BED format
  --out str             Results output folder
```


## rbpbench_sponge

### Tool Description
Identify sponge transcripts based on regex matches.

### Metadata
- **Docker Image**: quay.io/biocontainers/rbpbench:1.1.0--pyhdfd78af_0
- **Homepage**: https://github.com/michauhl/RBPBench
- **Package**: https://anaconda.org/channels/bioconda/packages/rbpbench/overview
- **Validation**: PASS

### Original Help Text
```text
usage: rbpbench sponge [-h] --regex str --out str [--fasta str] [--gtf str]
                       [--genome str] [--select-mode {1,2,3}] [--tr-list str]
                       [--allow-overlaps] [--min-spacer-len int]
                       [--min-seq-len int] [--min-hit-count int]
                       [--regex-min-gc float] [--regex-max-gu float]
                       [--regex-spacer-min int] [--regex-spacer-max int]
                       [--chr-id-style {1,2,3}]

options:
  -h, --help            show this help message and exit
  --fasta str           Input FASTA file with transcript sequences to check
                        for --regex matches, to identifiy sponge transcripts
                        (i.e. sequences with high amounts of regex hits per
                        kilo base (kb) length). Note that sequence IDs have to
                        be unique. Also note that either --fasta or --gtf +
                        --genome need to be supplied, in order to get
                        transcript sequences for sponge testing
  --gtf str             Input GTF file with genomic region annotations. Used
                        to extract transcript sequences to check for sponge
                        effects. Note that only features on standard
                        chromosomes (1,2,..,X,Y,MT) are currently used for
                        annotation
  --genome str          Genomic sequences file (currently supported formats:
                        FASTA)
  --select-mode {1,2,3}
                        Define what to extract from GTF file, i.e., for which
                        transcripts or parts of transcripts to extract
                        sequences to use for sponge search. 1: use full
                        transcripts from all genes (selecting one
                        representative for each gene). 2: use only mRNA
                        transcripts. 3: use only 3'UTR parts of mRNA
                        transcripts (default: 1)
  --tr-list str         Supply file with transcript IDs (one ID per row) to
                        define which transcripts to extract from --gtf
                        (overrides representative transcript selection, might
                        not be compatible with --select-mode 2 or 3)
  --allow-overlaps      Allow overlapping regex hits. By default, search
                        continues +1 after regex hit end position (i.e., not
                        overlapping). NOTE that if --regex is structure
                        pattern, search is currently always overlapping
                        (default: False)
  --min-spacer-len int  Minimum spacer length between regex hits. By default
                        0, i.e., hits can also be adjacent. Note that setting
                        --min-spacer to > 0 also sets --allow-overlaps
                        (default: 0)
  --min-seq-len int     Minimum sequence length required for input transcript
                        sequences to be included in search (default: False)
  --min-hit-count int   Minimum regex hit count for a transcript to be
                        included in percentile calculation and output table
                        (default: 0)
  --regex-min-gc float  Minimum GC base pair fraction to report structure
                        pattern regex hits (default: 0.0)
  --regex-max-gu float  Maximum GU (GT) base pair fraction to report structure
                        pattern regex hits (default: 1.0)
  --regex-spacer-min int
                        Minimum spacer length for structure pattern regex
                        search (default: 5)
  --regex-spacer-max int
                        Maximum spacer length for structure pattern regex
                        search (default: 200)
  --chr-id-style {1,2,3}
                        Define to which chromosome ID style to convert
                        chromosome IDs to. 1: do not change chromosome IDs. 2:
                        convert to chr1,chr2,...,chrM style. 3: convert to
                        1,2,...,MT style (default: 1)

required arguments:
  --regex str           Specify regular expression (regex) DNA motif for which
                        to look for sponge transcripts, e.g. --regex AAACCC,
                        --regex 'C[ACGT]AC[AC]' .. IUPAC code is also
                        supported, e.g. AAARN resol. Alternatively, supply
                        structure pattern, e.g. AA((((ARA))))AA or
                        CC(((A...R)))CC with variable spacer
  --out str             Results output folder
```


## rbpbench_isocomp

### Tool Description
Check for differences in regex hit occurrences between transcript isoforms.

### Metadata
- **Docker Image**: quay.io/biocontainers/rbpbench:1.1.0--pyhdfd78af_0
- **Homepage**: https://github.com/michauhl/RBPBench
- **Package**: https://anaconda.org/channels/bioconda/packages/rbpbench/overview
- **Validation**: PASS

### Original Help Text
```text
usage: rbpbench isocomp [-h] --regex str --out str [--fasta str] [--gtf str]
                        [--genome str] [--select-mode {1,2,3,4,5}]
                        [--allow-overlaps] [--min-spacer-len int]
                        [--min-seq-len int] [--regex-min-gc float]
                        [--regex-max-gu float] [--regex-spacer-min int]
                        [--regex-spacer-max int] [--chr-id-style {1,2,3}]

options:
  -h, --help            show this help message and exit
  --fasta str           Input FASTA file with transcript sequences to check
                        for --regex matches. Note that sequence IDs have to be
                        unique, and in format >transcript_id,gene_id for
                        isoform assignment. Also note that either --fasta or
                        --gtf + --genome need to be supplied
  --gtf str             Input GTF file with genomic region annotations. Used
                        to extract transcript sequences for isoform
                        comparisons. NOTE that by default only 3'UTR sequences
                        are compared / used for motif search (change via
                        --select-mode). Also note that only features on
                        standard chromosomes (1,2,..,X,Y,MT) are currently
                        used for annotation
  --genome str          Genomic sequences file (currently supported formats:
                        FASTA)
  --select-mode {1,2,3,4,5}
                        Define what to extract from GTF file, i.e., for which
                        transcripts or parts of transcripts to extract
                        sequences to use for motif search and isoform
                        comparison. 1: use only 3'UTR parts of mRNA
                        transcripts. 2: use only 5'UTR parts of mRNA
                        transcripts. 3: use full mRNA transcripts (i.e., all
                        mRNA transcripts from GTF). 4: use full non-coding
                        transcripts (i.e., no transcripts from protein-coding
                        genes). 5: use full transcripts, coding AND non-coding
                        (i.e., all transcripts from GTF!) (default: 1)
  --allow-overlaps      Allow overlapping regex hits. By default, search
                        continues +1 after regex hit end position (i.e., not
                        overlapping). NOTE that if --regex is structure
                        pattern, search is currently always overlapping
                        (default: False)
  --min-spacer-len int  Minimum spacer length between regex hits. By default
                        0, i.e., hits can also be adjacent. Note that setting
                        --min-spacer to > 0 also sets --allow-overlaps
                        (default: 0)
  --min-seq-len int     Minimum sequence length required for input transcript
                        sequences to be included in search (default: False)
  --regex-min-gc float  Minimum GC base pair fraction to report structure
                        pattern regex hits (default: 0.0)
  --regex-max-gu float  Maximum GU (GT) base pair fraction to report structure
                        pattern regex hits (default: 1.0)
  --regex-spacer-min int
                        Minimum spacer length for structure pattern regex
                        search (default: 5)
  --regex-spacer-max int
                        Maximum spacer length for structure pattern regex
                        search (default: 200)
  --chr-id-style {1,2,3}
                        Define to which chromosome ID style to convert
                        chromosome IDs to. 1: do not change chromosome IDs. 2:
                        convert to chr1,chr2,...,chrM style. 3: convert to
                        1,2,...,MT style (default: 1)

required arguments:
  --regex str           Specify regular expression (regex) DNA motif for which
                        to check for differences in hit occurrences between
                        transcript isoforms, e.g. --regex AAACCC, --regex
                        'C[ACGT]AC[AC]' .. IUPAC code is also supported, e.g.
                        AAARN resolves to AAA[AG][ACGT]. Alternatively, supply
                        structure pattern, e.g. AA((((ARA))))AA or
                        CC(((A...R)))CC with variable spacer
  --out str             Results output folder
```


## rbpbench_streme

### Tool Description
Run STREME on RBP-bound sequences

### Metadata
- **Docker Image**: quay.io/biocontainers/rbpbench:1.1.0--pyhdfd78af_0
- **Homepage**: https://github.com/michauhl/RBPBench
- **Package**: https://anaconda.org/channels/bioconda/packages/rbpbench/overview
- **Validation**: PASS

### Original Help Text
```text
usage: rbpbench streme [-h] --in str --out str [--neg-in str]
                       [--streme-bfile str] [--streme-ntf-mode {1,2,3}]
                       [--streme-thresh float] [--streme-minw int]
                       [--streme-maxw int] [--streme-seed int]
                       [--streme-order int] [--streme-evalue]

options:
  -h, --help            show this help message and exit
  --neg-in str          Provide control (negative) sequences FASTA file. By
                        default, shuffled --in positive sequences are used as
                        control sequences (STREME option: --n)
  --streme-bfile str    Provide STREME nucleotide frequencies (STREME option:
                        --bfile) file (default: use internal frequencies file,
                        define which with --streme-ntf-mode)
  --streme-ntf-mode {1,2,3}
                        Set which internal nucleotide frequencies to use for
                        STREME. 1: use frequencies from human ENSEMBL
                        transcripts (excluding introns, with A most prominent)
                        2: use frequencies from human ENSEMBL transcripts
                        (including introns, resulting in lower G+C and T most
                        prominent) 3: use uniform frequencies (same for every
                        nucleotide) (default: 1)
  --streme-thresh float
                        STREME significance threshold (p-value) for reporting
                        enriched motifs (STREME option --thresh) (default:
                        0.05)
  --streme-minw int     Minimum width for motifs (must be >= 3) (STREME
                        option: --minw) (default: 6)
  --streme-maxw int     Maximum width for motifs (must be <= 30) (STREME
                        option: --maxw) (default: 15)
  --streme-seed int     Random seed for shuffling sequences (STREME option:
                        --seed) (default: 0)
  --streme-order int    Estimates an m-order background model for scoring
                        sites and uses an m-order shuffle if creating control
                        sequences from primary sequences. Default for RNA/DNA:
                        2 (STREME option: --order) (default: 2)
  --streme-evalue       Use E-value threshold instead of p-value (STREME
                        option: --evalue) (default: False)

required arguments:
  --in str              Provide primary (positive) sequences FASTA file
                        (STREME option: --p)
  --out str             Results output folder
```


## rbpbench_tomtom

### Tool Description
Search for motifs similar to --in in a database.

### Metadata
- **Docker Image**: quay.io/biocontainers/rbpbench:1.1.0--pyhdfd78af_0
- **Homepage**: https://github.com/michauhl/RBPBench
- **Package**: https://anaconda.org/channels/bioconda/packages/rbpbench/overview
- **Validation**: PASS

### Original Help Text
```text
usage: rbpbench tomtom [-h] --in str --out str [--motif-db {1,2,3}]
                       [--custom-db str] [--regex-mode {1,2}]
                       [--fe-pval float] [--fe-mode {1,2}]
                       [--tomtom-bfile str] [--tomtom-ntf-mode {1,2,3}]
                       [--tomtom-thresh float] [--tomtom-evalue]
                       [--tomtom-m str] [--tomtom-min-overlap int]

options:
  -h, --help            show this help message and exit
  --motif-db {1,2,3}    Built-in motif database used so search for motifs
                        similar to --in. 1: human RBP motifs (257 RBPs, 599
                        motifs, "catrapid_omics_v2.1_human_6plus_ext"), 2:
                        human RBP motifs + 23 ucRBP motifs (277 RBPs, 622
                        motifs, "catrapid_omics_v2.1_human_6plus_ext_ucrbps"),
                        3: human RBP motifs from Ray et al. 2013 (80 RBPs, 102
                        motifs, "ray2013_human_rbps_rnacompete") (default: 1)
  --custom-db str       Provide custom motif database MEME/DREME XML file
                        containing sequence motifs to search against. By
                        default internal database is used, define which with
                        --motif-db
  --regex-mode {1,2}    If --in is regex/sequence with format e.g. AC[AT]A,
                        define whether to split regex into single motifs
                        (ACAA, ACTA), or to make one motif out of it. 1:
                        convert to one motif. 2: convert to multiple single
                        motifs (default: 1)
  --fe-pval float       RBP function enrichment p-value threshold (default:
                        0.5)
  --fe-mode {1,2}       Define whether to calculate function enrichment on RBP
                        or single motif level. 1) RBP level 2) single motif
                        level (default: 1)
  --tomtom-bfile str    Provide TOMTOM nucleotide frequencies (TOMTOM option:
                        -bfile) file (default: use internal frequencies file,
                        define which with --tomtom-ntf-mode)
  --tomtom-ntf-mode {1,2,3}
                        Set which internal nucleotide frequencies to use for
                        TOMTOM. 1: use frequencies from human ENSEMBL
                        transcripts (excluding introns, with A most prominent)
                        2: use frequencies from human ENSEMBL transcripts
                        (including introns, resulting in lower G+C and T most
                        prominent) 3: use uniform frequencies (same for every
                        nucleotide) (default: 1)
  --tomtom-thresh float
                        TOMTOM q-value threshold (TOMTOM option: -thresh)
                        (default: 0.5)
  --tomtom-evalue       Use E-value threshold instead of q-value (TOMTOM
                        option: -evalue) (default: False)
  --tomtom-m str        Use only query motifs with a specified ID, may be
                        repeated (TOMTOM option: -m) file
  --tomtom-min-overlap int
                        Minimum overlap between query and target (TOMTOM
                        option: -min-overlap) (default: 1)

required arguments:
  --in str              Provide MEME XML style file path or (regular
                        expression) sequence to search for similar motifs in
                        database. Currently only square bracket containing
                        regexes are supported
  --out str             Results output folder
```


## rbpbench_goa

### Tool Description
GO enrichment analysis (GOA)

### Metadata
- **Docker Image**: quay.io/biocontainers/rbpbench:1.1.0--pyhdfd78af_0
- **Homepage**: https://github.com/michauhl/RBPBench
- **Package**: https://anaconda.org/channels/bioconda/packages/rbpbench/overview
- **Validation**: PASS

### Original Help Text
```text
usage: rbpbench goa [-h] [--in str] --gtf str --out str
                    [--goa-obo-mode {1,2,3}] [--goa-obo-file str]
                    [--goa-gene2go-file str] [--goa-pval float]
                    [--goa-bg-gene-list str] [--goa-max-child int]
                    [--goa-min-depth int] [--goa-filter-purified]
                    [--plot-abs-paths] [--sort-js-mode {1,2,3}]

options:
  -h, --help            show this help message and exit
  --goa-obo-mode {1,2,3}
                        Define how to obtain GO DAG (directed acyclic graph)
                        obo file. 1: download most recent file from internet,
                        2: use local file, 3: provide file via --goa-obo-file
                        (default: 1)
  --goa-obo-file str    Provide GO DAG obo file (default: False)
  --goa-gene2go-file str
                        Provide gene ID to GO IDs mapping table (row format:
                        gene_id<tab>go_id1,go_id2). By default, a local file
                        with ENSEMBL gene IDs is used. NOTE that gene IDs need
                        to be compatible with --gtf (default: False)
  --goa-pval float      GO enrichment analysis p-value threshold (applied on
                        corrected p-value) (default: 0.05)
  --goa-bg-gene-list str
                        Supply file with gene IDs (one ID per row) to use as
                        background gene list for GOA. NOTE that gene IDs need
                        to be compatible with --gtf (default: False)
  --goa-max-child int   Specify maximum number of children for a significant
                        GO term to be reported in HTML table, e.g. --goa-max-
                        child 100. This allows filtering out very broad terms
                        (default: None)
  --goa-min-depth int   Specify minimum depth number for a significant GO term
                        to be reported in HTML table, e.g. --goa-min-depth 5
                        (default: None)
  --goa-filter-purified
                        Filter out GOA results labeled as purified (i.e., GO
                        terms with significantly lower concentration) in HTML
                        table (default: False)
  --plot-abs-paths      Store plot files with absolute paths in HTML files.
                        Default is relative paths (default: False)
  --sort-js-mode {1,2,3}
                        Define how to provide sorttable.js file. 1: link to
                        packaged .js file. 2: copy .js file to plots output
                        folder. 3: include .js code in HTML (default: 1)

required arguments:
  --in str              Supply file with gene IDs (one ID per row) to define
                        which genes to use as target genes in GO enrichment
                        analysis (GOA)
  --gtf str             Input GTF file with genomic annotations to extract
                        background genes used for GOA. Note that eventually
                        only genes are used which are present in internal
                        Ensembl gene ID -> GO ID(s) mapping or in provided
                        mapping via --goa-gene2go-file
  --out str             Results output folder
```


## rbpbench_optex

### Tool Description
rbpbench optex

### Metadata
- **Docker Image**: quay.io/biocontainers/rbpbench:1.1.0--pyhdfd78af_0
- **Homepage**: https://github.com/michauhl/RBPBench
- **Package**: https://anaconda.org/channels/bioconda/packages/rbpbench/overview
- **Validation**: PASS

### Original Help Text
```text
usage: rbpbench optex [-h] --in str --rbp-id str --genome str
                      [--user-meme-xml str] [--user-cm str]
                      [--motif-db {1,2,3}] [--fimo-ntf-file str]
                      [--fimo-ntf-mode {1,2,3}] [--fimo-pval float]
                      [--cmsearch-bs float] [--cmsearch-mode {1,2}]
                      [--greatest-hits] [--bed-score-col int]
                      [--bed-sc-thr float] [--bed-sc-thr-rf]
                      [--ext-pval float] [--ext-list int [int ...]]
                      [--meme-no-check] [--meme-no-pgc]

options:
  -h, --help            show this help message and exit
  --user-meme-xml str   Provide MEME/DREME XML file containing sequence
                        motif(s) to be used as search motifs
  --user-cm str         Provide covariance model (.cm) file containing
                        covariance model(s) to be used as search motifs
  --motif-db {1,2,3}    Built-in motif database to use. 1: human RBP motifs
                        (257 RBPs, 599 motifs,
                        "catrapid_omics_v2.1_human_6plus_ext"), 2: human RBP
                        motifs + 23 ucRBP motifs (277 RBPs, 622 motifs,
                        "catrapid_omics_v2.1_human_6plus_ext_ucrbps"), 3:
                        human RBP motifs from Ray et al. 2013 (80 RBPs, 102
                        motifs, "ray2013_human_rbps_rnacompete") (default: 1)
  --fimo-ntf-file str   Provide FIMO nucleotide frequencies (FIMO option:
                        --bfile) file (default: use internal frequencies file,
                        define which with --fimo-ntf-mode)
  --fimo-ntf-mode {1,2,3}
                        Set which internal nucleotide frequencies to use for
                        FIMO search. 1: use frequencies from human ENSEMBL
                        transcripts (excluding introns, A most prominent) 2:
                        use frequencies from human ENSEMBL transcripts
                        (including introns, resulting in lower G+C and T most
                        prominent) 3: use uniform frequencies (same for every
                        nucleotide) (default: 1)
  --fimo-pval float     FIMO p-value threshold (FIMO option: --thresh)
                        (default: 0.0005)
  --cmsearch-bs float   CMSEARCH bit score threshold (CMSEARCH options: -T
                        --incT). The higher the more strict (default: 1.0)
  --cmsearch-mode {1,2}
                        Set CMSEARCH mode to control strictness of filtering.
                        1: default setting (CMSEARCH option: --default). 2:
                        max setting (CMSEARCH option: --max), i.e., turn all
                        heuristic filters off, slower and more sensitive /
                        more hits) (default: 1)
  --greatest-hits       Keep only best FIMO/CMSEARCH motif hits (i.e., hit
                        with lowest p-value / highest bit score for each motif
                        sequence/site combination). By default, report all
                        hits (default: False)
  --bed-score-col int   --in BED score column used for p-value calculations
                        and finding optimal extension. BED score can be e.g.
                        log2 fold change or -log10 p-value of the region
                        (default: 5)
  --bed-sc-thr float    Minimum site score (by default: --in BED column 5, or
                        set via --bed-score-col) for filtering (assuming
                        higher score == better site) (default: None)
  --bed-sc-thr-rf       Reverse --bed-sc-thr filtering (i.e. the lower the
                        better, e.g. if score column contains p-values)
                        (default: False)
  --ext-pval float      Longest extension p-value (default: 0.05)
  --ext-list int [int ...]
                        List of extensions to test (e.g. --ext-list 0 10 20 30
                        40 50). Internally, all combinations will be tested
  --meme-no-check       Disable MEME version check. Make sure --meme-no-pgc is
                        set if MEME version >= 5.5.4 is installed! (default:
                        False)
  --meme-no-pgc         Manually set MEME's FIMO --no-pgc option (required for
                        MEME version >= 5.5.4). Make sure that MEME >= 5.5.4
                        is installed! (default: False)

required arguments:
  --in str              Genomic RBP binding sites (peak regions) file in BED
                        format (also positives + negatives)
  --rbp-id str          Provide RBP ID to define RBP motifs used for search
  --genome str          Genomic sequences file (currently supported formats:
                        FASTA)
```


## rbpbench_dist

### Tool Description
Distribution plot results output folder

### Metadata
- **Docker Image**: quay.io/biocontainers/rbpbench:1.1.0--pyhdfd78af_0
- **Homepage**: https://github.com/michauhl/RBPBench
- **Package**: https://anaconda.org/channels/bioconda/packages/rbpbench/overview
- **Validation**: PASS

### Original Help Text
```text
usage: rbpbench dist [-h] --in str --genome str --out str [--cp-mode {1,2,3}]
                     [--ext int] [--no-uniq-check] [--plot-pdf]

options:
  -h, --help         show this help message and exit
  --cp-mode {1,2,3}  Define which position of --in genomic sites to use as
                     zero position for plotting. 1: upstream end position, 2:
                     center position, 3: downstream end position (default: 1)
  --ext int          Up- and downstream extension of defined genomic positions
                     (define via --cp-mode) in nucleotides (nt). Set e.g.
                     --ext 20 for 20 nt on both sides (default: 10)
  --no-uniq-check    Disable checking for unique input regions and positions
                     (defined by --cp-mode). By default, duplicate input
                     regions are removed, and encountering identical genomic
                     positions (defined by --cp-mode) for plotting results in
                     an assert error (default: False)
  --plot-pdf         Plot .pdf (default: .png)

required arguments:
  --in str           Genomic RBP binding sites (peak regions) file in BED
                     format (can be single positions or extended regions). Use
                     --cp-mode to define zero position for plotting
  --genome str       Genomic sequences file (currently supported formats:
                     FASTA)
  --out str          Distribution plot results output folder
```


## rbpbench_info

### Tool Description
Show information about RBPBench motif databases.

### Metadata
- **Docker Image**: quay.io/biocontainers/rbpbench:1.1.0--pyhdfd78af_0
- **Homepage**: https://github.com/michauhl/RBPBench
- **Package**: https://anaconda.org/channels/bioconda/packages/rbpbench/overview
- **Validation**: PASS

### Original Help Text
```text
usage: rbpbench info [-h] [--motif-db {1,2,3}] [--custom-db str]

options:
  -h, --help          show this help message and exit
  --motif-db {1,2,3}  Built-in motif database to use. 1: human RBP motifs (257
                      RBPs, 599 motifs,
                      "catrapid_omics_v2.1_human_6plus_ext"), 2: human RBP
                      motifs + 23 ucRBP motifs (277 RBPs, 622 motifs,
                      "catrapid_omics_v2.1_human_6plus_ext_ucrbps"), 3: human
                      RBP motifs from Ray et al. 2013 (80 RBPs, 102 motifs,
                      "ray2013_human_rbps_rnacompete") (default: 1)
  --custom-db str     Provide custom motif database folder and print included
                      IDs
```


## Metadata
- **Skill**: generated
