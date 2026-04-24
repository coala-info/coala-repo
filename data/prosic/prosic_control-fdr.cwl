cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - prosic
  - control-fdr
label: prosic_control-fdr
doc: "Filter calls for controlling the false discovery rate (FDR) at given level.\n\
  \nTool homepage: https://prosic.github.io"
inputs:
  - id: bcf_file
    type: File
    doc: Calls as provided by prosic tumor-normal.
    inputBinding:
      position: 1
  - id: event
    type:
      - 'null'
      - string
    doc: Event to consider.
    inputBinding:
      position: 102
      prefix: --event
  - id: fdr
    type:
      - 'null'
      - float
    doc: FDR to control for.
    inputBinding:
      position: 102
      prefix: --fdr
  - id: max_len
    type:
      - 'null'
      - int
    doc: Maximum indel length to consider (exclusive).
    inputBinding:
      position: 102
      prefix: --max-len
  - id: min_len
    type:
      - 'null'
      - int
    doc: Minimum indel length to consider.
    inputBinding:
      position: 102
      prefix: --min-len
  - id: variant_type
    type:
      - 'null'
      - string
    doc: Variant type to consider (SNV, INS, DEL).
    inputBinding:
      position: 102
      prefix: --var
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/prosic:2.1.2--hc7800f0_1
stdout: prosic_control-fdr.out
