cwlVersion: v1.2
class: CommandLineTool
baseCommand: chainToAxt
label: ucsc-chaintoaxt_chainToAxt
doc: "Convert from chain to axt file\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs:
  - id: input_chain
    type: File
    doc: Input chain file
    inputBinding:
      position: 1
  - id: target_nib_dir_or_2bit
    type: string
    doc: Target nib directory or 2bit file
    inputBinding:
      position: 2
  - id: query_nib_dir_or_2bit
    type: string
    doc: Query nib directory or 2bit file
    inputBinding:
      position: 3
  - id: max_chain
    type:
      - 'null'
      - int
    doc: maximum chain size allowed without breaking
    inputBinding:
      position: 104
      prefix: -maxChain
  - id: max_gap
    type:
      - 'null'
      - int
    doc: maximum gap sized allowed without breaking
    inputBinding:
      position: 104
      prefix: -maxGap
  - id: min_id
    type:
      - 'null'
      - string
    doc: minimum percentage ID within blocks
    inputBinding:
      position: 104
      prefix: -minId
  - id: min_score
    type:
      - 'null'
      - string
    doc: minimum score of chain
    inputBinding:
      position: 104
      prefix: -minScore
  - id: output_bed
    type:
      - 'null'
      - boolean
    doc: Output bed instead of axt
    inputBinding:
      position: 104
      prefix: -bed
outputs:
  - id: output_axt
    type: File
    doc: Output axt file
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-chaintoaxt:482--h0b57e2e_0
