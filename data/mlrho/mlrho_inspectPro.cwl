cwlVersion: v1.2
class: CommandLineTool
baseCommand: mlrho_inspectPro
label: mlrho_inspectPro
doc: "The provided text does not contain help information or a description of the
  tool, as it consists of system error messages related to container image building.\n
  \nTool homepage: http://guanine.evolbio.mpg.de/mlRho/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mlrho:2.9--h2d4b398_9
stdout: mlrho_inspectPro.out
