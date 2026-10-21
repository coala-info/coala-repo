cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - rnanorm
  - tmm
label: rnanorm_tmm
doc: "Compute TMM.\n\nTool homepage: https://github.com/genialis/RNAnorm"
inputs:
  - id: exp
    type: File
    doc: Input expression matrix (CSV or TSV, genes in columns)
    inputBinding:
      position: 1
  - id: force
    type:
      - 'null'
      - boolean
    doc: Overwrite already existing output file
    inputBinding:
      position: 102
      prefix: --force
  - id: m_trim
    type:
      - 'null'
      - float
    doc: Two sided cutoff for M-values
    inputBinding:
      position: 102
      prefix: --m_trim
  - id: a_trim
    type:
      - 'null'
      - float
    doc: Two sided cutoff for A-values
    inputBinding:
      position: 102
      prefix: --a_trim
  - id: out_path
    type: string
    doc: Output file name
    inputBinding:
      position: 103
      prefix: --out
outputs:
  - id: out
    type: File
    doc: Normalised expression table
    outputBinding:
      glob: $(inputs.out_path)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rnanorm:2.2.0--pyhdfd78af_1
