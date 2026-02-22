cwlVersion: v1.2
class: CommandLineTool
baseCommand: atol-genome-launcher
label: atol-genome-launcher
doc: "A tool for launching genome-related analysis (Note: The provided text contains
  only system error logs and no usage information or argument definitions).\n\nTool
  homepage: https://github.com/TomHarrop/atol-genome-launcher"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/atol-genome-launcher:0.2.1--pyhdfd78af_0
stdout: atol-genome-launcher.out
