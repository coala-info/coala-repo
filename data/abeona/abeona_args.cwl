cwlVersion: v1.2
class: CommandLineTool
baseCommand: abeona
label: abeona_args
doc: "A tool for genome assembly, read processing, and subgraph analysis.\n\nTool
  homepage: https://github.com/winni2k/abeona"
inputs:
  - id: sub_command
    type: string
    doc: The subcommand to execute (choose from 'assemble', 'reads', 
      'subgraphs')
    inputBinding:
      position: 1
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Enable verbose output
    inputBinding:
      position: 102
      prefix: -v
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/abeona:0.45.0--py36_0
stdout: abeona_args.out
