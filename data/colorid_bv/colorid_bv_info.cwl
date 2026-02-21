cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - colorid_bv
  - info
label: colorid_bv_info
doc: "dumps index parameters and accessions\n\nTool homepage: https://github.com/hcdenbakker/colorid_bv"
inputs:
  - id: bigsi
    type: File
    doc: index for which info is requested
    inputBinding:
      position: 101
      prefix: --bigsi
  - id: compressed
    type:
      - 'null'
      - string
    doc: If set to 'true', it is assumed a gz compressed index is used
    inputBinding:
      position: 101
      prefix: --compressed
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/colorid_bv:0.1.0--h3ab6199_2
stdout: colorid_bv_info.out
