cwlVersion: v1.2
class: CommandLineTool
baseCommand: mlrho_ace2pro
label: mlrho_ace2pro
doc: "A utility within the mlrho package. Note: The provided text contains execution
  error logs rather than help documentation, so no arguments could be extracted.\n
  \nTool homepage: http://guanine.evolbio.mpg.de/mlRho/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mlrho:2.9--h2d4b398_9
stdout: mlrho_ace2pro.out
