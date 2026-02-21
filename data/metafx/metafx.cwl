cwlVersion: v1.2
class: CommandLineTool
baseCommand: metafx
label: metafx
doc: "A tool for metagenomic functional analysis (Note: The provided text contains
  container runtime error logs rather than the tool's help documentation).\n\nTool
  homepage: https://github.com/ctlab/metafx"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/metafx:1.1.0--hdfd78af_0
stdout: metafx.out
