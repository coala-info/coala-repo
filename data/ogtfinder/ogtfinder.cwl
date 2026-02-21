cwlVersion: v1.2
class: CommandLineTool
baseCommand: ogtfinder
label: ogtfinder
doc: "A tool for predicting the optimal growth temperature (OGT) of prokaryotes. Note:
  The provided input text contains container runtime error messages and does not include
  the standard help documentation or argument definitions.\n\nTool homepage: https://github.com/SC-Git1/OGTFinder"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ogtfinder:0.0.2--pyhdfd78af_0
stdout: ogtfinder.out
