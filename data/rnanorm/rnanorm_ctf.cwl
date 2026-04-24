cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - rnanorm
  - ctf
label: rnanorm_ctf
doc: "Convert count data to TPM format.\n\nTool homepage: https://github.com/genialis/RNAnorm"
inputs:
  - id: exp
    type: File
    doc: Input count data (CSV format, index column is gene ID)
    inputBinding:
      position: 1
  - id: a_trim
    type:
      - 'null'
      - boolean
    doc: 'Trim average counts (default: False)'
    inputBinding:
      position: 102
      prefix: --a-trim
  - id: force
    type:
      - 'null'
      - boolean
    doc: Overwrite output file if it exists
    inputBinding:
      position: 102
      prefix: --force
  - id: m_trim
    type:
      - 'null'
      - boolean
    doc: 'Trim molecular counts (default: False)'
    inputBinding:
      position: 102
      prefix: --m-trim
outputs:
  - id: out
    type: File
    doc: Output file path for TPM data
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rnanorm:2.2.0--pyhdfd78af_1
