cwlVersion: v1.2
class: CommandLineTool
baseCommand: straitrazor_batchCstr8.bash
label: straitrazor_batchCstr8.bash
doc: "The provided text is a container build error log and does not contain help documentation
  or usage instructions for the tool.\n\nTool homepage: https://github.com/Ahhgust/STRaitRazor"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/straitrazor:3.0.1--h9948957_7
stdout: straitrazor_batchCstr8.bash.out
