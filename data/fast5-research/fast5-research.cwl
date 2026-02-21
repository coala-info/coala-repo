cwlVersion: v1.2
class: CommandLineTool
baseCommand: fast5-research
label: fast5-research
doc: "A tool for researching and manipulating FAST5 files. Note: The provided help
  text contains only system error messages regarding container execution and does
  not list specific command-line arguments.\n\nTool homepage: https://github.com/nanoporetech/fast5_research"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fast5-research:1.2.22--pyh864c0ab_0
stdout: fast5-research.out
