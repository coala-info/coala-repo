cwlVersion: v1.2
class: CommandLineTool
baseCommand: vibrant
label: vibrant
doc: "VIBRANT: Virus Identification By contig Annotation using Natural language processing
  Tracking\n\nTool homepage: https://github.com/AnantharamanLab/VIBRANT"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vibrant:1.2.1--hdfd78af_4
stdout: vibrant.out
