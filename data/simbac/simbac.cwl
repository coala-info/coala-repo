cwlVersion: v1.2
class: CommandLineTool
baseCommand: simbac
label: simbac
doc: "A tool for simulating bacterial evolution (Note: The provided text contains
  error logs rather than help documentation, so specific arguments could not be extracted).\n
  \nTool homepage: https://github.com/tbrown91/SimBac"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/simbac:0.1a--h5e66344_3
stdout: simbac.out
