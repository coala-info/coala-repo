cwlVersion: v1.2
class: CommandLineTool
baseCommand: ska
label: ska_more
doc: "Split Kmer Analysis\n\nTool homepage: https://github.com/simonrharris/SKA"
inputs:
  - id: subcommand
    type: string
    doc: Subcommand to run
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ska:1.0--h077b44d_7
stdout: ska_more.out
