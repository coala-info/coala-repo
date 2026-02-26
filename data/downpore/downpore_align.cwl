cwlVersion: v1.2
class: CommandLineTool
baseCommand: downpore_align
label: downpore_align
doc: "Aligns sequences using dynamic time warping.\n\nTool homepage: https://github.com/jteutenberg/downpore"
inputs:
  - id: query_sequence
    type: string
    doc: The query sequence to align.
    inputBinding:
      position: 1
  - id: reference_sequence
    type: string
    doc: The reference sequence to align against.
    inputBinding:
      position: 2
  - id: gap_penalty
    type:
      - 'null'
      - int
    doc: Penalty for a gap.
    default: -2
    inputBinding:
      position: 103
      prefix: --gap
  - id: match_score
    type:
      - 'null'
      - int
    doc: Score for a match.
    default: 1
    inputBinding:
      position: 103
      prefix: --match
  - id: mismatch_penalty
    type:
      - 'null'
      - int
    doc: Penalty for a mismatch.
    default: -1
    inputBinding:
      position: 103
      prefix: --mismatch
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: File to write the alignment to.
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/downpore:0.3.4--h375a9b1_0
