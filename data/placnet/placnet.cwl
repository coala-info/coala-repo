cwlVersion: v1.2
class: CommandLineTool
baseCommand: placnet
label: placnet
doc: "PLACNET (Plasmid Reconstruction) is a tool for the reconstruction of plasmids
  from whole-genome sequencing data.\n\nTool homepage: https://github.com/LuisVielva/PLACNETw"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/placnet:v1.03-3-deb_cv1
stdout: placnet.out
