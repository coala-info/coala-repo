cwlVersion: v1.2
class: CommandLineTool
baseCommand: binchicken
label: binchicken
doc: "A tool for binning and metagenomic analysis (Note: The provided text contains
  container build logs and error messages rather than help documentation).\n\nTool
  homepage: https://github.com/aroneys/binchicken"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/binchicken:0.13.5--pyhdfd78af_0
stdout: binchicken.out
