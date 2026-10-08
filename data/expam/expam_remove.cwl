cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - expam
  - remove
label: expam_remove
doc: "Remove sequence from database (only impacts future db builds).\n\nTool homepage: https://github.com/seansolari/expam"
inputs:
  - id: database
    type: Directory
    doc: "Expam database directory (-db). It is staged writable in the work directory and returned as an output."
    inputBinding:
      position: 1
      prefix: -db
      valueFrom: $(self.basename)
  - id: directories
    type:
      type: array
      items: Directory
      inputBinding:
        prefix: -d
        valueFrom: $(self.basename)
    doc: "Directories of sequence files (-d, one flag per directory). They are staged in the work directory and recorded in the database by their path."
  - id: first
    type:
      - 'null'
      - int
    doc: "Add first n genomes in folder."
    inputBinding:
      position: 101
      prefix: --first
  - id: group
    type:
      - 'null'
      - string
    doc: "Name of the sequence group the command applies to (--group)."
    inputBinding:
      position: 101
      prefix: --group
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
      - entry: $(inputs.directories)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/expam:1.4.0.7--py39hbcbf7aa_0
    dockerOutputDirectory: /w
