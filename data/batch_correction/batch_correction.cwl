cwlVersion: v1.2
class: CommandLineTool
baseCommand: batch_correction
label: batch_correction
doc: "A tool for batch correction (Note: The provided text contains system error messages
  regarding disk space and container image retrieval rather than the tool's help documentation).\n\
  \nTool homepage: https://github.com/USTCPCS/CVPR2018_attention"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/batch_correction:phenomenal-v2.2.3_cv1.1.15
stdout: batch_correction.out
