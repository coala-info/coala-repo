cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - metabuli
  - validatedb
label: metabuli_validatedb
doc: "Validate a database: checks that all required files are present and that the k-mer count is consistent.\n\nTool homepage: https://github.com/steineggerlab/Metabuli"
requirements:
  - class: InlineJavascriptRequirement
inputs:
  - id: database_directory
    type: Directory
    doc: "Database directory"
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/metabuli:1.1.1--pl5321h0bb26bb_0
stdout: metabuli_validatedb.out
