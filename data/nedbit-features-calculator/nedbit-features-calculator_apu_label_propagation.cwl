cwlVersion: v1.2
class: CommandLineTool
baseCommand: nedbit-features-calculator_apu_label_propagation
label: nedbit-features-calculator_apu_label_propagation
doc: "The provided text does not contain help information for the tool, but rather
  a system error log indicating a failure to build the container image due to insufficient
  disk space ('no space left on device').\n\nTool homepage: https://github.com/AndMastro/NIAPU"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nedbit-features-calculator:1.2--h7b50bb2_2
stdout: nedbit-features-calculator_apu_label_propagation.out
