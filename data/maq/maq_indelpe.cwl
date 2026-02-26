cwlVersion: v1.2
class: CommandLineTool
baseCommand: maq indelpe
label: maq_indelpe
doc: "Estimate indel polymorphism rate\n\nTool homepage: https://github.com/maqetta/maqetta"
inputs:
  - id: input_reference_bfa
    type: File
    doc: Input reference BFA file
    inputBinding:
      position: 1
  - id: input_alignment_map
    type: File
    doc: Input alignment MAP file
    inputBinding:
      position: 2
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/maq:v0.7.1-8-deb_cv1
stdout: maq_indelpe.out
