cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - tides-ml
  - tides
label: tides-ml_tides
doc: "TIDES-ML (Note: The provided text contains container build logs rather than
  command-line help documentation, so no arguments could be extracted).\n\nTool homepage:
  https://github.com/xxmalcala/TIdeS"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tides-ml:1.3.5--pyhdfd78af_0
stdout: tides-ml_tides.out
