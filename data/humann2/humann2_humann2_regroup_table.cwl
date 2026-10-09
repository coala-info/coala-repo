cwlVersion: v1.2
class: CommandLineTool
baseCommand: humann2_regroup_table
label: humann2_humann2_regroup_table
doc: "HUMAnN utility for regrouping table features. Given a table of feature values and a mapping of groups to component features, produce a new table with group values in place of feature values.\n\nTool homepage: http://huttenhower.sph.harvard.edu/humann2"
inputs:
  - id: input
    type: File
    doc: "Original output table (tsv or biom format)"
    inputBinding:
      position: 101
      prefix: "--input"
  - id: groups
    type:
      - 'null'
      - string
    doc: "Built-in grouping options: uniref90_rxn or uniref50_rxn (needs the utility mapping databases)"
    inputBinding:
      position: 102
      prefix: "--groups"
  - id: custom
    type:
      - 'null'
      - File
    doc: "Custom groups file (.tsv or .tsv.gz format)"
    inputBinding:
      position: 103
      prefix: "--custom"
  - id: reversed
    type:
      - 'null'
      - boolean
    doc: "Custom groups file is reversed: mapping from features to groups"
    inputBinding:
      position: 104
      prefix: "--reversed"
  - id: function
    type:
      - 'null'
      - string
    doc: "How to combine grouped features: sum or mean (default sum)"
    inputBinding:
      position: 105
      prefix: "--function"
  - id: precision
    type:
      - 'null'
      - int
    doc: "Decimal places to round to after applying function (default: don't round)"
    inputBinding:
      position: 106
      prefix: "--precision"
  - id: ungrouped
    type:
      - 'null'
      - string
    doc: "Include an 'UNGROUPED' group to capture features that did not belong to other groups: Y or N (default Y)"
    inputBinding:
      position: 107
      prefix: "--ungrouped"
  - id: protected
    type:
      - 'null'
      - string
    doc: "Carry through protected features, such as 'UNMAPPED': Y or N (default Y)"
    inputBinding:
      position: 108
      prefix: "--protected"
  - id: output_path
    type: string
    doc: "Path for modified output table"
    inputBinding:
      position: 109
      prefix: "--output"
outputs:
  - id: output
    type: File
    doc: "regrouped table"
    outputBinding:
      glob: '$(inputs.output_path)'
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/humann2:2.8.1--py27_0
