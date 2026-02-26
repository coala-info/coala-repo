cwlVersion: v1.2
class: CommandLineTool
baseCommand: amptk-merge_metadata.py
label: amptk_meta
doc: "Takes a meta data csv file and OTU table and makes transposed output files.\n\
  \nTool homepage: https://github.com/nextgenusfs/amptk"
inputs:
  - id: input_otu_table
    type: File
    doc: OTU table
    inputBinding:
      position: 101
      prefix: --input
  - id: meta_data
    type: string
    doc: Meta data (csv format, e.g. from excel)
    inputBinding:
      position: 101
      prefix: --meta
  - id: output_name
    type: string
    doc: Output name
    inputBinding:
      position: 101
      prefix: --out
  - id: split_taxonomy
    type:
      - 'null'
      - string
    doc: Split output files based on taxonomy levels
    inputBinding:
      position: 101
      prefix: --split_taxonomy
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/amptk:1.6.0--pyhdfd78af_0
stdout: amptk_meta.out
