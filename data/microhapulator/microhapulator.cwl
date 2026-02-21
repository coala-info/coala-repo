cwlVersion: v1.2
class: CommandLineTool
baseCommand: microhapulator
label: microhapulator
doc: "A tool for analyzing microhaplotype data (Note: The provided help text contains
  only system error messages and no usage information).\n\nTool homepage: https://github.com/bioforensics/MicroHapulator/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/microhapulator:0.8.4--pyhdfd78af_0
stdout: microhapulator.out
