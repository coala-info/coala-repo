cwlVersion: v1.2
class: CommandLineTool
baseCommand: gemini dump
label: gemini_dump
doc: "Report all rows/columns from the variants table.\n\nTool homepage: https://github.com/arq5x/gemini"
inputs:
  - id: db
    type: string
    doc: The name of the database to be queried.
    inputBinding:
      position: 1
  - id: genotypes
    type:
      - 'null'
      - boolean
    doc: Report all rows/columns from the variants table with one line per 
      sample/genotype.
    inputBinding:
      position: 102
      prefix: --genotypes
  - id: header
    type:
      - 'null'
      - boolean
    doc: Add a header of column names to the output.
    inputBinding:
      position: 102
      prefix: --header
  - id: samples
    type:
      - 'null'
      - boolean
    doc: Report all rows/columns from the samples table.
    inputBinding:
      position: 102
      prefix: --samples
  - id: sep
    type:
      - 'null'
      - string
    doc: Output column separator
    inputBinding:
      position: 102
      prefix: --sep
  - id: tfam
    type:
      - 'null'
      - boolean
    doc: Output sample information to TFAM format.
    inputBinding:
      position: 102
      prefix: --tfam
  - id: variants
    type:
      - 'null'
      - boolean
    doc: Report all rows/columns from the variants table.
    inputBinding:
      position: 102
      prefix: --variants
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gemini:0.30.2--py27hacb5245_0
stdout: gemini_dump.out
