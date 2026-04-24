cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - rbpbench
  - batch
label: rbpbench_batch
doc: "Batch job for RBP motif analysis\n\nTool homepage: https://github.com/michauhl/RBPBench"
inputs:
  - id: bed_files
    type:
      type: array
      items: File
    doc: 'Provide either: a folder with BED files (e.g. --bed clipper_bed), a list
      of BED files to search for motifs, or a table file defining files and settings.
      If folder, RBP IDs should be part of BED file names, like: RBP1_...bed, RBP2_...bed.
      If list of BED files, define RBP IDs with --rbp-list. If table file, see manual
      for the correct format'
    inputBinding:
      position: 1
  - id: genome
    type: File
    doc: 'Genomic sequences file (currently supported formats: FASTA)'
    inputBinding:
      position: 2
  - id: output_folder
    type: Directory
    doc: Batch job results output folder
    inputBinding:
      position: 3
  - id: add_annot_bed
    type:
      - 'null'
      - File
    doc: Specify additional genomic regions in BED format for which to calculate
      the percentages of input regions that overlap with them
    inputBinding:
      position: 104
      prefix: --add-annot-bed
  - id: add_annot_comp
    type:
      - 'null'
      - boolean
    doc: Get the complement percentages, i.e., the percentages of input regions 
      NOT overlapping with --add-annot-bed regions
    inputBinding:
      position: 104
      prefix: --add-annot-comp
  - id: add_annot_id
    type:
      - 'null'
      - string
    doc: 'Label to use for additional regions in HTML report (default: "custom")'
    inputBinding:
      position: 104
      prefix: --add-annot-id
  - id: bed_sc_thr
    type:
      - 'null'
      - float
    doc: 'Minimum site score (by default: --in BED column 5, or set via --bed-score-col)
      for filtering (assuming higher score == better site) (default: None)'
    inputBinding:
      position: 104
      prefix: --bed-sc-thr
  - id: bed_sc_thr_rev
    type:
      - 'null'
      - boolean
    doc: 'Reverse --bed-sc-thr filtering (i.e. the lower the better, e.g. if score
      column contains p-values) (default: False)'
    inputBinding:
      position: 104
      prefix: --bed-sc-thr-rev
  - id: bed_score_col
    type:
      - 'null'
      - int
    doc: '--in BED score column used for p-value calculations. BED score can be e.g.
      log2 fold change or -log10 p-value of the region (default: 5)'
    inputBinding:
      position: 104
      prefix: --bed-score-col
  - id: cmsearch_bs
    type:
      - 'null'
      - float
    doc: 'CMSEARCH bit score threshold (CMSEARCH options: -T --incT). The higher the
      more strict (default: 1.0)'
    inputBinding:
      position: 104
      prefix: --cmsearch-bs
  - id: cmsearch_mode
    type:
      - 'null'
      - int
    doc: 'Set CMSEARCH mode to control strictness of filtering. 1: default setting
      (CMSEARCH option: --default). 2: max setting (CMSEARCH option: --max), i.e.,
      turn all heuristic filters off, slower and more sensitive / more hits) (default:
      1)'
    inputBinding:
      position: 104
      prefix: --cmsearch-mode
  - id: custom_db
    type:
      - 'null'
      - Directory
    doc: Provide custom motif database folder
    inputBinding:
      position: 104
      prefix: --custom-db
  - id: custom_db_cm
    type:
      - 'null'
      - File
    doc: Provide custom motif database covariance model (.cm) file containing 
      covariance model(s)
    inputBinding:
      position: 104
      prefix: --custom-db-cm
  - id: custom_db_id
    type:
      - 'null'
      - string
    doc: 'Set ID/name for provided custom motif database via --custom-db (default:
      "custom")'
    inputBinding:
      position: 104
      prefix: --custom-db-id
  - id: custom_db_info
    type:
      - 'null'
      - File
    doc: Provide custom motif database info table file containing RBP ID -> 
      motif ID -> motif type assignments
    inputBinding:
      position: 104
      prefix: --custom-db-info
  - id: custom_db_meme_xml
    type:
      - 'null'
      - File
    doc: Provide custom motif database MEME/DREME XML file containing sequence 
      motifs
    inputBinding:
      position: 104
      prefix: --custom-db-meme-xml
  - id: data_id
    type:
      - 'null'
      - string
    doc: Data ID to describe data for given datasets, e.g. --method-id 
      k562_eclip, used in output tables and for generating the comparison 
      reports (rbpbench compare)
    inputBinding:
      position: 104
      prefix: --data-id
  - id: data_list
    type:
      - 'null'
      - type: array
        items: string
    doc: 'List of data IDs to describe datasets given by -bed- list (NOTE: order needs
      to correspond to --bed order). Alternatively, use --data-id to set method for
      all datasets'
    inputBinding:
      position: 104
      prefix: --data-list
  - id: disable_heatmap_cluster_olo
    type:
      - 'null'
      - boolean
    doc: Disable optimal leave ordering (OLO) for clustering gene region 
      occupancy heatmap. By default, OLO is enabled
    inputBinding:
      position: 104
      prefix: --disable-heatmap-cluster-olo
  - id: extension
    type:
      - 'null'
      - string
    doc: 'Up- and downstream extension of --in sites in nucleotides (nt). Set e.g.
      --ext 30 for 30 nt on both sides, or --ext 20,10 for different up- and downstream
      extension (default: 0)'
    inputBinding:
      position: 104
      prefix: --ext
  - id: fimo_ntf_file
    type:
      - 'null'
      - File
    doc: 'Provide FIMO nucleotide frequencies (FIMO option: --bfile) file (default:
      use internal frequencies file, define which with --fimo-ntf-mode)'
    inputBinding:
      position: 104
      prefix: --fimo-ntf-file
  - id: fimo_ntf_mode
    type:
      - 'null'
      - int
    doc: 'Set which internal nucleotide frequencies to use for FIMO search. 1: use
      frequencies from human ENSEMBL transcripts (excluding introns, A most prominent)
      2: use frequencies from human ENSEMBL transcripts (including introns, resulting
      in lower G+C and T most prominent) 3: use uniform frequencies (same for every
      nucleotide) (default: 1)'
    inputBinding:
      position: 104
      prefix: --fimo-ntf-mode
  - id: fimo_pval
    type:
      - 'null'
      - float
    doc: 'FIMO p-value threshold (FIMO option: --thresh) (default: 0.0005)'
    inputBinding:
      position: 104
      prefix: --fimo-pval
  - id: fisher_mode
    type:
      - 'null'
      - int
    doc: 'Defines Fisher exact test alternative hypothesis for testing co-occurrences
      of RBP motifs. 1: greater, 2: two-sided, 3: less (default: 1)'
    inputBinding:
      position: 104
      prefix: --fisher-mode
  - id: goa
    type:
      - 'null'
      - boolean
    doc: 'Run gene ontology (GO) enrichment analysis on genes occupied by sites in
      input datasets. Requires --gtf (default: False)'
    inputBinding:
      position: 104
      prefix: --goa
  - id: goa_bg_gene_list
    type:
      - 'null'
      - File
    doc: 'Supply file with gene IDs (one ID per row) to use as background gene list
      for GOA. NOTE that gene IDs need to be compatible with --gtf (default: False)'
    inputBinding:
      position: 104
      prefix: --goa-bg-gene-list
  - id: goa_filter_purified
    type:
      - 'null'
      - boolean
    doc: 'Filter out GOA results labeled as purified (i.e., GO terms with significantly
      lower concentration) in HTML table (default: False)'
    inputBinding:
      position: 104
      prefix: --goa-filter-purified
  - id: goa_gene2go_file
    type:
      - 'null'
      - File
    doc: 'Provide gene ID to GO IDs mapping table (row format: gene_id<tab>go_id1,go_id2).
      By default, a local file with ENSEMBL gene IDs is used. NOTE that gene IDs need
      to be compatible with --gtf (default: False)'
    inputBinding:
      position: 104
      prefix: --goa-gene2go-file
  - id: goa_max_child
    type:
      - 'null'
      - int
    doc: 'Specify maximum number of children for a significant GO term to be reported
      in HTML table, e.g. --goa-max- child 100. This allows filtering out very broad
      terms (default: None)'
    inputBinding:
      position: 104
      prefix: --goa-max-child
  - id: goa_min_depth
    type:
      - 'null'
      - int
    doc: 'Specify minimum depth number for a significant GO term to be reported in
      HTML table, e.g. --goa-min-depth 5 (default: None)'
    inputBinding:
      position: 104
      prefix: --goa-min-depth
  - id: goa_obo_file
    type:
      - 'null'
      - File
    doc: 'Provide GO DAG obo file (default: False)'
    inputBinding:
      position: 104
      prefix: --goa-obo-file
  - id: goa_obo_mode
    type:
      - 'null'
      - int
    doc: 'Define how to obtain GO DAG (directed acyclic graph) obo file. 1: download
      most recent file from internet, 2: use local file, 3: provide file via --goa-obo-file
      (default: 1)'
    inputBinding:
      position: 104
      prefix: --goa-obo-mode
  - id: goa_only_cooc
    type:
      - 'null'
      - boolean
    doc: 'Only look at genes in GO enrichment analysis which contain motif hits for
      all input datasets. By default, GO enrichment analysis is performed on the genes
      covered by sites from all input datasets (default: False)'
    inputBinding:
      position: 104
      prefix: --goa-only-cooc
  - id: goa_pval
    type:
      - 'null'
      - float
    doc: 'GO enrichment analysis p-value threshold (applied on corrected p-value)
      (default: 0.05)'
    inputBinding:
      position: 104
      prefix: --goa-pval
  - id: greatest_hits
    type:
      - 'null'
      - boolean
    doc: 'Keep only best FIMO/CMSEARCH motif hits (i.e., hit with lowest p-value /
      highest bit score for each motif sequence/site combination). By default, report
      all hits (default: False)'
    inputBinding:
      position: 104
      prefix: --greatest-hits
  - id: gtf
    type:
      - 'null'
      - File
    doc: Input GTF file with genomic annotations to generate genomic region 
      annotation plots for each input BED file (output to HTML report). By 
      default the most prominent transcripts will be extracted and used for 
      functional annotation. Alternatively, provide a list of expressed 
      transcripts via --tr-list (together with --gtf containing the 
      transcripts). Note that only features on standard chromosomes 
      (1,2,..,X,Y,MT) are currently used for annotation
    inputBinding:
      position: 104
      prefix: --gtf
  - id: gtf_feat_min_overlap
    type:
      - 'null'
      - float
    doc: 'Minimum amount of overlap required for a region to be assigned to a GTF
      feature (if less or no overlap, region will be assigned to "intergenic"). If
      there is overlap with several features, assign the one with highest overlap
      (default: 0.1)'
    inputBinding:
      position: 104
      prefix: --gtf-feat-min-overlap
  - id: gtf_intron_border_len
    type:
      - 'null'
      - int
    doc: 'Set intron border region length (up- + downstream ends) for exon intron
      overlap statistics (default: 250)'
    inputBinding:
      position: 104
      prefix: --gtf-intron-border-len
  - id: hk_gene_list
    type:
      - 'null'
      - File
    doc: 'Supply file with gene IDs (one ID per row) of housekeeping genes as additional
      plotting info. ID format needs to be compatible with provided --gtf file (default:
      False)'
    inputBinding:
      position: 104
      prefix: --hk-gene-list
  - id: kmer_size
    type:
      - 'null'
      - int
    doc: 'K-mer size for comparative plots (default: 5)'
    inputBinding:
      position: 104
      prefix: --kmer-size
  - id: max_motif_dist
    type:
      - 'null'
      - int
    doc: 'Set maximum motif distance for regex-RBP co-occurrence statistic in HTML
      report (default: 20)'
    inputBinding:
      position: 104
      prefix: --max-motif-dist
  - id: meme_no_check
    type:
      - 'null'
      - boolean
    doc: 'Disable MEME version check. Make sure --meme-no-pgc is set if MEME version
      >= 5.5.4 is installed! (default: False)'
    inputBinding:
      position: 104
      prefix: --meme-no-check
  - id: meme_no_pgc
    type:
      - 'null'
      - boolean
    doc: "Manually set MEME's FIMO --no-pgc option (required for MEME version >= 5.5.4).
      Make sure that MEME >= 5.5.4 is installed! (default: False)"
    inputBinding:
      position: 104
      prefix: --meme-no-pgc
  - id: method_id
    type:
      - 'null'
      - string
    doc: Method ID to describe peak calling method for given datasets, e.g. 
      --method-id clipper_idr, used in output tables and for generating the 
      comparison reports (rbpbench compare)
    inputBinding:
      position: 104
      prefix: --method-id
  - id: method_list
    type:
      - 'null'
      - type: array
        items: string
    doc: 'List of method IDs to describe datasets given by -bed- list (NOTE: order
      needs to correspond to --bed order). Alternatively, use --method-id to set method
      for all datasets'
    inputBinding:
      position: 104
      prefix: --method-list
  - id: motif_db
    type:
      - 'null'
      - int
    doc: 'Built-in motif database to use. 1: human RBP motifs (257 RBPs, 599 motifs,
      "catrapid_omics_v2.1_human_6plus_ext"), 2: human RBP motifs + 23 ucRBP motifs
      (277 RBPs, 622 motifs, "catrapid_omics_v2.1_human_6plus_ext_ucrbps"), 3: human
      RBP motifs from Ray et al. 2013 (80 RBPs, 102 motifs, "ray2013_human_rbps_rnacompete")
      (default: 1)'
    inputBinding:
      position: 104
      prefix: --motif-db
  - id: no_comp_feat
    type:
      - 'null'
      - boolean
    doc: 'Disable sequence complexity info to be added to plot (default: False)'
    inputBinding:
      position: 104
      prefix: --no-comp-feat
  - id: no_occ_heatmap
    type:
      - 'null'
      - boolean
    doc: 'Do not produce gene region occupancy heatmap plot in HTML report (default:
      False)'
    inputBinding:
      position: 104
      prefix: --no-occ-heatmap
  - id: plot_abs_paths
    type:
      - 'null'
      - boolean
    doc: 'Store plot files with absolute paths in HTML files. Default is relative
      paths (default: False)'
    inputBinding:
      position: 104
      prefix: --plot-abs-paths
  - id: plot_pdf
    type:
      - 'null'
      - boolean
    doc: 'Also output .png plots as .pdf in plotting subfolder (default: False)'
    inputBinding:
      position: 104
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
      into main HTML! (default: 1)'
    inputBinding:
      position: 104
      prefix: --plotly-js-mode
  - id: prom_both_str
    type:
      - 'null'
      - boolean
    doc: Use both strands for promoter region overlap calculation. By default, 
      use transcript strand
    inputBinding:
      position: 104
      prefix: --prom-both-str
  - id: prom_ext
    type:
      - 'null'
      - string
    doc: 'Up- and downstream extension of transcript start site (TSS) to define putative
      promoter regions, e.g. --prom-ext 500,0 for 500 upstream and 0 downstream extension
      (default: 1000,100)'
    inputBinding:
      position: 104
      prefix: --prom-ext
  - id: prom_min_tr_len
    type:
      - 'null'
      - int
    doc: Minimum transcript length for promoter region extraction. By default 
      consider all transcript regions
    inputBinding:
      position: 104
      prefix: --prom-min-tr-len
  - id: prom_mrna_only
    type:
      - 'null'
      - boolean
    doc: Consider only mRNA transcript regions for promoter region extraction
    inputBinding:
      position: 104
      prefix: --prom-mrna-only
  - id: rbp_list
    type:
      - 'null'
      - type: array
        items: string
    doc: 'List of RBP names to define RBP motifs used for search. One --rbp-list RBP
      ID for each --bed BED file (NOTE: order needs to correspond to --bed-list)'
    inputBinding:
      position: 104
      prefix: --rbp-list
  - id: regex
    type:
      - 'null'
      - string
    doc: Define regular expression (regex) DNA motif to include in search, e.g. 
      --regex AAACC, --regex 'C[ACGT]AC[AC]', .. IUPAC code is also supported, 
      e.g. AAARN resolves to AAA[AG][ACGT]. Alternatively, supply structure 
      pattern, e.g. AA((((ARA))))AA or CC(((A...R)))CC with variable spacer
    inputBinding:
      position: 104
      prefix: --regex
  - id: regex_max_gu
    type:
      - 'null'
      - float
    doc: 'Maximum GU (GT) base pair fraction to report structure pattern regex hits
      (default: 1.0)'
    inputBinding:
      position: 104
      prefix: --regex-max-gu
  - id: regex_min_gc
    type:
      - 'null'
      - float
    doc: 'Minimum GC base pair fraction to report structure pattern regex hits (default:
      0.0)'
    inputBinding:
      position: 104
      prefix: --regex-min-gc
  - id: regex_search_mode
    type:
      - 'null'
      - int
    doc: 'Define regex search mode. 1: when motif hit encountered, continue +1 after
      motif hit start position, 2: when motif hit encountered, continue +1 after motif
      hit end position. NOTE that structure pattern regex currently always uses mode
      1 (default: 1)'
    inputBinding:
      position: 104
      prefix: --regex-search-mode
  - id: regex_spacer_max
    type:
      - 'null'
      - int
    doc: 'Maximum spacer length for structure pattern regex search (default: 200)'
    inputBinding:
      position: 104
      prefix: --regex-spacer-max
  - id: regex_spacer_min
    type:
      - 'null'
      - int
    doc: 'Minimum spacer length for structure pattern regex search (default: 5)'
    inputBinding:
      position: 104
      prefix: --regex-spacer-min
  - id: regex_type
    type:
      - 'null'
      - int
    doc: 'Set type of supplied --regex string 1: auto-detect type (standard regex
      or structure pattern). 2: given --regex string is standard regex, e.g. AC[AG]T.
      3: given --regex string is structure pattern string, e.g. ((AA(((...)))AA))
      (default: 1)'
    inputBinding:
      position: 104
      prefix: --regex-type
  - id: run_id
    type:
      - 'null'
      - string
    doc: Run ID to describe rbpbench search job, e.g. --run-id RBP1_eCLIP_tool1,
      used in output tables and reports
    inputBinding:
      position: 104
      prefix: --run-id
  - id: seq_comp_k
    type:
      - 'null'
      - int
    doc: 'Set k for sequence complexity (Shannon entropy) calculation. 1 == mono-nucleotides,
      2 == di- nucleotides (default: 1)'
    inputBinding:
      position: 104
      prefix: --seq-comp-k
  - id: seq_var_color_mode
    type:
      - 'null'
      - int
    doc: 'Define which attribute to use for coloring k-mer variation plot. 1: average
      k-mer site percentage. 2: present k-mers percentage (default: 1)'
    inputBinding:
      position: 104
      prefix: --seq-var-color-mode
  - id: seq_var_feat_mode
    type:
      - 'null'
      - int
    doc: 'Define what sequence k-mer variation plot to create 1: plot using site percentages
      for each k-mer as dimensions. 2: plot using k-mer variations as dimensions (default:
      1)'
    inputBinding:
      position: 104
      prefix: --seq-var-feat-mode
  - id: seq_var_kmer_size
    type:
      - 'null'
      - int
    doc: 'K-mer size for sequence variation statistics and plot (default: 3)'
    inputBinding:
      position: 104
      prefix: --seq-var-kmer-size
  - id: sort_js_mode
    type:
      - 'null'
      - int
    doc: 'Define how to provide sorttable.js file. 1: link to packaged .js file. 2:
      copy .js file to plots output folder. 3: include .js code in HTML (default:
      1)'
    inputBinding:
      position: 104
      prefix: --sort-js-mode
  - id: tr_list
    type:
      - 'null'
      - File
    doc: Supply file with transcript IDs (one ID per row) to define which 
      transcripts to use from --gtf for genomic region annotations plots
    inputBinding:
      position: 104
      prefix: --tr-list
  - id: tr_types
    type:
      - 'null'
      - type: array
        items: string
    doc: List of transcript biotypes to consider for genomic region annotations 
      plots. By default an internal selection of transcript biotypes is used (in
      addition to intron, CDS, UTR, intergenic). Note that provided biotype 
      strings need to be in --gtf GTF file
    inputBinding:
      position: 104
      prefix: --tr-types
  - id: unstranded
    type:
      - 'null'
      - boolean
    doc: 'Set if --in BED regions are NOT strand-specific, i.e., to look for motifs
      on both strands of the provided regions. Note that the two strands of a region
      will still be counted as one region (change with --unstranded-ct) (default:
      False)'
    inputBinding:
      position: 104
      prefix: --unstranded
  - id: unstranded_ct
    type:
      - 'null'
      - boolean
    doc: Count each --in region twice for RBP hit statistics when --unstranded 
      is enabled. By default, two strands of one region are counted as one 
      region for RBP hit statistics
    inputBinding:
      position: 104
      prefix: --unstranded-ct
  - id: wrs_mode
    type:
      - 'null'
      - int
    doc: 'Defines Wilcoxon rank-sum test alternative hypothesis for testing whether
      motif-containing regions have significantly different scores. 1: test for higher
      (greater) scores, 2: test for lower (less) scores (default: 1)'
    inputBinding:
      position: 104
      prefix: --wrs-mode
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rbpbench:1.1.0--pyhdfd78af_0
stdout: rbpbench_batch.out
