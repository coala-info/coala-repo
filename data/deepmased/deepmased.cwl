cwlVersion: v1.2
class: CommandLineTool
baseCommand: deepmased
label: deepmased
doc: "Deep learning-based Metagenomic Assembly SErrors Detector (Note: The provided
  text contains container runtime error logs rather than tool help text, so no arguments
  could be extracted).\n\nTool homepage: https://github.com/leylabmpi/DeepMAsED"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/deepmased:0.3.1--pyh5ca1d4c_0
stdout: deepmased.out
