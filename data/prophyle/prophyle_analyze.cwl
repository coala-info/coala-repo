cwlVersion: v1.2
class: CommandLineTool
baseCommand: prophyle analyze
label: prophyle_analyze
doc: "Analyze classified reads based on an index directory or phylogenetic tree.\n\
  \nTool homepage: https://github.com/karel-brinda/prophyle"
inputs:
  - id: index_dir_or_tree
    type: string
    doc: index directory or phylogenetic tree
    inputBinding:
      position: 1
  - id: output_prefix
    type: string
    doc: output prefix
    inputBinding:
      position: 2
  - id: classified_bam
    type:
      type: array
      items: File
    doc: classified reads (use '-' for stdin)
    inputBinding:
      position: 3
  - id: advanced_config
    type:
      - 'null'
      - type: array
        items: string
    doc: advanced configuration (a JSON dictionary)
    inputBinding:
      position: 104
      prefix: -c
  - id: input_format
    type:
      - 'null'
      - string
    doc: Input format of assignments [auto]
    default: auto
    inputBinding:
      position: 104
      prefix: -f
  - id: statistics_type
    type:
      - 'null'
      - string
    doc: 'statistics to use for the computation of histograms: w (default) => weighted
      assignments; u => unique assignments, non-weighted; wl => weighted assignments,
      propagated to leaves; ul => unique assignments, propagated to leaves.'
    default: w
    inputBinding:
      position: 104
      prefix: -s
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/prophyle:0.3.3.2--py39h746d604_3
stdout: prophyle_analyze.out
