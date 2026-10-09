cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - maq
  - cns2ref
label: maq_cns2ref
doc: "Extract the reference sequences from a CNS file\n\nTool homepage: http://maq.sourceforge.net/"
inputs:
  - id: input_cns
    type: File
    doc: Input .cns file
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/maq:v0.7.1-8-deb_cv1
stdout: maq_cns2ref.out
