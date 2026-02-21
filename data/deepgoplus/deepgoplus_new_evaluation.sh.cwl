cwlVersion: v1.2
class: CommandLineTool
baseCommand: deepgoplus_new_evaluation.sh
label: deepgoplus_new_evaluation.sh
doc: "A script for evaluating DeepGOPlus. Note: The provided help text contains only
  system error logs regarding container image conversion and disk space issues, and
  does not list specific command-line arguments.\n\nTool homepage: https://github.com/bio-ontology-research-group/deepgoplus"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/deepgoplus:v1.0.0_cv1
stdout: deepgoplus_new_evaluation.sh.out
