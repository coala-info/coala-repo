cwlVersion: v1.2
class: CommandLineTool
baseCommand: deepgoplus
label: deepgoplus
doc: "DeepGOPlus: Protein function prediction tool. (Note: The provided help text
  contains only system error logs regarding container image building and does not
  list specific command-line arguments.)\n\nTool homepage: https://github.com/bio-ontology-research-group/deepgoplus"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/deepgoplus:v1.0.0_cv1
stdout: deepgoplus.out
