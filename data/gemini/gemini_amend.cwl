cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gemini
  - amend
label: gemini_amend
doc: "Amend a Gemini database.\n\nTool homepage: https://github.com/arq5x/gemini"
inputs:
  - id: db
    type: File
    doc: The name of the database to be amended.
    inputBinding:
      position: 1
      valueFrom: $(self.basename)
  - id: clear
    type:
      - 'null'
      - boolean
    doc: Set all values in this column to NULL before loading.
    inputBinding:
      position: 102
      prefix: --clear
  - id: sample
    type:
      - 'null'
      - File
    doc: New sample information file to load
    inputBinding:
      position: 102
      prefix: --sample
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: db_out
    type: File
    doc: The updated database
    outputBinding:
      glob: $(inputs.db.basename)
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.db)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gemini:0.30.2--py27hacb5245_0
stdout: gemini_amend.out
