cwlVersion: v1.2
class: CommandLineTool
baseCommand: mgcod
label: mgcod
doc: "Metagenomic Community-based Ortholog Detection\n\nTool homepage: https://github.com/gatech-genemark/Mgcod"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mgcod:1.0.2--hdfd78af_0
stdout: mgcod.out
