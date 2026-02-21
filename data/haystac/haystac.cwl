cwlVersion: v1.2
class: CommandLineTool
baseCommand: haystac
label: haystac
doc: "HAYSTAC (High-Accuracy Species Taxon Analysis and Classification) is a tool
  for species identification and taxon analysis.\n\nTool homepage: https://github.com/antonisdim/haystac"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/haystac:0.4.12--pyhcf36b3e_0
stdout: haystac.out
