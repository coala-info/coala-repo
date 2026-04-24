cwlVersion: v1.2
class: CommandLineTool
baseCommand: humann2_renorm_table
label: humann2_humann2_renorm_table
doc: "Renormalize a HUMAnN2 table to relative abundance or other units.\n\nTool homepage:
  http://huttenhower.sph.harvard.edu/humann2"
inputs:
  - id: input
    type: File
    doc: The HUMAnN2 table to renormalize
    inputBinding:
      position: 101
      prefix: --input
  - id: mode
    type:
      - 'null'
      - string
    doc: 'The normalization mode [choices: community, gene]'
    inputBinding:
      position: 101
      prefix: --mode
  - id: special
    type:
      - 'null'
      - string
    doc: 'Include the special features (UNMAPPED, UNINTEGRATED, and UNGROUPED) [choices:
      y, n]'
    inputBinding:
      position: 101
      prefix: --special
  - id: units
    type:
      - 'null'
      - string
    doc: 'The units to normalize to [choices: copies, relab]'
    inputBinding:
      position: 101
      prefix: --units
  - id: update_snames
    type:
      - 'null'
      - boolean
    doc: Update the sample names in the output table
    inputBinding:
      position: 101
      prefix: --update-snames
outputs:
  - id: output
    type: File
    doc: The path to write the renormalized table
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/humann2:2.8.1--py27_0
