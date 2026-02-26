cwlVersion: v1.2
class: CommandLineTool
baseCommand: squire
label: squire_map
doc: "A command-line tool for genomic analysis.\n\nTool homepage: https://github.com/wyang17/SQuIRE"
inputs:
  - id: command
    type: string
    doc: 'The subcommand to execute. Choose from: Build, Fetch, Clean, Map, Count,
      Call, Draw, Seek.'
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/squire:0.9.9.92--pyhdfd78af_1
stdout: squire_map.out
