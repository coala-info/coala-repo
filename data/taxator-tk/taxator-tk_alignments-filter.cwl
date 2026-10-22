cwlVersion: v1.2
class: CommandLineTool
baseCommand: alignments-filter
label: taxator-tk_alignments-filter
doc: "Filter alignments in the taxator-tk tab-separated format (read from standard input) by score, identity, e-value and rank, and write them to standard output.

Tool homepage: https://github.com/fungs/taxator-tk"
inputs:
  - id: alignments
    type: File
    doc: "Alignments in the taxator-tk tab-separated format, read from standard input"
  - id: min_score
    type:
      - 'null'
      - float
    doc: "set min-score filter value"
    inputBinding:
      position: 101
      prefix: --min-score
  - id: min_pid
    type:
      - 'null'
      - float
    doc: "set minimal PID to consider"
    inputBinding:
      position: 101
      prefix: --min-pid
  - id: top_percent
    type:
      - 'null'
      - float
    doc: "set top-percent filter value"
    inputBinding:
      position: 101
      prefix: --top-percent
  - id: max_evalue
    type:
      - 'null'
      - float
    doc: "set maximum evalue for filtering"
    inputBinding:
      position: 101
      prefix: --max-evalue
  - id: best_alignments
    type:
      - 'null'
      - int
    doc: "set number of top score alignments to consider (after toppercent filter)"
    inputBinding:
      position: 101
      prefix: --best-alignments
  - id: sort_score
    type:
      - 'null'
      - boolean
    doc: "sort alignments by decreasing score"
    inputBinding:
      position: 101
      prefix: --sort-score
  - id: keep_best_per_ref
    type:
      - 'null'
      - boolean
    doc: "for each combination of query and reference sequence id all but the best scoring alignment are removed"
    inputBinding:
      position: 101
      prefix: --keep-best-per-ref
  - id: min_support
    type:
      - 'null'
      - int
    doc: "set minimum number of hits an alignment needs to have (after filtering)"
    inputBinding:
      position: 101
      prefix: --min-support
  - id: remove_ref_from_query_taxon
    type:
      - 'null'
      - boolean
    doc: "remove alignments for labeled data to test different degrees of taxonomic distance"
    inputBinding:
      position: 101
      prefix: --remove-ref-from-query-taxon
  - id: taxon_mapping_sample
    type:
      - 'null'
      - File
    doc: "map sample identifier to taxon"
    inputBinding:
      position: 101
      prefix: --taxon-mapping-sample
  - id: taxon_mapping_reference
    type:
      - 'null'
      - File
    doc: "map reference identifier to taxon"
    inputBinding:
      position: 101
      prefix: --taxon-mapping-reference
  - id: mask_by_star
    type:
      - 'null'
      - boolean
    doc: "instead of suppressing filtered alignments mask them by prefixing a star at the line start"
    inputBinding:
      position: 101
      prefix: --mask-by-star
outputs:
  - id: stdout
    type: stdout
    doc: "Filtered alignments"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/taxator-tk:1.3.3e--0
stdout: taxator-tk_alignments-filter.out
stdin: $(inputs.alignments.path)
