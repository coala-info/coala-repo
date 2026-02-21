cwlVersion: v1.2
class: CommandLineTool
baseCommand: mlrho
label: mlrho
doc: "The provided text does not contain help information for mlrho; it contains a
  system error message regarding a container build failure (no space left on device).\n
  \nTool homepage: http://guanine.evolbio.mpg.de/mlRho/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mlrho:2.9--h2d4b398_9
stdout: mlrho.out
