cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - expam
  - fake_phylogeny
label: expam_fake_phylogeny
doc: "Generate a balanced placeholder phylogeny from the sequences added to the database and set it as the database phylogeny.\n\nTool homepage: https://github.com/seansolari/expam"
inputs:
  - id: database
    type: Directory
    doc: "Expam database directory (-db). It is staged writable in the work directory and returned as an output."
    inputBinding:
      position: 1
      prefix: -db
      valueFrom: $(self.basename)
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
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/expam:1.4.0.7--py39hbcbf7aa_0
    dockerOutputDirectory: /w
