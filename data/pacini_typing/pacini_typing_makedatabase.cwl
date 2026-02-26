cwlVersion: v1.2
class: CommandLineTool
baseCommand: Pacini-typing makedatabase
label: pacini_typing_makedatabase
doc: "Builds a reference database for Pacini typing.\n\nTool homepage: https://github.com/RIVM-bioinformatics/Pacini-typing"
inputs:
  - id: database_name
    type: string
    doc: Specify the name of the database
    inputBinding:
      position: 101
      prefix: --database_name
  - id: database_path
    type: string
    doc: Specify the path of the database
    inputBinding:
      position: 101
      prefix: --database_path
  - id: database_type
    type: string
    doc: Specify the database type that is being used
    inputBinding:
      position: 101
      prefix: --database_type
  - id: input_file
    type: File
    doc: Input file with genes that are being used for building reference 
      database
    inputBinding:
      position: 101
      prefix: --input_file
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pacini_typing:2.0.2--pyhdfd78af_0
stdout: pacini_typing_makedatabase.out
