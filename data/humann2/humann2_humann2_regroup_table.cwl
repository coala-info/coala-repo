cwlVersion: v1.2
class: CommandLineTool
baseCommand: humann2_regroup_table
label: humann2_humann2_regroup_table
doc: "Regroup HUMAnN2 table features (e.g. convert UniRef50 gene families to GO terms
  or KO groups).\n\nTool homepage: http://huttenhower.sph.harvard.edu/humann2"
inputs:
  - id: custom
    type:
      - 'null'
      - File
    doc: A custom groups file
    inputBinding:
      position: 101
      prefix: --custom
  - id: function
    type:
      - 'null'
      - string
    doc: The function to use for regrouping (sum, mean, max)
    default: sum
    inputBinding:
      position: 101
      prefix: --function
  - id: groups
    type:
      - 'null'
      - string
    doc: The built-in groups to use (e.g., uniprot50, uniprot90, infogo1000, eggnog,
      ko, level2, pathway)
    inputBinding:
      position: 101
      prefix: --groups
  - id: input
    type: File
    doc: The HUMAnN2 table to regroup
    inputBinding:
      position: 101
      prefix: --input
  - id: precision
    type:
      - 'null'
      - boolean
    doc: If set, print the output with more decimal places
    inputBinding:
      position: 101
      prefix: --precision
  - id: reversed
    type:
      - 'null'
      - boolean
    doc: If set, the groups file is reversed (mapping from group to feature)
    inputBinding:
      position: 101
      prefix: --reversed
outputs:
  - id: output
    type: File
    doc: The path to write the new regrouped table
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/humann2:2.8.1--py27_0
