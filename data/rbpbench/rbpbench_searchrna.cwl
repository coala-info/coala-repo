cwlVersion: v1.2
class: CommandLineTool
baseCommand: rbpbench_searchrna
label: rbpbench_searchrna
doc: "Search for RNA-binding protein (RBP) motifs in transcript sites.\n\nTool homepage:
  https://github.com/michauhl/RBPBench"
inputs:
  - id: bed_sc_thr
    type:
      - 'null'
      - float
    doc: 'Minimum site score (by default: --in BED column 5, or set via --bed-score-col)
      for filtering (assuming higher score == better site)'
    inputBinding:
      position: 101
      prefix: --bed-sc-thr
  - id: bed_sc_thr_rev
    type:
      - 'null'
      - boolean
    doc: Reverse --bed-sc-thr filtering (i.e. the lower the better, e.g. if 
      score column contains p-values)
    inputBinding:
      position: 101
      prefix: --bed-sc-thr-rev
  - id: bed_score_col
    type:
      - 'null'
      - int
    doc: --in BED score column used for p-value calculations. BED score can be 
      e.g. log2 fold change or -log10 p-value of the region
    default: 5
    inputBinding:
      position: 101
      prefix: --bed-score-col
  - id: cmsearch_bs
    type:
      - 'null'
      - float
    doc: 'CMSEARCH bit score threshold (CMSEARCH options: -T --incT). The higher the
      more strict'
    default: 1.0
    inputBinding:
      position: 101
      prefix: --cmsearch-bs
  - id: cmsearch_mode
    type:
      - 'null'
      - int
    doc: 'Set CMSEARCH mode to control strictness of filtering. 1: default setting
      (CMSEARCH option: --default). 2: max setting (CMSEARCH option: --max), i.e.,
      turn all heuristic filters off, slower and more sensitive / more hits)'
    default: 1
    inputBinding:
      position: 101
      prefix: --cmsearch-mode
  - id: cooc_pval_mode
    type:
      - 'null'
      - int
    doc: 'Defines multiple testing correction mode for co-occurrence p-values. 1:
      Benjamini-Hochberg (BH), 2: Bonferroni, 3: no correction'
    default: 1
    inputBinding:
      position: 101
      prefix: --cooc-pval-mode
  - id: cooc_pval_thr
    type:
      - 'null'
      - float
    doc: RBP co-occurrence p-value threshold for reporting significant 
      co-occurrences. NOTE that if --cooc-pval-mode Bonferroni is selected, this
      threshold gets further adjusted by Bonferroni correction (i.e. divided by 
      number of tests). Threshold applies unchanged for BH corrected p-values as
      well as for disabled correction
    default: 0.005
    inputBinding:
      position: 101
      prefix: --cooc-pval-thr
  - id: custom_db
    type:
      - 'null'
      - Directory
    doc: Provide custom motif database folder. Alternatively, provide single 
      files via --custom-db-meme-xml, --custom-db-cm, --custom-db-info
    inputBinding:
      position: 101
      prefix: --custom-db
  - id: custom_db_cm
    type:
      - 'null'
      - File
    doc: Provide custom motif database covariance model (.cm) file containing 
      covariance model(s)
    inputBinding:
      position: 101
      prefix: --custom-db-cm
  - id: custom_db_id
    type:
      - 'null'
      - string
    doc: Set ID/name for provided custom motif database via --custom-db
    default: custom
    inputBinding:
      position: 101
      prefix: --custom-db-id
  - id: custom_db_info
    type:
      - 'null'
      - File
    doc: Provide custom motif database info table file containing RBP ID -> 
      motif ID -> motif type assignments
    inputBinding:
      position: 101
      prefix: --custom-db-info
  - id: custom_db_meme_xml
    type:
      - 'null'
      - File
    doc: Provide custom motif database MEME/DREME XML file containing sequence 
      motifs
    inputBinding:
      position: 101
      prefix: --custom-db-meme-xml
  - id: data_id
    type:
      - 'null'
      - string
    doc: Dataset ID
    inputBinding:
      position: 101
      prefix: --data-id
  - id: disable_kmer_pca_plot
    type:
      - 'null'
      - boolean
    doc: Disable input sequences by k-mer content PCA plot
    inputBinding:
      position: 101
      prefix: --disable-kmer-pca-plot
  - id: disable_len_dist_plot
    type:
      - 'null'
      - boolean
    doc: Disable input sequence length distribution plot in HTML report
    inputBinding:
      position: 101
      prefix: --disable-len-dist-plot
  - id: enable_upset_plot
    type:
      - 'null'
      - boolean
    doc: Enable upset plot in HTML report
    inputBinding:
      position: 101
      prefix: --enable-upset-plot
  - id: extension
    type:
      - 'null'
      - string
    doc: Up- and downstream extension of --in transcript sites in nucleotides 
      (nt). Set e.g. --ext 30 for 30 nt on both sides, or --ext 20,10 for 
      different up- and downstream extension. Note that complete extension might
      not always be possible, e.g. for sites on short transcripts or sites at 
      transcript ends
    default: '0'
    inputBinding:
      position: 101
      prefix: --ext
  - id: fimo_ntf_file
    type:
      - 'null'
      - File
    doc: 'Provide FIMO nucleotide frequencies (FIMO option: --bfile) file'
    inputBinding:
      position: 101
      prefix: --fimo-ntf-file
  - id: fimo_ntf_mode
    type:
      - 'null'
      - int
    doc: 'Set which internal nucleotide frequencies to use for FIMO search. 1: use
      frequencies from human ENSEMBL transcripts (excluding introns, A most prominent)
      2: use frequencies from human ENSEMBL transcripts (including introns, resulting
      in lower G+C and T most prominent) 3: use uniform frequencies (same for every
      nucleotide)'
    default: 1
    inputBinding:
      position: 101
      prefix: --fimo-ntf-mode
  - id: fimo_pval
    type:
      - 'null'
      - float
    doc: 'FIMO p-value threshold (FIMO option: --thresh)'
    default: 0.0005
    inputBinding:
      position: 101
      prefix: --fimo-pval
  - id: fisher_mode
    type:
      - 'null'
      - int
    doc: 'Defines Fisher exact test alternative hypothesis for testing co-occurrences
      of RBP motifs on --in sites. 1: greater, 2: two-sided, 3: less'
    default: 1
    inputBinding:
      position: 101
      prefix: --fisher-mode
  - id: functions
    type:
      - 'null'
      - type: array
        items: string
    doc: Filter defined RBPs (via --rbps) by their molecular functions 
      (annotations available for most database RBPs). E.g. for RBPs in splicing 
      regulation, set --functions SR, for RBPs in RNA stability & decay plus 
      translation regulation, set --functions RSD TR (see rbpbench info for full
      function descriptions). NOTE that --regex is not affected by filtering
    inputBinding:
      position: 101
      prefix: --functions
  - id: genome_file
    type: File
    doc: 'Genomic sequences file (currently supported formats: FASTA)'
    inputBinding:
      position: 101
      prefix: --genome
  - id: goa
    type:
      - 'null'
      - boolean
    doc: Run gene ontology (GO) enrichment analysis on genes occupied by --in 
      regions. Requires --gtf
    inputBinding:
      position: 101
      prefix: --goa
  - id: goa_bg_gene_list
    type:
      - 'null'
      - File
    doc: Supply file with gene IDs (one ID per row) to use as background gene 
      list for GOA. NOTE that gene IDs need to be compatible with --gtf
    inputBinding:
      position: 101
      prefix: --goa-bg-gene-list
  - id: goa_cooc_mode
    type:
      - 'null'
      - int
    doc: 'Define what input regions to consider in GOA, in relation to motif hit (co-)occurrences.
      1: Perform GOA on all input regions (no motif (co-)occurrences required). 2:
      perform GOA only on input regions with motif hits from ANY specified RBP. 3:
      perform GOA only on input regions with motif hits from ALL specified RBPs. GOA
      on input regions translates to GOA on the underlying genes'
    default: 1
    inputBinding:
      position: 101
      prefix: --goa-cooc-mode
  - id: goa_filter_purified
    type:
      - 'null'
      - boolean
    doc: Filter out GOA results labeled as purified (i.e., GO terms with 
      significantly lower concentration) in HTML table
    inputBinding:
      position: 101
      prefix: --goa-filter-purified
  - id: goa_gene2go_file
    type:
      - 'null'
      - File
    doc: 'Provide gene ID to GO IDs mapping table (row format: gene_id<tab>go_id1,go_id2).
      By default, a local file with ENSEMBL gene IDs is used. NOTE that gene IDs need
      to be compatible with --gtf'
    inputBinding:
      position: 101
      prefix: --goa-gene2go-file
  - id: goa_max_child
    type:
      - 'null'
      - int
    doc: Specify maximum number of children for a significant GO term to be 
      reported in HTML table, e.g. --goa-max-child 100. This allows filtering 
      out very broad terms
    inputBinding:
      position: 101
      prefix: --goa-max-child
  - id: goa_min_depth
    type:
      - 'null'
      - int
    doc: Specify minimum depth number for a significant GO term to be reported 
      in HTML table, e.g. --goa-min-depth 5
    inputBinding:
      position: 101
      prefix: --goa-min-depth
  - id: goa_obo_file
    type:
      - 'null'
      - File
    doc: Provide GO DAG obo file
    inputBinding:
      position: 101
      prefix: --goa-obo-file
  - id: goa_obo_mode
    type:
      - 'null'
      - int
    doc: 'Define how to obtain GO DAG (directed acyclic graph) obo file. 1: download
      most recent file from internet, 2: use local file, 3: provide file via --goa-obo-file'
    default: 1
    inputBinding:
      position: 101
      prefix: --goa-obo-mode
  - id: goa_pval
    type:
      - 'null'
      - float
    doc: GO enrichment analysis p-value threshold (applied on corrected p-value)
    default: 0.05
    inputBinding:
      position: 101
      prefix: --goa-pval
  - id: greatest_hits
    type:
      - 'null'
      - boolean
    doc: Keep only best FIMO/CMSEARCH motif hits (i.e., hit with lowest p-value 
      / highest bit score for each motif sequence/site combination). By default,
      report all hits
    inputBinding:
      position: 101
      prefix: --greatest-hits
  - id: gtf_file
    type: File
    doc: Input GTF file with genomic annotations to extract spliced transcript 
      sequences for provided --in transcript sites. Note that only features on 
      standard chromosomes (1,2,..,X,Y,MT) are currently considered
    inputBinding:
      position: 101
      prefix: --gtf
  - id: input_sites_file
    type: File
    doc: Transcript sites file in BED format. Column 1 is transcript ID (ID 
      needs to be in --gtf), column 2 and 3 are start and end coordinates of 
      site on the transcript
    inputBinding:
      position: 101
      prefix: --in
  - id: kmer_pca_plot_comp_k
    type:
      - 'null'
      - int
    doc: Set k for sequence complexity (Shannon entropy) calculation. 1 == 
      mono-nucleotides, 2 == di-nucleotides
    default: 1
    inputBinding:
      position: 101
      prefix: --kmer-pca-plot-comp-k
  - id: kmer_pca_plot_k
    type:
      - 'null'
      - int
    doc: Set k for k-mer usage in sequences by k-mer content PCA plot
    default: 3
    inputBinding:
      position: 101
      prefix: --kmer-pca-plot-k
  - id: kmer_pca_plot_no_comp
    type:
      - 'null'
      - boolean
    doc: Disable adding sequence complexity as feature to sequences by k-mer 
      content PCA plot
    inputBinding:
      position: 101
      prefix: --kmer-pca-plot-no-comp
  - id: kmer_pca_plot_no_motifs
    type:
      - 'null'
      - boolean
    doc: Disable adding motif hits information to sequences by k-mer content PCA
      plot
    inputBinding:
      position: 101
      prefix: --kmer-pca-plot-no-motifs
  - id: kmer_plot_k
    type:
      - 'null'
      - int
    doc: Define k for k-mer distribution plots, including top k-mers plot, top 
      vs bottom scoring sites plot, and k-mer variation plot
    default: 4
    inputBinding:
      position: 101
      prefix: --kmer-plot-k
  - id: max_motif_dist
    type:
      - 'null'
      - int
    doc: Set maximum motif distance for RBP co-occurrence plot statistic inside 
      hover boxes
    default: 20
    inputBinding:
      position: 101
      prefix: --max-motif-dist
  - id: meme_no_check
    type:
      - 'null'
      - boolean
    doc: Disable MEME version check. Make sure --meme-no-pgc is set if MEME 
      version >= 5.5.4 is installed!
    inputBinding:
      position: 101
      prefix: --meme-no-check
  - id: meme_no_pgc
    type:
      - 'null'
      - boolean
    doc: Manually set MEME's FIMO --no-pgc option (required for MEME version >= 
      5.5.4). Make sure that MEME >= 5.5.4 is installed!
    inputBinding:
      position: 101
      prefix: --meme-no-pgc
  - id: method_id
    type:
      - 'null'
      - string
    doc: Method ID
    inputBinding:
      position: 101
      prefix: --method-id
  - id: min_motif_dist
    type:
      - 'null'
      - int
    doc: Set minimum mean motif distance for an RBP pair to be reported 
      significant in RBP co-occurrence heatmap plot. By default (value 0), all 
      RBP pairs <= set p-value are reported significant. So setting 
      --min-motif-dist >= 0 acts as a second filter to show only RBP pairs with 
      signficiant p-values as significant if there is the specified minimum 
      average distance between their motifs
    default: 0
    inputBinding:
      position: 101
      prefix: --min-motif-dist
  - id: motif_db
    type:
      - 'null'
      - int
    doc: 'Built-in motif database to use. 1: human RBP motifs (257 RBPs, 599 motifs,
      "catrapid_omics_v2.1_human_6plus_ext"), 2: human RBP motifs + 23 ucRBP motifs
      (277 RBPs, 622 motifs, "catrapid_omics_v2.1_human_6plus_ext_ucrbps"), 3: human
      RBP motifs from Ray et al. 2013 (80 RBPs, 102 motifs, "ray2013_human_rbps_rnacompete")'
    default: 1
    inputBinding:
      position: 101
      prefix: --motif-db
  - id: motif_distance_plot_range
    type:
      - 'null'
      - int
    doc: Set range of motif distance plot. I.e., centered on the set RBP 
      (--set-rbp-id) motifs, motifs within minus and plus 
      --motif-distance-plot-range will be plotted
    default: 50
    inputBinding:
      position: 101
      prefix: --motif-distance-plot-range
  - id: motif_max_len
    type:
      - 'null'
      - int
    doc: Maximum MEME/DREME motif length to include in search. By default all 
      selected RBP motifs are used
    inputBinding:
      position: 101
      prefix: --motif-max-len
  - id: motif_min_len
    type:
      - 'null'
      - int
    doc: Minimum MEME/DREME motif length to include in search. By default all 
      selected RBP motifs are used
    inputBinding:
      position: 101
      prefix: --motif-min-len
  - id: motif_min_pair_count
    type:
      - 'null'
      - int
    doc: On single motif level, minimum count of co-occurrences of a motif with 
      set RBP ID (--set-rbp-id) motif to be reported and plotted
    default: 10
    inputBinding:
      position: 101
      prefix: --motif-min-pair-count
  - id: motif_regex_id
    type:
      - 'null'
      - boolean
    doc: Use --regex-id for motif ID as well. By default, regular expression 
      string is used as motif ID for regex motif hits
    inputBinding:
      position: 101
      prefix: --motif-regex-id
  - id: motifs
    type:
      - 'null'
      - type: array
        items: string
    doc: Provide IDs for motifs of interest (need to be in database and loaded).
      All other RBP motifs will be discarded (except --regex)
    inputBinding:
      position: 101
      prefix: --motifs
  - id: output_dir
    type: Directory
    doc: Results output folder
    inputBinding:
      position: 101
      prefix: --out
  - id: plot_abs_paths
    type:
      - 'null'
      - boolean
    doc: Store plot files with absolute paths in HTML report. Default is 
      relative paths
    inputBinding:
      position: 101
      prefix: --plot-abs-paths
  - id: plot_motifs
    type:
      - 'null'
      - boolean
    doc: Visualize selected sequence motifs, by outputting sequence logos and 
      motif hit statistics into a separate .html file
    inputBinding:
      position: 101
      prefix: --plot-motifs
  - id: plot_pdf
    type:
      - 'null'
      - boolean
    doc: Also output .png plots as .pdf in plotting subfolder
    inputBinding:
      position: 101
      prefix: --plot-pdf
  - id: plotly_js_mode
    type:
      - 'null'
      - int
    doc: 'Define how to provide plotly .js file. 1: use online version via "cdn" (requires
      internet connection). 2: link to packaged plotly .js file. 3: copy plotly .js
      file to plots output folder. 4: include plotly .js code in plotly HTML. 5: put
      web version link and plotly plot codes into main HTML. 6: put local version
      link and plotly plot codes in main HTML. 7: put plotly js and plotly plot codes
      into main HTML!'
    default: 1
    inputBinding:
      position: 101
      prefix: --plotly-js-mode
  - id: rbp_min_pair_count
    type:
      - 'null'
      - int
    doc: On RBP level, minimum amount of co-occurrences of motifs for an RBP ID 
      compared to set RBP ID (--set-rbp-id) motifs to be reported and plotted
    default: 10
    inputBinding:
      position: 101
      prefix: --rbp-min-pair-count
  - id: rbps
    type:
      type: array
      items: string
    doc: 'List of RBP names to define RBP motifs used for search (--rbps rbp1 rbp2
      .. ). To search with all available motifs, use --rbps ALL. NOTE: to search with
      user-provided motifs, set --rbps USER and provide --user-meme-xml and/or --user-cm.
      To search only for --regex, set --rbps REGEX'
    inputBinding:
      position: 101
      prefix: --rbps
  - id: regex
    type:
      - 'null'
      - string
    doc: Define regular expression (regex) DNA motif to include in search, e.g. 
      --regex AAACC, --regex 'C[ACGT]AC[AC]', .. IUPAC code is also supported, 
      e.g. AAARN resolves to AAA[AG][ACGT]. Alternatively, supply structure 
      pattern, e.g. AA((((ARA))))AA or CC(((A...R)))CC with variable spacer
    inputBinding:
      position: 101
      prefix: --regex
  - id: regex_id
    type:
      - 'null'
      - string
    doc: Set regex ID used as RBP ID and database ID associated to -regex hits
    default: regex
    inputBinding:
      position: 101
      prefix: --regex-id
  - id: regex_max_gu
    type:
      - 'null'
      - float
    doc: Maximum GU (GT) base pair fraction to report structure pattern regex 
      hits
    default: 1.0
    inputBinding:
      position: 101
      prefix: --regex-max-gu
  - id: regex_min_gc
    type:
      - 'null'
      - float
    doc: Minimum GC base pair fraction to report structure pattern regex hits
    default: 0.0
    inputBinding:
      position: 101
      prefix: --regex-min-gc
  - id: regex_search_mode
    type:
      - 'null'
      - int
    doc: 'Define regex search mode. 1: when motif hit encountered, continue +1 after
      motif hit start position, 2: when motif hit encountered, continue +1 after motif
      hit end position. NOTE that structure pattern regex currently always uses mode
      1'
    default: 1
    inputBinding:
      position: 101
      prefix: --regex-search-mode
  - id: regex_spacer_max
    type:
      - 'null'
      - int
    doc: Maximum spacer length for structure pattern regex search
    default: 200
    inputBinding:
      position: 101
      prefix: --regex-spacer-max
  - id: regex_spacer_min
    type:
      - 'null'
      - int
    doc: Minimum spacer length for structure pattern regex search
    default: 5
    inputBinding:
      position: 101
      prefix: --regex-spacer-min
  - id: regex_type
    type:
      - 'null'
      - int
    doc: 'Set type of supplied --regex string 1: auto-detect type (standard regex
      or structure pattern). 2: given --regex string is standard regex, e.g. AC[AG]T.
      3: given --regex string is structure pattern string, e.g. ((AA(((...)))AA))'
    default: 1
    inputBinding:
      position: 101
      prefix: --regex-type
  - id: run_id
    type:
      - 'null'
      - string
    doc: Run ID
    inputBinding:
      position: 101
      prefix: --run-id
  - id: set_rbp_id
    type:
      - 'null'
      - string
    doc: Set reference RBP ID to plot motif distances relative to motifs from 
      this RBP (needs to be one of the selected RBP IDs!). Motif plot will be 
      centered on best scoring motif of the RBP for each region
    inputBinding:
      position: 101
      prefix: --set-rbp-id
  - id: sort_js_mode
    type:
      - 'null'
      - int
    doc: 'Define how to provide sorttable.js file. 1: link to packaged .js file. 2:
      copy .js file to plots output folder. 3: include .js code in HTML'
    default: 1
    inputBinding:
      position: 101
      prefix: --sort-js-mode
  - id: top_n_matched
    type:
      - 'null'
      - int
    doc: Set top n matched sequences to be displayed in motif hit statistics 
      HTML report (create via --plot-motifs)
    default: 10
    inputBinding:
      position: 101
      prefix: --top-n-matched
  - id: upset_plot_max_degree
    type:
      - 'null'
      - int
    doc: Upset plot maximum degree. By default no maximum degree is set. Useful 
      to look at specific degrees only (together with --upset-plot-min-degree), 
      e.g. 2 or 2 to 3
    inputBinding:
      position: 101
      prefix: --upset-plot-max-degree
  - id: upset_plot_max_rbp_rank
    type:
      - 'null'
      - int
    doc: Maximum RBP hit region count rank. Set this to limit the amount of RBPs
      included in upset plot (+ statistic !) to top --upset-plot-max-rbp-rank 
      RBPs. By default all RBPs are included
    inputBinding:
      position: 101
      prefix: --upset-plot-max-rbp-rank
  - id: upset_plot_max_subset_rank
    type:
      - 'null'
      - int
    doc: Upset plot maximum subset rank to plot. All tied subsets are included
    default: 25
    inputBinding:
      position: 101
      prefix: --upset-plot-max-subset-rank
  - id: upset_plot_min_degree
    type:
      - 'null'
      - int
    doc: Upset plot minimum degree parameter
    default: 2
    inputBinding:
      position: 101
      prefix: --upset-plot-min-degree
  - id: upset_plot_min_rbp_count
    type:
      - 'null'
      - int
    doc: Minimum amount of input sites containing motifs for an RBP in order for
      the RBP to be included in upset plot (+ statistic !). By default, all RBPs
      are included, also RBPs without hit regions
    default: 0
    inputBinding:
      position: 101
      prefix: --upset-plot-min-rbp-count
  - id: upset_plot_min_subset_size
    type:
      - 'null'
      - int
    doc: Upset plot minimum subset size
    default: 5
    inputBinding:
      position: 101
      prefix: --upset-plot-min-subset-size
  - id: user_cm
    type:
      - 'null'
      - File
    doc: Provide covariance model (.cm) file containing covariance model(s) to 
      be used for the run (needs --rbps USER)
    inputBinding:
      position: 101
      prefix: --user-cm
  - id: user_meme_xml
    type:
      - 'null'
      - File
    doc: Provide MEME/DREME XML file containing sequence motif(s) to be used for
      the run (needs --rbps USER)
    inputBinding:
      position: 101
      prefix: --user-meme-xml
  - id: user_rbp_id
    type:
      - 'null'
      - string
    doc: Provide RBP ID belonging to provided sequence or structure motif(s) 
      (mandatory for --rbps USER)
    inputBinding:
      position: 101
      prefix: --user-rbp-id
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rbpbench:1.1.0--pyhdfd78af_0
stdout: rbpbench_searchrna.out
