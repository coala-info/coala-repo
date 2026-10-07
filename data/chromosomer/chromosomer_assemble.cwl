cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - chromosomer
  - assemble
label: chromosomer_assemble
doc: "Get the FASTA file of assembled chromosomes.\n\nTool homepage: https://github.com/gtamazian/chromosomer"
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.fragment_fasta)
        writable: true
inputs:
  - id: map
    type: File
    doc: a fragment map file
    inputBinding:
      position: 1
  - id: fragment_fasta
    type: File
    doc: a FASTA file of fragment sequences to be assembled
    inputBinding:
      position: 2
  - id: output_fasta
    type: string
    doc: the output FASTA file of the assembled chromosome sequences
    inputBinding:
      position: 3
  - id: save_soft_mask
    type:
      - 'null'
      - boolean
    doc: keep soft masking from the original fragment sequences
    inputBinding:
      position: 103
      prefix: --save_soft_mask
outputs:
  - id: out_output_fasta
    type: File
    doc: the output FASTA file of the assembled chromosome sequences
    outputBinding:
      glob: '$(inputs.output_fasta)'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/chromosomer:0.1.4a--py27_1
