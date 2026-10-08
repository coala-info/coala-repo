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
      valueFrom: $(self.basename)
  - id: cols
    type:
      - 'null'
      - string
    doc: list of gt columns to index. default is all
    inputBinding:
      position: 102
      prefix: --cols
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: bcolz_index
    type: Directory
    doc: The bcolz index directory (<db>.gts) written beside the database
    outputBinding:
      glob: $(inputs.db.basename).gts
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.db)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gemini:0.30.2--py27hacb5245_0
stdout: gemini_bcolz_index.out
