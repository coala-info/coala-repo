cwlVersion: v1.2
class: CommandLineTool
baseCommand: bwtk
label: bwtk_help
doc: "A tool for manipulating bigWig files.\n\nTool homepage: https://github.com/bjmt/bwtk"
inputs:
  - id: subcommand
    type: string
    doc: 'The subcommand to execute. Available subcommands: bg2bw, adjust, merge,
      values, score, chroms, help, version.'
    inputBinding:
      position: 1
  - id: options
    type:
      - 'null'
      - type: array
        items: string
    doc: Options for the selected subcommand.
    inputBinding:
      position: 2
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bwtk:1.8.1--h9990f68_0
stdout: bwtk_help.out
