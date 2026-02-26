cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - rnanorm
  - cuf
label: rnanorm_cuf
doc: "Normalize RNA-Seq count data using the CUF method.\n\nTool homepage: https://github.com/genialis/RNAnorm"
inputs:
  - id: exp
    type: File
    doc: Input expression matrix file (CSV format).
    inputBinding:
      position: 1
  - id: force
    type:
      - 'null'
      - boolean
    doc: Overwrite output file if it exists.
    inputBinding:
      position: 102
      prefix: --force
outputs:
  - id: out
    type:
      - 'null'
      - File
    doc: Output file path for normalized counts.
    outputBinding:
      glob: $(inputs.out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rnanorm:2.2.0--pyhdfd78af_1
