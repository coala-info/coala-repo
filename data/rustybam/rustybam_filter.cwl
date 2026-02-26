cwlVersion: v1.2
class: CommandLineTool
baseCommand: rustybam filter
label: rustybam_filter
doc: "Filter PAF records in various ways\n\nTool homepage: https://github.com/mrvollger/rustybam"
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
  - id: aln
    type:
      - 'null'
      - int
    doc: Minimum alignment length
    default: 0
    inputBinding:
      position: 102
      prefix: --aln
  - id: paired_len
    type:
      - 'null'
      - int
    doc: "Minimum number of aligned bases across all alignments between a\n      \
      \                               target and query in order to keep those records"
    default: 0
    inputBinding:
      position: 102
      prefix: --paired-len
  - id: query
    type:
      - 'null'
      - int
    doc: Minimum query length
    default: 0
    inputBinding:
      position: 102
      prefix: --query
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rustybam:0.1.34--hf24ce72_0
stdout: rustybam_filter.out
