cwlVersion: v1.2
class: CommandLineTool
baseCommand: deepgoplus_uni2pandas.py
label: deepgoplus_uni2pandas.py
doc: "A tool for converting UniProt data to Pandas format for DeepGOPlus. (Note: The
  provided help text contains only system error messages and does not list specific
  arguments.)\n\nTool homepage: https://github.com/bio-ontology-research-group/deepgoplus"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/deepgoplus:v1.0.0_cv1
stdout: deepgoplus_uni2pandas.py.out
