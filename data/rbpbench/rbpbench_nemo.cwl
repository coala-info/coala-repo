cwlVersion: v1.2
class: CommandLineTool
baseCommand: rbpbench nemo
label: rbpbench_nemo
doc: "Nemo subcommand for rbpbench\n\nTool homepage: https://github.com/michauhl/RBPBench"
inputs:
  - id: allow_overlaps
    type:
      - 'null'
      - boolean
    doc: 'Allow overlaps of motif hit regions with provided --in sites. By default,
      motif hits overlapping with --in sites are filtered out (default: False)'
    inputBinding:
      position: 101
      prefix: --allow-overlaps
  - id: bed_sc_thr
    type:
      - 'null'
      - float
    doc: 'Minimum site score (by default: --in BED column 5, or set via --bed-score-col)
      for filtering (assuming higher score == better site) (default: None)'
    inputBinding:
      position: 101
      prefix: --bed-sc-thr
  - id: bed_sc_thr_rev
    type:
      - 'null'
      - boolean
    doc: 'Reverse --bed-sc-thr filtering (i.e. the lower the better, e.g. if score
      column contains p-values) (default: False)'
    inputBinding:
      position: 101
      prefix: --bed-sc-thr-rev
  - id: bed_score_col
    type:
      - 'null'
      - int
    doc: '--in BED score column used for p-value calculations. BED score can be e.g.
      log2 fold change or -log10 p-value of the region (default: 5)'
    default: 5
    inputBinding:
      position: 101
      prefix: --bed-score-col
  - id: bg_ada_sampling
    type:
      - 'null'
      - boolean
    doc: 'If --bg-mode 1 and input sites genomic, instead of random background sampling,
      sample adjusted to intron ratio of input sites (default: False)'
    inputBinding:
      position: 101
      prefix: --bg-ada-sampling
  - id: bg_incl_bed
    type:
      - 'null'
      - File
    doc: Supply BED regions file (6-column format) to define from which regions 
      to extract background sites. Make sure that regions are compatible with 
      --in sites (genomic or transcript). By default, representative transcript 
      regions for all genes from --gtf are used for this. Note that if 
      extraction of needed number of background sites from --bg-incl-bed fails, 
      all transcripts will be used in second try (or define which to use with 
      --tr-list). Also note that --ada-sampling only applies to interally 
      generated list of regions
    inputBinding:
      position: 101
      prefix: --bg-incl-bed
  - id: bg_mask_bed
    type:
      - 'null'
      - File
    doc: Additional BED regions file (6-column format) for masking regions (i.e.
      no background sites should be extracted from --bg-mask-bed regions)
    inputBinding:
      position: 101
      prefix: --bg-mask-bed
  - id: bg_mask_blacklist
    type:
      - 'null'
      - boolean
    doc: 'Add ENCODE blacklist regions (hg38) to excluded regions set, i.e. do not
      sample from these blacklisted regions (default: False)'
    inputBinding:
      position: 101
      prefix: --bg-mask-blacklist
  - id: bg_min_size
    type:
      - 'null'
      - int
    doc: 'Minimum size of background set to be used for calculating motif enrichment.
      If size <= --in set size, use --in set size. If size > --in set size, double
      the --in set until it is <= size. Only applies for --bg-mode 1. For --bg-mode
      2, you can use --bg-shuff-factor (default: 5000)'
    default: 5000
    inputBinding:
      position: 101
      prefix: --bg-min-size
  - id: bg_mode
    type:
      - 'null'
      - int
    doc: 'Define how to generate the background regions dataset 1: depending on type
      of --in sites (transcript, genomic), sample random regions with same length
      distribution (after applying --ext to input sites) from transcript or gene regions
      (based on given --gtf), 2: shuffle --in site sequences (di-nucleotide shuffling)
      and use these as background (default: 1)'
    default: 1
    inputBinding:
      position: 101
      prefix: --bg-mode
  - id: bg_shuff_factor
    type:
      - 'null'
      - int
    doc: 'Define number of times the size of the shuffled set (--bg-mode 2 set) should
      be compared to --in set (default: 1)'
    default: 1
    inputBinding:
      position: 101
      prefix: --bg-shuff-factor
  - id: bg_shuff_k
    type:
      - 'null'
      - int
    doc: 'Define k for k-nt shuffling --in set to create background set (default:
      2)'
    default: 2
    inputBinding:
      position: 101
      prefix: --bg-shuff-k
  - id: cmsearch_bs
    type:
      - 'null'
      - float
    doc: 'CMSEARCH bit score threshold (CMSEARCH options: -T --incT). The higher the
      more strict (default: 1.0)'
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
      turn all heuristic filters off, slower and more sensitive / more hits) (default:
      1)'
    default: 1
    inputBinding:
      position: 101
      prefix: --cmsearch-mode
  - id: cooc_pval_mode
    type:
      - 'null'
      - int
    doc: 'Defines multiple testing correction mode for co-occurrence p-values. 1:
      Benjamini-Hochberg (BH), 2: Bonferroni, 3: no correction (default: 1)'
    default: 1
    inputBinding:
      position: 101
      prefix: --cooc-pval-mode
  - id: cooc_pval_thr
    type:
      - 'null'
      - float
    doc: 'Motif co-occurrence p-value threshold for reporting significant motif co-occurrences.
      NOTE that if --cooc-pval-mode Bonferroni is selected, this threshold gets further
      adjusted by Bonferroni correction (i.e. divided by number of tests). Threshold
      applies unchanged for BH corrected p-values as well as for disabled correction
      (default: 0.005)'
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
    doc: 'Set ID/name for provided custom motif database via --custom-db (default:
      "custom")'
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
  - id: extension
    type:
      - 'null'
      - string
    doc: 'Up- and downstream extension of --in motif sites in nucleotides (nt). Set
      e.g. --ext 30 for 30 nt on both sides, or --ext 60,0 for only looking at upstream
      context (default: 30)'
    default: '30'
    inputBinding:
      position: 101
      prefix: --ext
  - id: fimo_ntf_file
    type:
      - 'null'
      - File
    doc: 'Provide FIMO nucleotide frequencies (FIMO option: --bfile) file (default:
      use internal frequencies file, define which with --fimo-ntf-mode)'
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
      nucleotide) (default: 1)'
    default: 1
    inputBinding:
      position: 101
      prefix: --fimo-ntf-mode
  - id: fimo_pval
    type:
      - 'null'
      - float
    doc: 'FIMO p-value threshold (FIMO option: --thresh) (default: 0.0005)'
    default: 0.0005
    inputBinding:
      position: 101
      prefix: --fimo-pval
  - id: fisher_mode
    type:
      - 'null'
      - int
    doc: 'Defines Fisher exact test alternative hypothesis for testing motif enrichment
      in --in sites compared to generated background / control sites. 1: greater,
      2: two-sided, 3: less. Setting is used both for motif enrichment and co-occurrence
      Fisher test (default: 1)'
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
  - id: greatest_hits
    type:
      - 'null'
      - boolean
    doc: 'Keep only best FIMO/CMSEARCH motif hits (i.e., hit with lowest p-value /
      highest bit score for each motif sequence/site combination). By default, report
      all hits (default: False)'
    inputBinding:
      position: 101
      prefix: --greatest-hits
  - id: gtf_feat_min_overlap
    type:
      - 'null'
      - float
    doc: 'Minimum amount of overlap required for a region to be assigned to a GTF
      feature (default: 0.1)'
    default: 0.1
    inputBinding:
      position: 101
      prefix: --gtf-feat-min-overlap
  - id: gtf_file
    type: File
    doc: Input GTF file with genomic region annotations. Used to extract gene or
      transcript background regions, taking the most prominent transcript 
      regions. Note that only features on standard chromosomes (1,2,..,X,Y,MT) 
      are currently used for annotation
    inputBinding:
      position: 101
      prefix: --gtf
  - id: input_sites
    type: File
    doc: Genomic or transcript motif sites file in BED format. Use these motif 
      sites as centers to check for significant motifs in proxmimity, i.e., 
      motifs found in context but of motif sites but not overlapping with them 
      (set context size via --ext). Significance is checked compared to 
      generated background regions (see --bg-mode etc.)
    inputBinding:
      position: 101
      prefix: --in
  - id: max_motif_dist
    type:
      - 'null'
      - int
    doc: 'Set maximum motif distance for motif co-occurrence plot statistic inside
      hover boxes (default: 20)'
    default: 20
    inputBinding:
      position: 101
      prefix: --max-motif-dist
  - id: meme_no_check
    type:
      - 'null'
      - boolean
    doc: 'Disable MEME version check. Make sure --meme-no-pgc is set if MEME version
      >= 5.5.4 is installed! (default: False)'
    inputBinding:
      position: 101
      prefix: --meme-no-check
  - id: meme_no_pgc
    type:
      - 'null'
      - boolean
    doc: "Manually set MEME's FIMO --no-pgc option (required for MEME version >= 5.5.4).
      Make sure that MEME >= 5.5.4 is installed! (default: False)"
    inputBinding:
      position: 101
      prefix: --meme-no-pgc
  - id: min_motif_dist
    type:
      - 'null'
      - int
    doc: 'Set minimum mean motif distance for motif pair to be reported significant
      in motif co-occurrence heatmap plot. By default (value 0), all motif pairs <=
      set p-value are reported significant. So setting --min-motif-dist >= 0 acts
      as a second filter to show only motif pairs with signficiant p-values as significant
      if there is the specified minimum average distance between their motif hits
      (default: 0)'
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
      RBP motifs from Ray et al. 2013 (80 RBPs, 102 motifs, "ray2013_human_rbps_rnacompete")
      (default: 1)'
    default: 1
    inputBinding:
      position: 101
      prefix: --motif-db
  - id: motif_ids
    type:
      - 'null'
      - type: array
        items: string
    doc: Provide IDs for motifs of interest (need to be in database and loaded).
      All other RBP motifs will be discarded (except --regex)
    inputBinding:
      position: 101
      prefix: --motifs
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
  - id: motif_regex_id
    type:
      - 'null'
      - boolean
    doc: Use --regex-id for motif ID as well. By default, regular expression 
      string is used as motif ID for regex motif hits
    inputBinding:
      position: 101
      prefix: --motif-regex-id
  - id: motif_sim_cap
    type:
      - 'null'
      - float
    doc: 'Cap maximum motif similarity value to given value (default: 50)'
    default: 50.0
    inputBinding:
      position: 101
      prefix: --motif-sim-cap
  - id: motif_sim_norm
    type:
      - 'null'
      - boolean
    doc: 'Normalize motif similarities (min-max normalization) for PCA plot (default:
      False)'
    inputBinding:
      position: 101
      prefix: --motif-sim-norm
  - id: motif_sim_thr
    type:
      - 'null'
      - float
    doc: 'Set motif pair similarity threshold for to filter out significantly co-occurring
      motifs that are similar to each other. Similarity between motifs is measured
      in -log10(TOMTOM p-value), so the larger the pair similarity value of two motifs,
      the more similar they are. E.g., --motif-sim-thr 2 corresponds to TOMTOM p-value
      of 0.01, to filter out motif pairs > 2 similarity (default: None)'
    inputBinding:
      position: 101
      prefix: --motif-sim-thr
  - id: nemo_pval_mode
    type:
      - 'null'
      - int
    doc: 'Defines multiple testing correction mode for motif enrichment p-values.
      1: Benjamini-Hochberg (BH), 2: Bonferroni, 3: no correction (default: 1)'
    default: 1
    inputBinding:
      position: 101
      prefix: --nemo-pval-mode
  - id: nemo_pval_thr
    type:
      - 'null'
      - float
    doc: 'P-value threshold for reporting significantly enriched motifs. NOTE that
      if --nemo-pval-mode Bonferroni is selected, this threshold gets further adjusted
      by Bonferroni correction (i.e. divided by number of tests). Threshold applies
      unchanged for BH corrected p-values as well as for disabled correction (default:
      0.001)'
    default: 0.001
    inputBinding:
      position: 101
      prefix: --nemo-pval-thr
  - id: output_folder
    type: Directory
    doc: Results output folder
    inputBinding:
      position: 101
      prefix: --out
  - id: plot_abs_paths
    type:
      - 'null'
      - boolean
    doc: 'Store plot files with absolute paths in HTML files. Default is relative
      paths (default: False)'
    inputBinding:
      position: 101
      prefix: --plot-abs-paths
  - id: plot_pdf
    type:
      - 'null'
      - boolean
    doc: 'Also output .png plots as .pdf in plotting subfolder (default: False)'
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
      into main HTML! (default: 1)'
    default: 1
    inputBinding:
      position: 101
      prefix: --plotly-js-mode
  - id: random_seed
    type:
      - 'null'
      - int
    doc: 'Set a fixed random seed number (e.g. --random-seed 1) to obtain reproducible
      sampling results (default: None)'
    inputBinding:
      position: 101
      prefix: --random-seed
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
    doc: 'Set regex ID used as RBP ID and database ID associated to -regex hits (default:
      "regex")'
    default: regex
    inputBinding:
      position: 101
      prefix: --regex-id
  - id: regex_max_gu
    type:
      - 'null'
      - float
    doc: 'Maximum GU (GT) base pair fraction to report structure pattern regex hits
      (default: 1.0)'
    default: 1.0
    inputBinding:
      position: 101
      prefix: --regex-max-gu
  - id: regex_min_gc
    type:
      - 'null'
      - float
    doc: 'Minimum GC base pair fraction to report structure pattern regex hits (default:
      0.0)'
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
      1 (default: 1)'
    default: 1
    inputBinding:
      position: 101
      prefix: --regex-search-mode
  - id: regex_spacer_max
    type:
      - 'null'
      - int
    doc: 'Maximum spacer length for structure pattern regex search (default: 200)'
    default: 200
    inputBinding:
      position: 101
      prefix: --regex-spacer-max
  - id: regex_spacer_min
    type:
      - 'null'
      - int
    doc: 'Minimum spacer length for structure pattern regex search (default: 5)'
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
      3: given --regex string is structure pattern string, e.g. ((AA(((...)))AA))
      (default: 1)'
    default: 1
    inputBinding:
      position: 101
      prefix: --regex-type
  - id: sort_js_mode
    type:
      - 'null'
      - int
    doc: 'Define how to provide sorttable.js file. 1: link to packaged .js file. 2:
      copy .js file to plots output folder. 3: include .js code in HTML (default:
      1)'
    default: 1
    inputBinding:
      position: 101
      prefix: --sort-js-mode
  - id: tr_list
    type:
      - 'null'
      - File
    doc: Supply file with transcript IDs (one ID per row) to define which 
      transcripts to use from --gtf to extract control regions
    inputBinding:
      position: 101
      prefix: --tr-list
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
stdout: rbpbench_nemo.out
