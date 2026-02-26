cwlVersion: v1.2
class: CommandLineTool
baseCommand: pod5
label: pod5_inspect
doc: "Tools for inspecting, converting, subsetting and formatting POD5 files\n\nTool
  homepage: https://github.com/nanoporetech/pod5-file-format"
inputs:
  - id: subcommand
    type: string
    doc: 'Available subcommands: convert, inspect, merge, repack, subset, filter,
      recover, update, view'
    inputBinding:
      position: 1
  - id: subcommand_args
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
    dockerPull: quay.io/biocontainers/pod5:0.3.33--pyhdfd78af_0
stdout: pod5_inspect.out
