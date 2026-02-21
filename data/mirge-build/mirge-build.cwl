cwlVersion: v1.2
class: CommandLineTool
baseCommand: mirge-build
label: mirge-build
doc: "The provided text does not contain help information for mirge-build; it contains
  system error messages regarding a container build failure due to insufficient disk
  space.\n\nTool homepage: https://github.com/mhalushka/miRge3_build"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mirge-build:0.0.1--pyh3252c3a_0
stdout: mirge-build.out
