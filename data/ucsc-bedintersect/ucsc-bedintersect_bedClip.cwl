cwlVersion: v1.2
class: CommandLineTool
baseCommand: bedClip
label: ucsc-bedintersect_bedClip
doc: "Remove lines from bed file that refer to nucleotides outside of a chromosome.\n\
  \nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs:
  - id: input_bed
    type: File
    doc: Input bed file to be clipped.
    inputBinding:
      position: 1
  - id: chrom_sizes
    type: File
    doc: 'Two-column file: <chromosome name> <size in bases>.'
    inputBinding:
      position: 2
  - id: verbose
    type:
      - 'null'
      - int
    doc: Set to 0 for no social prompts, 2 for more info.
    default: 1
    inputBinding:
      position: 103
      prefix: -verbose
outputs:
  - id: output_bed
    type: File
    doc: Output clipped bed file.
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-bedintersect:482--h0b57e2e_0
