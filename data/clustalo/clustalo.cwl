cwlVersion: v1.2
class: CommandLineTool
baseCommand: clustalo
label: clustalo
doc: "Clustal Omega is a multiple sequence alignment program for proteins and nucleotides.\n
  \nTool homepage: http://www.clustal.org/omega/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/clustalo:v1.2.4-2-deb_cv1
stdout: clustalo.out
