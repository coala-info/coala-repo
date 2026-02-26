cwlVersion: v1.2
class: CommandLineTool
baseCommand: surpyvor_fixref
label: surpyvor_fixref
doc: "Fixes reference sequences in a VCF file.\n\nTool homepage: https://github.com/wdecoster/surpyvor"
inputs:
  - id: variants
    type: File
    doc: VCF to fix
    inputBinding:
      position: 1
  - id: fasta
    type: File
    doc: fasta file
    inputBinding:
      position: 102
      prefix: --fasta
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Print out more information while running.
    inputBinding:
      position: 102
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/surpyvor:0.15.0--pyhdfd78af_0
stdout: surpyvor_fixref.out
