cwlVersion: v1.2
class: CommandLineTool
baseCommand: rustybam break-paf
label: rustybam_break-paf
doc: "Break PAF records with large indels into multiple records (useful for SafFire)\n\
  \nTool homepage: https://github.com/mrvollger/rustybam"
inputs:
  - id: paf
    type:
      - 'null'
      - File
    doc: "PAF file from minimap2 or unimap. Must have the cg tag, and n matches will
      be zero\n             unless the cigar uses =X"
    default: '-'
    inputBinding:
      position: 1
  - id: max_size
    type:
      - 'null'
      - int
    doc: Maximum indel size to keep in the paf
    default: 100
    inputBinding:
      position: 102
      prefix: --max-size
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rustybam:0.1.34--hf24ce72_0
stdout: rustybam_break-paf.out
