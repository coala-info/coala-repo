cwlVersion: v1.2
class: CommandLineTool
baseCommand: deconveil
label: deconveil
doc: "Deconveil is a tool designed for detecting and removing contamination in viral
  genomes. (Note: The provided text is a system error log and does not contain specific
  argument definitions.)\n\nTool homepage: https://github.com/caravagnalab/DeConveil"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/deconveil:0.1.4--pyhdfd78af_0
stdout: deconveil.out
