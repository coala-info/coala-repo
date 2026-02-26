cwlVersion: v1.2
class: CommandLineTool
baseCommand: sfs
label: sfs_Log
doc: "For more information, try '--help'.\n\nTool homepage: https://github.com/malthesr/sfs"
inputs:
  - id: command
    type: string
    doc: The command to run
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sfs:0.1.0--h9ee0642_0
stdout: sfs_Log.out
