cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - tf_result_explanations
label: dastk_tf_result_explanations
doc: "The provided text does not contain help information or usage instructions for
  the tool. It appears to be a system error log regarding a failed container image
  build due to insufficient disk space.\n\nTool homepage: https://github.com/Dowell-Lab/DAStk"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dastk:1.0.1--pyh7cba7a3_0
stdout: dastk_tf_result_explanations.out
