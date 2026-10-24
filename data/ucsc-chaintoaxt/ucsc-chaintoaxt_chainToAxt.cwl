cwlVersion: v1.2
class: CommandLineTool
baseCommand: chainToAxt
label: ucsc-chaintoaxt_chainToAxt
doc: "Convert from chain to axt file.\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs:
  - id: in_chain
    type: File
    doc: Input chain file
    inputBinding:
      position: 1
  - id: target_2bit
    type: File
    doc: Target sequence in 2bit format
    inputBinding:
      position: 2
  - id: query_2bit
    type: File
    doc: Query sequence in 2bit format
    inputBinding:
      position: 3
  - id: out_axt
    type: string
    doc: Name of the output axt file (a bed file when bed is set)
    inputBinding:
      position: 4
  - id: max_gap
    type: ['null', int]
    doc: Maximum gap size allowed without breaking, default 100
    inputBinding:
      position: 0
      prefix: -maxGap=
      separate: false
  - id: max_chain
    type: ['null', int]
    doc: Maximum chain size allowed without breaking, default 2147483647
    inputBinding:
      position: 0
      prefix: -maxChain=
      separate: false
  - id: min_score
    type: ['null', int]
    doc: Minimum score of chain
    inputBinding:
      position: 0
      prefix: -minScore=
      separate: false
  - id: min_id
    type: ['null', int]
    doc: Minimum percentage ID within blocks
    inputBinding:
      position: 0
      prefix: -minId=
      separate: false
  - id: bed
    type: ['null', boolean]
    doc: Output bed instead of axt
    inputBinding:
      position: 0
      prefix: -bed
outputs:
  - id: output_axt
    type: File
    doc: Output axt file (or bed file when bed is set)
    outputBinding:
      glob: $(inputs.out_axt)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-chaintoaxt:482--h0b57e2e_0
