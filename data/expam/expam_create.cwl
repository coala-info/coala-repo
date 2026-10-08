cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - expam
  - create
label: expam_create
doc: "Initialise database.\n\nTool homepage: https://github.com/seansolari/expam"
inputs:
  - id: db_name
    type: string
    doc: "Name of the new database directory (-db). It is created in the work directory."
    inputBinding:
      position: 1
      prefix: -db
outputs:
  - id: database_out
    type:
      - 'null'
      - Directory
    doc: "The new empty database directory"
    outputBinding:
      glob: $(inputs.db_name)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/expam:1.4.0.7--py39hbcbf7aa_0
    dockerOutputDirectory: /w
