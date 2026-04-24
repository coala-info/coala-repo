cwlVersion: v1.2
class: CommandLineTool
baseCommand: rbpbench searchlong
label: rbpbench_searchlong
doc: "Search for RBP motifs in genomic regions.\n\nTool homepage: https://github.com/michauhl/RBPBench"
inputs:
  - id: cmsearch_bs
    type:
      - 'null'
      - float
    doc: 'CMSEARCH bit score threshold (CMSEARCH options: -T --incT). The higher the
      more strict (default: 1.0)'
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
    inputBinding:
      position: 101
      prefix: --cmsearch-mode
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
    inputBinding:
      position: 101
      prefix: --fimo-ntf-mode
  - id: fimo_pval
    type:
      - 'null'
      - float
    doc: 'FIMO p-value threshold (FIMO option: --thresh) (default: 0.0005)'
    inputBinding:
      position: 101
      prefix: --fimo-pval
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
  - id: genome
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
  - id: gtf
    type:
      - 'null'
      - File
    doc: Input GTF file with genomic annotations to generate genomic region 
      annotation plots (output to motif statistics HTML). By default the most 
      prominent transcripts will be extracted and used for functional 
      annotation. Alternatively, provide a list of expressed transcripts via 
      --tr-list (together with --gtf containing the transcripts). Note that only
      features on standard chromosomes (1,2,..,X,Y,MT) are currently used for 
      annotation
    inputBinding:
      position: 101
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
      position: 101
      prefix: --gtf-feat-min-overlap
  - id: input_file
    type: File
    doc: Genomic regions file in BED format OR file with transcript IDs (one ID 
      per row) to define genomic regions in which to search for motifs (requires
      --gtf)
    inputBinding:
      position: 101
      prefix: --in
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
  - id: method_id
    type:
      - 'null'
      - string
    doc: Method ID
    inputBinding:
      position: 101
      prefix: --method-id
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
      position: 101
      prefix: --motif-db
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
    doc: 'Store plot files with absolute paths in HTML report. Default is relative
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
    inputBinding:
      position: 101
      prefix: --regex-id
  - id: regex_max_gu
    type:
      - 'null'
      - float
    doc: 'Maximum GU (GT) base pair fraction to report structure pattern regex hits
      (default: 1.0)'
    inputBinding:
      position: 101
      prefix: --regex-max-gu
  - id: regex_min_gc
    type:
      - 'null'
      - float
    doc: 'Minimum GC base pair fraction to report structure pattern regex hits (default:
      0.0)'
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
    inputBinding:
      position: 101
      prefix: --regex-search-mode
  - id: regex_spacer_max
    type:
      - 'null'
      - int
    doc: 'Maximum spacer length for structure pattern regex search (default: 200)'
    inputBinding:
      position: 101
      prefix: --regex-spacer-max
  - id: regex_spacer_min
    type:
      - 'null'
      - int
    doc: 'Minimum spacer length for structure pattern regex search (default: 5)'
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
  - id: sort_js_mode
    type:
      - 'null'
      - int
    doc: 'Define how to provide sorttable.js file. 1: link to packaged .js file. 2:
      copy .js file to plots output folder. 3: include .js code in HTML (default:
      1)'
    inputBinding:
      position: 101
      prefix: --sort-js-mode
  - id: top_n_matched
    type:
      - 'null'
      - int
    doc: 'Set top n matched sequences to be displayed in motif hit statistics HTML
      report (create via --plot-motifs) (default: 10)'
    inputBinding:
      position: 101
      prefix: --top-n-matched
  - id: tr_list
    type:
      - 'null'
      - File
    doc: Supply file with transcript IDs (one ID per row) to define which 
      transcripts to use from --gtf for genomic region annotations plots
    inputBinding:
      position: 101
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
      position: 101
      prefix: --tr-types
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
stdout: rbpbench_searchlong.out
