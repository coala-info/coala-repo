cwlVersion: v1.2
class: CommandLineTool
baseCommand: gemini qc
label: gemini_qc
doc: "Run quality control tests on a Gemini database.\n\nTool homepage: https://github.com/arq5x/gemini"
inputs:
  - id: db
    type: string
    doc: The name of the database to be queried.
    inputBinding:
      position: 1
  - id: chrom
    type:
      - 'null'
      - string
    doc: Which chromosome should the sex test be applied to?
    inputBinding:
      position: 102
      prefix: --chrom
  - id: mode
    type:
      - 'null'
      - string
    doc: What type of QC should be run?
    inputBinding:
      position: 102
      prefix: --mode
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gemini:0.30.2--py27hacb5245_0
stdout: gemini_qc.out
