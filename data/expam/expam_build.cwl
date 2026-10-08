cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - expam
  - build
label: expam_build
doc: "Start building database.\n\nTool homepage: https://github.com/seansolari/expam"
inputs:
  - id: database
    type: Directory
    doc: "Expam database directory (-db). It is staged writable in the work directory and returned as an output."
    inputBinding:
      position: 1
      prefix: -db
      valueFrom: $(self.basename)
  - id: sequence_dirs
    type:
      type: array
      items: Directory
    doc: "The sequence directories that were added with expam add. They are staged in the work directory under the same names, because the database stores their paths."
outputs:
  - id: database_out
    type:
      - 'null'
      - Directory
    doc: "The database directory after the command ran"
    outputBinding:
      glob: $(inputs.database.basename)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.database)
        writable: true
      - entry: $(inputs.sequence_dirs)
        writable: true
  - class: EnvVarRequirement
    envDef:
      - envName: USER
        envValue: expam
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/expam:1.4.0.7--py39hbcbf7aa_0
    dockerOutputDirectory: /w
