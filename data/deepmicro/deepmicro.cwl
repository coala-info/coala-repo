cwlVersion: v1.2
class: CommandLineTool
baseCommand: deepmicro
label: deepmicro
doc: "DeepMicro is a deep learning framework for microbiome-based classification.
  (Note: The provided help text contains only system error logs and no command-line
  argument information.)\n\nTool homepage: https://github.com/paulzierep/DeepMicro"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/deepmicro:1.4--pyhdfd78af_1
stdout: deepmicro.out
