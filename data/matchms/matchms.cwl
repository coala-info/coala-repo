cwlVersion: v1.2
class: CommandLineTool
baseCommand: matchms
label: matchms
doc: "Matchms is a Python library for processing, filtering, and comparing mass spectrometry
  data (metadata and spectra).\n\nTool homepage: https://github.com/matchms/matchms"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/matchms:0.31.0--pyhdfd78af_0
stdout: matchms.out
