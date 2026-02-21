cwlVersion: v1.2
class: CommandLineTool
baseCommand: freecontact
label: freecontact
doc: "A fast protein contact predictor\n\nTool homepage: https://github.com/PhyreEngine/conda-freecontact"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/freecontact:v1.1-4-deb-py2_cv1
stdout: freecontact.out
