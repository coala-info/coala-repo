cwlVersion: v1.2
class: CommandLineTool
baseCommand: chado
label: chado-tools_chado
doc: "Tools to access CHADO databases\n\nTool homepage: https://github.com/sanger-pathogens/chado-tools/"
inputs:
  - id: command
    type: string
    doc: The subcommand to run (connect, query, extract, insert, delete, import,
      export, execute, admin)
    inputBinding:
      position: 1
  - id: command_args
    type:
      - 'null'
      - type: array
        items: string
    doc: Arguments for the selected subcommand
    inputBinding:
      position: 2
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/chado-tools:0.2.15--py_0
stdout: chado-tools_chado.out
