cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bgt
  - bcfidx
label: bgt_bcfidx
doc: "Index a BCF file.\n\nTool homepage: https://github.com/Dysman/bgTools-playerPrefsEditor"
inputs:
  - id: input_bcf
    type: File
    doc: Input BCF file to index
    inputBinding:
      position: 1
  - id: min_shift
    type:
      - 'null'
      - int
    doc: Minimum shift for indexing
    inputBinding:
      position: 102
      prefix: -s
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bgt:r283--h577a1d6_7
stdout: bgt_bcfidx.out
