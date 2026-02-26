cwlVersion: v1.2
class: CommandLineTool
baseCommand: sketchy shared
label: sketchy_shared
doc: "Compute shared hashes between two sketches\n\nTool homepage: https://github.com/esteinig/sketchy"
inputs:
  - id: query
    type: File
    doc: 'Sketch file, matching format: Mash (.msh) or Finch (.fsh)'
    inputBinding:
      position: 101
      prefix: --query
  - id: reference
    type: File
    doc: 'Sketch file, format: Mash (.msh) or Finch (.fsh)'
    inputBinding:
      position: 101
      prefix: --reference
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sketchy:0.6.0--h7b50bb2_3
stdout: sketchy_shared.out
