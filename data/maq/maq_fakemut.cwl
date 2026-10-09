cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - maq
  - fakemut
label: maq_fakemut
doc: "Simulate references by randomly generating mutations\n\nTool homepage: http://maq.sourceforge.net/"
inputs:
  - id: input_fasta
    type: File
    doc: Input FASTA file
    inputBinding:
      position: 1
  - id: mutation_rate
    type:
      - 'null'
      - float
    doc: Rate of mutations
    inputBinding:
      position: 103
      prefix: -r
  - id: indel_fraction
    type:
      - 'null'
      - float
    doc: Fraction of 1bp indels
    inputBinding:
      position: 103
      prefix: -R
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: stderr
    type: stderr
    doc: Standard error (messages)
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/maq:v0.7.1-8-deb_cv1
stdout: maq_fakemut.out
stderr: maq_fakemut.err
