cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gemini
  - bcolz_index
label: gemini_bcolz_index
doc: "Index a Gemini database with bcolz.\n\nTool homepage: https://github.com/arq5x/gemini"
inputs:
  - id: db
    type: File
    doc: The path of the database to indexed with bcolz.
    inputBinding:
      position: 1
  - id: cols
    type:
      - 'null'
      - string
    doc: list of gt columns to index. default is all
    default: all
    inputBinding:
      position: 102
      prefix: --cols
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gemini:0.30.2--py27hacb5245_0
stdout: gemini_bcolz_index.out
