cwlVersion: v1.2
class: CommandLineTool
baseCommand: deepgoplus_update.py
label: deepgoplus_update.py
doc: "Update script for DeepGOPlus (Note: The provided text contains environment logs
  and a fatal error rather than help documentation, so no arguments could be extracted).\n
  \nTool homepage: https://github.com/bio-ontology-research-group/deepgoplus"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/deepgoplus:v1.0.0_cv1
stdout: deepgoplus_update.py.out
