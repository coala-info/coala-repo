cwlVersion: v1.2
class: CommandLineTool
baseCommand: humann_renorm_table
label: humann_humann_renorm_table
doc: "Renormalize a HUMAnN table to relative abundance or copies per million (CPM)
  units.\n\nTool homepage: http://huttenhower.sph.harvard.edu/humann"
inputs:
  - id: input
    type: File
    doc: The HUMAnN table to renormalize
    inputBinding:
      position: 101
      prefix: --input
  - id: mode
    type:
      - 'null'
      - string
    doc: 'The normalization mode (e.g., community: normalize all levels by the same
      sum, features: normalize each level independently)'
    inputBinding:
      position: 101
      prefix: --mode
  - id: special_features
    type:
      - 'null'
      - string
    doc: Whether to include special features (UNMAPPED, UNGROUPED, etc.) in the normalization
    inputBinding:
      position: 101
      prefix: --special-features
  - id: units
    type:
      - 'null'
      - string
    doc: 'The units to normalize to (e.g., relab: relative abundance, cpm: copies
      per million)'
    inputBinding:
      position: 101
      prefix: --units
  - id: update_snames
    type:
      - 'null'
      - boolean
    doc: Update the suffix of the sample names to reflect the new units
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
    dockerPull: quay.io/biocontainers/humann:3.9--py312hdfd78af_0
