cwlVersion: v1.2
class: CommandLineTool
baseCommand: deepgoplus_data.py
label: deepgoplus_deepgoplus_data.py
doc: "The provided text does not contain help information for the tool. It contains
  system log messages and a fatal error regarding container image conversion and disk
  space.\n\nTool homepage: https://github.com/bio-ontology-research-group/deepgoplus"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/deepgoplus:v1.0.0_cv1
stdout: deepgoplus_deepgoplus_data.py.out
