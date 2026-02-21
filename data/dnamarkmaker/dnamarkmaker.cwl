cwlVersion: v1.2
class: CommandLineTool
baseCommand: dnamarkmaker
label: dnamarkmaker
doc: "The provided text does not contain help documentation or usage instructions
  for dnamarkmaker; it contains system error logs related to a container runtime failure
  (no space left on device).\n\nTool homepage: https://github.com/SegawaTenta/DNAMarkMaker-CUI"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dnamarkmaker:1.0--pyhdfd78af_0
stdout: dnamarkmaker.out
