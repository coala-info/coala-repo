cwlVersion: v1.2
class: CommandLineTool
baseCommand: sarscov2formatter
label: sarscov2formatter
doc: "A tool for formatting SARS-CoV-2 data. (Note: The provided text appears to be
  a container runtime error log rather than help text; no arguments could be extracted.)\n
  \nTool homepage: https://github.com/nickeener/sarscov2formatter"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sarscov2formatter:1.0--pyhdfd78af_0
stdout: sarscov2formatter.out
