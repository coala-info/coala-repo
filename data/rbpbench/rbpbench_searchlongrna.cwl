cwlVersion: v1.2
class: CommandLineTool
baseCommand: rbpbench searchlongrna
label: rbpbench_searchlongrna
doc: "Search for RBP motifs in long RNA sequences.\n\nTool homepage: https://github.com/michauhl/RBPBench"
inputs:
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
  - id: goa
    type:
      - 'null'
      - boolean
    doc: 'Run gene ontology (GO) enrichment analysis on transcripts (i.e., their corresponding
      genes) with motif hits. Requires --gtf (default: False)'
    inputBinding:
      position: 101
      prefix: --goa
  - id: goa_filter_purified
    type:
      - 'null'
      - boolean
    doc: 'Filter out GOA results labeled as purified (i.e., GO terms with significantly
      lower concentration) in HTML table (default: False)'
    inputBinding:
      position: 101
      prefix: --goa-filter-purified
  - id: goa_gene2go_file
    type:
      - 'null'
      - File
    doc: 'Provide gene ID to GO IDs mapping table (row format: gene_id<tab>go_id1,go_id2).
      By default, a local file with ENSEMBL gene IDs is used. NOTE that gene IDs need
      to be compatible with --gtf (default: False)'
    inputBinding:
      position: 101
      prefix: --goa-gene2go-file
  - id: goa_max_child
    type:
      - 'null'
      - int
    doc: 'Specify maximum number of children for a significant GO term to be reported
      in HTML table, e.g. --goa-max- child 200. This allows filtering out very broad
      terms (default: None)'
    inputBinding:
      position: 101
      prefix: --goa-max-child
  - id: goa_min_depth
    type:
      - 'null'
      - int
    doc: 'Specify minimum depth number for a significant GO term to be reported in
      HTML table, e.g. --goa-min-depth 5 (default: None)'
    inputBinding:
      position: 101
      prefix: --goa-min-depth
  - id: goa_obo_file
    type:
      - 'null'
      - File
    doc: 'Provide GO DAG obo file (default: False)'
    inputBinding:
      position: 101
      prefix: --goa-obo-file
  - id: goa_obo_mode
    type:
      - 'null'
      - int
    doc: 'Define how to obtain GO DAG (directed acyclic graph) obo file. 1: download
      most recent file from internet, 2: use local file, 3: provide file via --goa-obo-file
      (default: 1)'
    default: 1
    inputBinding:
      position: 101
      prefix: --goa-obo-mode
  - id: goa_only_cooc
    type:
      - 'null'
      - boolean
    doc: 'Only look at regions in GO enrichment analysis which contain motifs by all
      specified RBPs (default: False)'
    inputBinding:
      position: 101
      prefix: --goa-only-cooc
  - id: goa_pval
    type:
      - 'null'
      - float
    doc: 'GO enrichment analysis p-value threshold (applied on corrected p-value)
      (default: 0.05)'
    default: 0.05
    inputBinding:
      position: 101
      prefix: --goa-pval
  - id: goa_rna_region
    type:
      - 'null'
      - int
    doc: "Define which (m)RNA region to use for motif hit GO enrichment analysis.
      1: whole transcript, 2: only 3'UTR regions, 3: only CDS regions, 4: only 5'UTR
      regions (default: 1)"
    default: 1
    inputBinding:
      position: 101
      prefix: --goa-rna-region
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
    type: File
    doc: Input GTF file with genomic annotations to extract spliced RNA 
      sequences. By default the most prominent transcript will be extracted and 
      used for each gene. Alternatively, provide a list of expressed transcripts
      via --tr-list (together with --gtf containing the transcripts). Note that 
      only features on standard chromosomes (1,2,..,X,Y,MT) are currently 
      considered
    inputBinding:
      position: 101
      prefix: --gtf
  - id: gtf_feat_min_overlap
    type:
      - 'null'
      - float
    doc: 'Minimum amount of overlap required for a motif hit to be assigned to a GTF
      feature (if less or no overlap, region will be assigned to "intergenic") (default:
      0.1)'
    default: 0.1
    inputBinding:
      position: 101
      prefix: --gtf-feat-min-overlap
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
    default: 1
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
  - id: mrna_norm_mode
    type:
      - 'null'
      - int
    doc: 'Define whether to use median or mean mRNA region lengths for plotting. 1:
      median. 2: mean (default: 1)'
    default: 1
    inputBinding:
      position: 101
      prefix: --mrna-norm-mode
  - id: mrna_only
    type:
      - 'null'
      - boolean
    doc: 'Set if only mRNAs should be extracted from --gtf file for motif search and
      plotting of mRNA region occupancies. To look only at specific mRNAs, use --tr-
      list and --mrna-only (default: False)'
    inputBinding:
      position: 101
      prefix: --mrna-only
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
    default: 1
    inputBinding:
      position: 101
      prefix: --sort-js-mode
  - id: top_n_matched
    type:
      - 'null'
      - int
    doc: 'Set top n matched sequences to be displayed in motif hit statistics HTML
      report (create via --plot-motifs) (default: 10)'
    default: 10
    inputBinding:
      position: 101
      prefix: --top-n-matched
  - id: tr_list
    type:
      - 'null'
      - File
    doc: Supply file with transcript IDs (one ID per row) to define which 
      transcripts to use from --gtf
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
  - id: out
    type: Directory
    doc: Results output folder
    outputBinding:
      glob: $(inputs.out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rbpbench:1.1.0--pyhdfd78af_0
