cwlVersion: v1.2
class: CommandLineTool
baseCommand: rustybam paf-to-sam
label: rustybam_paf-to-sam
doc: "Convert a PAF file into a SAM file. Warning, all alignments will be marked as
  primary!\n\nTool homepage: https://github.com/mrvollger/rustybam"
inputs:
  - id: paf_file
    type:
      - 'null'
      - File
    doc: PAF file from minimap2 or unimap. Must have a CIGAR tag
    default: '-'
    inputBinding:
      position: 1
  - id: fasta_file
    type:
      - 'null'
      - File
    doc: Optional query fasta file (with index) to populate the query seq field
    inputBinding:
      position: 102
      prefix: --fasta
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rustybam:0.1.34--hf24ce72_0
stdout: rustybam_paf-to-sam.out
