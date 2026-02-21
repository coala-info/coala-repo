cwlVersion: v1.2
class: CommandLineTool
baseCommand: samrefiner
label: samrefiner
doc: "The provided text does not contain help information or usage instructions for
  samrefiner; it appears to be a log of a failed container build process.\n\nTool
  homepage: https://github.com/degregory/SAM_Refiner"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/samrefiner:1.4.2.1--pyhdfd78af_0
stdout: samrefiner.out
