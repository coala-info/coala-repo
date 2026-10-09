cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - maq
  - fasta2bfa
label: maq_fasta2bfa
doc: "\nTool homepage: http://maq.sourceforge.net/"
inputs:
  - id: in_fasta
    type: File
    inputBinding:
      position: 1
  - id: out_bfa
    type: string
    doc: out.bfa (output path)
    inputBinding:
      position: 2
outputs:
  - id: out_out_bfa
    type: File
    outputBinding:
      glob: '$(inputs.out_bfa)'
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/maq:v0.7.1-8-deb_cv1
