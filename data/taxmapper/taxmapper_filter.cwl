cwlVersion: v1.2
class: CommandLineTool
baseCommand: taxmapper_filter
label: taxmapper_filter
doc: "Filter taxonomy mapping file based on various thresholds.\n\nTool homepage:
  https://bitbucket.org/dbeisser/taxmapper"
inputs:
  - id: automatic_filter_threshold
    type:
      - 'null'
      - float
    doc: 'Automatic filter with probability threshold, if automatic filter is chosen
      all other thresholds will be ignored [nan or 0 - 1, default: 0.4]'
    default: 0.4
    inputBinding:
      position: 101
      prefix: --auto
  - id: evalue_diff_threshold
    type:
      - 'null'
      - float
    doc: 'Threshold for absolute difference in e-values [0 - 100, default: nan]'
    default: nan
    inputBinding:
      position: 101
      prefix: --evalue-diff
  - id: evalue_threshold
    type:
      - 'null'
      - float
    doc: Threshold for log e-values of best hit
    default: nan
    inputBinding:
      position: 101
      prefix: --evalue
  - id: identity_ratio_threshold
    type:
      - 'null'
      - float
    doc: 'Threshold for identity ratio [1 - 10, default: nan]'
    default: nan
    inputBinding:
      position: 101
      prefix: --identity-ratio
  - id: identity_threshold
    type:
      - 'null'
      - float
    doc: Threshold for identity of best hit
    default: nan
    inputBinding:
      position: 101
      prefix: --identity
  - id: taxa_file
    type: File
    doc: Taxonomy mapping file (taxa.tsv if not specified otherwise).
    inputBinding:
      position: 101
      prefix: --tax
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Output file
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/taxmapper:1.0.2--py36_0
