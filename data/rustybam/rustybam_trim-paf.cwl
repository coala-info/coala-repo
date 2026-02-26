cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - rustybam
  - trim-paf
label: rustybam_trim-paf
doc: "Trim PAF records that overlap in query sequence to find and optimal splitting
  point using dynamic programing.\n\nTool homepage: https://github.com/mrvollger/rustybam"
inputs:
  - id: paf_file
    type:
      - 'null'
      - File
    doc: "PAF file from minimap2 or unimap. Must have the cg tag, and n matches will
      be zero\n            unless the cigar uses =X"
    default: '-'
    inputBinding:
      position: 1
  - id: diff_score
    type:
      - 'null'
      - int
    doc: Value subtracted for a mismatching base
    default: 1
    inputBinding:
      position: 102
      prefix: --diff-score
  - id: indel_score
    type:
      - 'null'
      - int
    doc: Value subtracted for an insertion or deletion
    default: 1
    inputBinding:
      position: 102
      prefix: --indel-score
  - id: match_score
    type:
      - 'null'
      - int
    doc: Value added for a matching base
    default: 1
    inputBinding:
      position: 102
      prefix: --match-score
  - id: remove_contained
    type:
      - 'null'
      - boolean
    doc: Remove contained alignments as well as overlaps
    inputBinding:
      position: 102
      prefix: --remove-contained
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rustybam:0.1.34--hf24ce72_0
stdout: rustybam_trim-paf.out
