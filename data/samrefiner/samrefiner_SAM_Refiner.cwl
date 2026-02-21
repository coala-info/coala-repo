cwlVersion: v1.2
class: CommandLineTool
baseCommand: SAM_Refiner
label: samrefiner_SAM_Refiner
doc: "SAM_Refiner tool (Note: The provided help text contains only container build
  logs and no usage information).\n\nTool homepage: https://github.com/degregory/SAM_Refiner"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/samrefiner:1.4.2.1--pyhdfd78af_0
stdout: samrefiner_SAM_Refiner.out
