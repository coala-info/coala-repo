cwlVersion: v1.2
class: CommandLineTool
baseCommand: gof3r
label: s3gof3r_gof3r
doc: "gof3r is a command-line tool for interacting with S3.\n\nTool homepage: https://github.com/rlmcpherson/s3gof3r"
inputs:
  - id: command
    type: string
    doc: The command to execute (e.g., cp, get, put, rm)
    inputBinding:
      position: 1
  - id: manpage
    type:
      - 'null'
      - boolean
    doc: Create gof3r.man man page in current directory
    inputBinding:
      position: 102
      prefix: --manpage
  - id: writeini
    type:
      - 'null'
      - boolean
    doc: Write .gof3r.ini in current user's home directory
    inputBinding:
      position: 102
      prefix: --writeini
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/s3gof3r:0.5.0--1
stdout: s3gof3r_gof3r.out
