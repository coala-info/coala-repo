cwlVersion: v1.2
class: CommandLineTool
baseCommand: ts
label: moreutils_ts
doc: "Timestamp standard input. (Note: The provided help text contains a system error
  and does not list specific arguments.)\n\nTool homepage: https://github.com/madx/moreutils"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/moreutils:0.5.7--1
stdout: moreutils_ts.out
