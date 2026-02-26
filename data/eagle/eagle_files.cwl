cwlVersion: v1.2
class: CommandLineTool
baseCommand: eagle
label: eagle_files
doc: "A command-line tool with subcommands for various operations.\n\nTool homepage:
  https://bitbucket.org/christopherschroeder/eagle"
inputs:
  - id: command
    type: string
    doc: The subcommand to execute. Choose from 'interface', 'convert', 'meta', 
      'extract'.
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/eagle:0.9.4.6--pyh5ca1d4c_0
stdout: eagle_files.out
