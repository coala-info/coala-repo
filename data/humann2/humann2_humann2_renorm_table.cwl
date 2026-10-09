cwlVersion: v1.2
class: CommandLineTool
baseCommand: humann2_renorm_table
label: humann2_humann2_renorm_table
doc: "Renormalize a HUMAnN2 table to relative abundance or copies per million (CPM)
  units.\n\nTool homepage: http://huttenhower.sph.harvard.edu/humann2"
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
    doc: 'Normalize all levels by community total or levelwise totals: community or
      levelwise (default community)'
    inputBinding:
      position: 101
      prefix: --mode
  - id: special
    type:
      - 'null'
      - string
    doc: 'Include the special features UNMAPPED, UNINTEGRATED, and UNGROUPED: y or
      n (default y)'
    inputBinding:
      position: 101
      prefix: --special
  - id: units
    type:
      - 'null'
      - string
    doc: 'Normalization scheme: copies per million (cpm) or relative abundance (relab);
      default cpm'
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
  - id: output_path
    type: string
    doc: Output or path parameter `output_path`
    inputBinding:
      position: 102
      prefix: --output
outputs:
  - id: output
    type: File
    doc: The path to write the renormalized table
    outputBinding:
      glob: $(inputs.output_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/humann2:2.8.1--py27_0
