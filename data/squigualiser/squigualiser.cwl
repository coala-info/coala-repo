cwlVersion: v1.2
class: CommandLineTool
baseCommand: squigualiser
label: squigualiser
doc: "A tool for visualizing nanopore raw signal data (Note: The provided text contains
  build logs/errors rather than help documentation, so specific arguments could not
  be extracted).\n\nTool homepage: https://github.com/hiruna72/squigualiser"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/squigualiser:0.6.4--pyhdc42f0e_0
stdout: squigualiser.out
