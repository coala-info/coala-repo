cwlVersion: v1.2
class: CommandLineTool
baseCommand: tf_intersect
label: dastk_tf_intersect
doc: "The provided text is a container runtime error log and does not contain help
  documentation or usage instructions for dastk_tf_intersect.\n\nTool homepage: https://github.com/Dowell-Lab/DAStk"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dastk:1.0.1--pyh7cba7a3_0
stdout: dastk_tf_intersect.out
