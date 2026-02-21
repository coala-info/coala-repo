cwlVersion: v1.2
class: CommandLineTool
baseCommand: CurveCurator
label: curve-curator_CurveCurator
doc: "The provided text does not contain help information for the tool. It appears
  to be a system error log regarding a container build failure (no space left on device).\n
  \nTool homepage: https://github.com/kusterlab/curve_curator"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/curve-curator:0.6.0--pyhdfd78af_0
stdout: curve-curator_CurveCurator.out
