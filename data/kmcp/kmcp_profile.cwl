cwlVersion: v1.2
class: CommandLineTool
baseCommand: kmcp profile
label: kmcp_profile
doc: "Generate the taxonomic profile from search results\n\nTool homepage: https://github.com/shenwei356/kmcp"
inputs:
  - id: search_results
    type: File
    doc: Search results file
    inputBinding:
      position: 1
  - id: abund_max_iters
    type:
      - 'null'
      - int
    doc: Miximal iteration of abundance estimation.
    default: 10
    inputBinding:
      position: 102
      prefix: --abund-max-iters
  - id: abund_pct_threshold
    type:
      - 'null'
      - float
    doc: If the percentage change of the predominant target is smaller than this
      threshold, stop the iteration.
    default: 0.01
    inputBinding:
      position: 102
      prefix: --abund-pct-threshold
  - id: filter_low_pct
    type:
      - 'null'
      - float
    doc: 'Filter out predictions with the smallest relative abundances summing up
      X%. Range: [0,100).'
    inputBinding:
      position: 102
      prefix: --filter-low-pct
  - id: infile_list
    type:
      - 'null'
      - File
    doc: File of input files list (one file per line). If given, they are 
      appended to files from CLI arguments.
    inputBinding:
      position: 102
      prefix: --infile-list
  - id: keep_main_matches
    type:
      - 'null'
      - boolean
    doc: Only keep main matches, abandon matches with sharply decreased qcov (> 
      --max-qcov-gap).
    inputBinding:
      position: 102
      prefix: --keep-main-matches
  - id: keep_perfect_matches
    type:
      - 'null'
      - boolean
    doc: Only keep the perfect matches (qcov == 1) if there are.
    inputBinding:
      position: 102
      prefix: --keep-perfect-matches
  - id: keep_top_qcovs
    type:
      - 'null'
      - int
    doc: Keep matches with the top N qcovs for a query, 0 for all.
    inputBinding:
      position: 102
      prefix: --keep-top-qcovs
  - id: level
    type:
      - 'null'
      - string
    doc: 'Level to estimate abundance at. Available values: species, strain/assembly.'
    default: species
    inputBinding:
      position: 102
      prefix: --level
  - id: line_chunk_size
    type:
      - 'null'
      - int
    doc: Number of lines to process for each thread, and 4 threads is fast 
      enough. Type "kmcp profile -h" for details.
    default: 5000
    inputBinding:
      position: 102
      prefix: --line-chunk-size
  - id: max_chunks_depth_stdev
    type:
      - 'null'
      - float
    doc: Maximum standard deviation of relative depths of all chunks.
    default: 2.0
    inputBinding:
      position: 102
      prefix: --max-chunks-depth-stdev
  - id: max_fpr
    type:
      - 'null'
      - float
    doc: Maximum false positive rate of a read in search result.
    default: 0.01
    inputBinding:
      position: 102
      prefix: --max-fpr
  - id: max_mismatch_err
    type:
      - 'null'
      - float
    doc: 'Maximum error rate of a read being matched to a wrong reference, for determing
      the right reference for ambiguous reads. Range: (0, 1).'
    default: 0.05
    inputBinding:
      position: 102
      prefix: --max-mismatch-err
  - id: max_qcov_gap
    type:
      - 'null'
      - float
    doc: Max qcov gap between adjacent matches.
    default: 0.4
    inputBinding:
      position: 102
      prefix: --max-qcov-gap
  - id: metaphlan_report_version
    type:
      - 'null'
      - string
    doc: Metaphlan report version (2 or 3)
    default: '3'
    inputBinding:
      position: 102
      prefix: --metaphlan-report-version
  - id: min_chunks_fraction
    type:
      - 'null'
      - float
    doc: Minimum fraction of matched reference chunks with reads >= 
      -r/--min-chunks-reads.
    default: 0.8
    inputBinding:
      position: 102
      prefix: --min-chunks-fraction
  - id: min_chunks_reads
    type:
      - 'null'
      - int
    doc: Minimum number of reads for a reference chunk.
    default: 50
    inputBinding:
      position: 102
      prefix: --min-chunks-reads
  - id: min_dreads_prop
    type:
      - 'null'
      - float
    doc: 'Minimum proportion of distinct reads, for determing the right reference
      for ambiguous reads. Range: (0, 1).'
    default: 0.05
    inputBinding:
      position: 102
      prefix: --min-dreads-prop
  - id: min_hic_ureads
    type:
      - 'null'
      - int
    doc: Minimum number of high-confidence uniquely matched reads for a 
      reference.
    default: 5
    inputBinding:
      position: 102
      prefix: --min-hic-ureads
  - id: min_hic_ureads_prop
    type:
      - 'null'
      - float
    doc: Minimum proportion of high-confidence uniquely matched reads.
    default: 0.1
    inputBinding:
      position: 102
      prefix: --min-hic-ureads-prop
  - id: min_hic_ureads_qcov
    type:
      - 'null'
      - float
    doc: Minimum query coverage of high-confidence uniquely matched reads.
    default: 0.75
    inputBinding:
      position: 102
      prefix: --min-hic-ureads-qcov
  - id: min_query_cov
    type:
      - 'null'
      - float
    doc: Minimum query coverage of a read in search result.
    default: 0.55
    inputBinding:
      position: 102
      prefix: --min-query-cov
  - id: min_uniq_reads
    type:
      - 'null'
      - int
    doc: Minimum number of uniquely matched reads for a reference.
    default: 20
    inputBinding:
      position: 102
      prefix: --min-uniq-reads
  - id: mode
    type:
      - 'null'
      - int
    doc: 'Profiling mode, type "kmcp profile -h" for details. available values: 0
      (for pathogen detection), 1 (higherrecall), 2 (high recall), 3 (default), 4
      (high precision), 5 (higher precision).'
    default: 3
    inputBinding:
      position: 102
      prefix: --mode
  - id: name_map
    type:
      - 'null'
      - type: array
        items: File
    doc: Tabular two-column file(s) mapping reference IDs to reference names.
    inputBinding:
      position: 102
      prefix: --name-map
  - id: no_amb_corr
    type:
      - 'null'
      - boolean
    doc: Do not correct ambiguous reads. Use this flag to reduce analysis time 
      if the stage 1/4 produces thousands of candidates.
    inputBinding:
      position: 102
      prefix: --no-amb-corr
  - id: norm_abund
    type:
      - 'null'
      - string
    doc: 'Method for normalize abundance of a reference by the mean/min/max abundance
      in all chunks, available values: mean, min, max.'
    default: mean
    inputBinding:
      position: 102
      prefix: --norm-abund
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Do not print any verbose information. But you can write them to file 
      with --log.
    inputBinding:
      position: 102
      prefix: --quiet
  - id: rank_prefix
    type:
      - 'null'
      - type: array
        items: string
    doc: Prefixes of taxon name in certain ranks, used with --metaphlan-report.
    default:
      - k__
      - p__
      - c__
      - o__
      - f__
      - g__
      - s__
      - t__
    inputBinding:
      position: 102
      prefix: --rank-prefix
  - id: sample_id
    type:
      - 'null'
      - string
    doc: Sample ID in result file.
    inputBinding:
      position: 102
      prefix: --sample-id
  - id: separator
    type:
      - 'null'
      - string
    doc: Separator of TaxIds and taxonomy names.
    default: ;
    inputBinding:
      position: 102
      prefix: --separator
  - id: show_rank
    type:
      - 'null'
      - type: array
        items: string
    doc: Only show TaxIds and names of these ranks.
    default:
      - superkingdom
      - phylum
      - class
      - order
      - family
      - genus
      - species
      - strain
    inputBinding:
      position: 102
      prefix: --show-rank
  - id: taxdump
    type:
      - 'null'
      - Directory
    doc: 'Directory of NCBI taxonomy dump files: names.dmp, nodes.dmp, optional with
      merged.dmp and delnodes.dmp.'
    inputBinding:
      position: 102
      prefix: --taxdump
  - id: taxid_map
    type:
      - 'null'
      - type: array
        items: File
    doc: Tabular two-column file(s) mapping reference IDs to TaxIds.
    inputBinding:
      position: 102
      prefix: --taxid-map
  - id: taxonomy_id
    type:
      - 'null'
      - string
    doc: Taxonomy ID in result file.
    inputBinding:
      position: 102
      prefix: --taxonomy-id
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of CPUs cores to use.
    default: 20
    inputBinding:
      position: 102
      prefix: --threads
outputs:
  - id: binning_result
    type:
      - 'null'
      - File
    doc: Save extra binning result in CAMI report.
    outputBinding:
      glob: $(inputs.binning_result)
  - id: cami_report
    type:
      - 'null'
      - File
    doc: Save extra CAMI-like report.
    outputBinding:
      glob: $(inputs.cami_report)
  - id: debug
    type:
      - 'null'
      - File
    doc: Debug output file.
    outputBinding:
      glob: $(inputs.debug)
  - id: metaphlan_report
    type:
      - 'null'
      - File
    doc: Save extra metaphlan-like report.
    outputBinding:
      glob: $(inputs.metaphlan_report)
  - id: out_file
    type:
      - 'null'
      - File
    doc: Out file, supports a ".gz" suffix ("-" for stdout).
    outputBinding:
      glob: $(inputs.out_file)
  - id: log
    type:
      - 'null'
      - File
    doc: Log file.
    outputBinding:
      glob: $(inputs.log)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kmcp:0.9.4--h9ee0642_1
