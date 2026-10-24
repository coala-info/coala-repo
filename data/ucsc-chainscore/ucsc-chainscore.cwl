cwlVersion: v1.2
class: CommandLineTool
baseCommand: chainScore
label: ucsc-chainscore
doc: "Score chains.\n\nTool homepage: http://hgdownload.cse.ucsc.edu/admin/exe/"
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
    doc: Query sequence in 2bit format (a fasta file when fa_q is set)
    inputBinding:
      position: 3
  - id: out_chain
    type: string
    doc: Name of the output chain file
    inputBinding:
      position: 4
  - id: fa_q
    type: ['null', boolean]
    doc: The query file is read as a fasta file
    inputBinding:
      position: 0
      prefix: -faQ
  - id: min_score
    type: ['null', int]
    doc: Minimum score for chain, default 1000
    inputBinding:
      position: 0
      prefix: -minScore=
      separate: false
  - id: score_scheme
    type: ['null', File]
    doc: Read the scoring matrix from a blastz-format file
    inputBinding:
      position: 0
      prefix: -scoreScheme=
      separate: false
  - id: linear_gap
    type: ['null', File]
    doc: Read piecewise linear gap from a tab delimited file
    inputBinding:
      position: 0
      prefix: -linearGap=
      separate: false
outputs:
  - id: output_chain
    type: File
    doc: Output chain file with new scores
    outputBinding:
      glob: $(inputs.out_chain)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-chainscore:455--h1536b3f_1
