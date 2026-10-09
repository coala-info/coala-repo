cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - kmcp
  - profile
label: kmcp_profile
doc: "Generate the taxonomic profile from search results\n\nTool homepage: https://github.com/shenwei356/kmcp"
inputs:
  - id: abund_max_iters
    type: ['null', int]
    doc: "Maximal iteration of abundance estimation (default 10)"
    inputBinding:
      position: 1
      prefix: "--abund-max-iters"
  - id: abund_pct_threshold
    type: ['null', float]
    doc: "If the percentage change of the predominant target is smaller than this threshold, stop the iteration (default 0.01)"
    inputBinding:
      position: 1
      prefix: "--abund-pct-threshold"
  - id: binning_result
    type: ['null', string]
    doc: "Save extra binning result in CAMI report"
    inputBinding:
      position: 1
      prefix: "--binning-result"
  - id: cami_report
    type: ['null', string]
    doc: "Save extra CAMI-like report"
    inputBinding:
      position: 1
      prefix: "--cami-report"
  - id: debug_file
    type: ['null', string]
    doc: "Debug output file"
    inputBinding:
      position: 1
      prefix: "--debug"
  - id: filter_low_pct
    type: ['null', float]
    doc: "Filter out predictions with the smallest relative abundances summing up X%. Range: [0,100)"
    inputBinding:
      position: 1
      prefix: "--filter-low-pct"
  - id: keep_main_matches
    type: ['null', boolean]
    doc: "Only keep main matches, abandon matches with sharply decreased qcov (> --max-qcov-gap)"
    inputBinding:
      position: 1
      prefix: "--keep-main-matches"
  - id: keep_perfect_matches
    type: ['null', boolean]
    doc: "Only keep the perfect matches (qcov == 1) if there are"
    inputBinding:
      position: 1
      prefix: "--keep-perfect-matches"
  - id: keep_top_qcovs
    type: ['null', int]
    doc: "Keep matches with the top N qcovs for a query, 0 for all"
    inputBinding:
      position: 1
      prefix: "--keep-top-qcovs"
  - id: level
    type: ['null', string]
    doc: "Level to estimate abundance at. Available values: species, strain/assembly (default \"species\")"
    inputBinding:
      position: 1
      prefix: "--level"
  - id: line_chunk_size
    type: ['null', int]
    doc: "Number of lines to process for each thread (default 5000)"
    inputBinding:
      position: 1
      prefix: "--line-chunk-size"
  - id: max_chunks_depth_stdev
    type: ['null', float]
    doc: "Maximum standard deviation of relative depths of all chunks (default 2)"
    inputBinding:
      position: 1
      prefix: "--max-chunks-depth-stdev"
  - id: max_fpr
    type: ['null', float]
    doc: "Maximum false positive rate of a read in search result (default 0.01)"
    inputBinding:
      position: 1
      prefix: "--max-fpr"
  - id: max_mismatch_err
    type: ['null', float]
    doc: "Maximum error rate of a read being matched to a wrong reference, for determing the right reference for ambiguous reads. Range: (0, 1) (default 0.05)"
    inputBinding:
      position: 1
      prefix: "--max-mismatch-err"
  - id: max_qcov_gap
    type: ['null', float]
    doc: "Max qcov gap between adjacent matches (default 0.4)"
    inputBinding:
      position: 1
      prefix: "--max-qcov-gap"
  - id: metaphlan_report
    type: ['null', string]
    doc: "Save extra metaphlan-like report"
    inputBinding:
      position: 1
      prefix: "--metaphlan-report"
  - id: metaphlan_report_version
    type: ['null', string]
    doc: "Metaphlan report version (2 or 3) (default \"3\")"
    inputBinding:
      position: 1
      prefix: "--metaphlan-report-version"
  - id: min_chunks_fraction
    type: ['null', float]
    doc: "Minimum fraction of matched reference chunks with reads >= -r/--min-chunks-reads (default 0.8)"
    inputBinding:
      position: 1
      prefix: "--min-chunks-fraction"
  - id: min_chunks_reads
    type: ['null', int]
    doc: "Minimum number of reads for a reference chunk (default 50)"
    inputBinding:
      position: 1
      prefix: "--min-chunks-reads"
  - id: min_dreads_prop
    type: ['null', float]
    doc: "Minimum proportion of distinct reads, for determing the right reference for ambiguous reads. Range: (0, 1) (default 0.05)"
    inputBinding:
      position: 1
      prefix: "--min-dreads-prop"
  - id: min_hic_ureads
    type: ['null', int]
    doc: "Minimum number of high-confidence uniquely matched reads for a reference (default 5)"
    inputBinding:
      position: 1
      prefix: "--min-hic-ureads"
  - id: min_hic_ureads_prop
    type: ['null', float]
    doc: "Minimum proportion of high-confidence uniquely matched reads (default 0.1)"
    inputBinding:
      position: 1
      prefix: "--min-hic-ureads-prop"
  - id: min_hic_ureads_qcov
    type: ['null', float]
    doc: "Minimum query coverage of high-confidence uniquely matched reads (default 0.75)"
    inputBinding:
      position: 1
      prefix: "--min-hic-ureads-qcov"
  - id: min_query_cov
    type: ['null', float]
    doc: "Minimum query coverage of a read in search result (default 0.55)"
    inputBinding:
      position: 1
      prefix: "--min-query-cov"
  - id: min_uniq_reads
    type: ['null', int]
    doc: "Minimum number of uniquely matched reads for a reference (default 20)"
    inputBinding:
      position: 1
      prefix: "--min-uniq-reads"
  - id: mode
    type: ['null', int]
    doc: "Profiling mode: 0 (for pathogen detection), 1 (higher recall), 2 (high recall), 3 (default), 4 (high precision), 5 (higher precision)"
    inputBinding:
      position: 1
      prefix: "--mode"
  - id: name_map
    type:
      - 'null'
      - type: array
        items: File
        inputBinding:
          prefix: --name-map
    doc: "Tabular two-column file(s) mapping reference IDs to reference names"
    inputBinding:
      position: 1
  - id: no_amb_corr
    type: ['null', boolean]
    doc: "Do not correct ambiguous reads"
    inputBinding:
      position: 1
      prefix: "--no-amb-corr"
  - id: norm_abund
    type: ['null', string]
    doc: "Method for normalize abundance of a reference by the mean/min/max abundance in all chunks, available values: mean, min, max (default \"mean\")"
    inputBinding:
      position: 1
      prefix: "--norm-abund"
  - id: out_file
    type: ['null', string]
    default: "kmcp_profile.tsv"
    doc: "Out file, supports a \".gz\" suffix (\"-\" for stdout)"
    inputBinding:
      position: 1
      prefix: "--out-file"
  - id: rank_prefix
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --rank-prefix
    doc: "Prefixes of taxon name in certain ranks, used with --metaphlan-report"
    inputBinding:
      position: 1
  - id: sample_id
    type: ['null', string]
    doc: "Sample ID in result file"
    inputBinding:
      position: 1
      prefix: "--sample-id"
  - id: separator
    type: ['null', string]
    doc: "Separator of TaxIds and taxonomy names (default \";\")"
    inputBinding:
      position: 1
      prefix: "--separator"
  - id: show_rank
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --show-rank
    doc: "Only show TaxIds and names of these ranks (default superkingdom, phylum, class, order, family, genus, species, strain)"
    inputBinding:
      position: 1
  - id: taxdump
    type: ['null', Directory]
    doc: "Directory of NCBI taxonomy dump files: names.dmp, nodes.dmp, optional with merged.dmp and delnodes.dmp"
    inputBinding:
      position: 1
      prefix: "--taxdump"
  - id: taxid_map
    type:
      - 'null'
      - type: array
        items: File
        inputBinding:
          prefix: --taxid-map
    doc: "Tabular two-column file(s) mapping reference IDs to TaxIds"
    inputBinding:
      position: 1
  - id: taxonomy_id
    type: ['null', string]
    doc: "Taxonomy ID in result file"
    inputBinding:
      position: 1
      prefix: "--taxonomy-id"
  - id: search_results
    type:
      type: array
      items: File
    doc: "Search result files (from kmcp search or kmcp merge)"
    inputBinding:
      position: 50
  - id: infile_list
    type: ['null', File]
    doc: "File of input files list (one file per line). If given, they are appended to files from CLI arguments. The listed files must be given in infile_list_files"
    inputBinding:
      position: 1
      prefix: "--infile-list"
  - id: infile_list_files
    type:
      - 'null'
      - type: array
        items: File
    doc: "Files named in infile_list, staged in the working directory"
  - id: log_file
    type: ['null', string]
    doc: "Log file"
    inputBinding:
      position: 1
      prefix: "--log"
  - id: quiet
    type: ['null', boolean]
    doc: "Do not print any verbose information. But you can write them to file with --log"
    inputBinding:
      position: 1
      prefix: "--quiet"
  - id: threads
    type: ['null', int]
    doc: "Number of CPUs cores to use (default 20)"
    inputBinding:
      position: 1
      prefix: "--threads"
outputs:
  - id: out_file_out
    type: ['null', File]
    doc: "Output file written with --out-file"
    outputBinding:
      glob: $(inputs.out_file)
  - id: log
    type: ['null', File]
    doc: "Log file"
    outputBinding:
      glob: $(inputs.log_file)
  - id: binning_report
    type: ['null', File]
    doc: "Binning result"
    outputBinding:
      glob: $(inputs.binning_result)*
  - id: cami
    type: ['null', File]
    doc: "CAMI-like report"
    outputBinding:
      glob: $(inputs.cami_report)*
  - id: metaphlan
    type: ['null', File]
    doc: "Metaphlan-like report"
    outputBinding:
      glob: $(inputs.metaphlan_report)*
  - id: debug
    type: ['null', File]
    doc: "Debug output"
    outputBinding:
      glob: $(inputs.debug_file)
  - id: stdout
    type: stdout
    doc: "Standard output"
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.infile_list_files)
      - $(inputs.infile_list)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kmcp:0.9.4--h9ee0642_1
stdout: kmcp_profile.out
