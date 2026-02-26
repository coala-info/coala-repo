cwlVersion: v1.2
class: CommandLineTool
baseCommand: rustybam invert
label: rustybam_invert
doc: "Invert the target and query sequences in a PAF along with the CIGAR string\n\
  \nTool homepage: https://github.com/mrvollger/rustybam"
inputs:
  - id: paf_file
    type:
      - 'null'
      - File
    doc: "PAF file from minimap2 or unimap. Must have the cg tag, and n matches will
      be zero\n             unless the cigar uses =X"
    default: '-'
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rustybam:0.1.34--hf24ce72_0
stdout: rustybam_invert.out
