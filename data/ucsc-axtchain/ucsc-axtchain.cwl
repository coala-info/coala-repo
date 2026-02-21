cwlVersion: v1.2
class: CommandLineTool
baseCommand: axtChain
label: ucsc-axtchain
doc: "Chain together axt alignments. The tool takes axt format alignments and produces
  chains, which are sets of alignments that are linked together by gaps.\n\nTool homepage:
  https://hgdownload.cse.ucsc.edu/admin/exe"
inputs:
  - id: input_axt
    type: File
    doc: Input alignment file in .axt format
    inputBinding:
      position: 1
  - id: target_2bit
    type: File
    doc: Target sequence file in .2bit format
    inputBinding:
      position: 2
  - id: query_2bit
    type: File
    doc: Query sequence file in .2bit format
    inputBinding:
      position: 3
  - id: linear_gap
    type:
      - 'null'
      - File
    doc: Specify a linear gap file
    inputBinding:
      position: 104
      prefix: -linearGap
  - id: min_score
    type:
      - 'null'
      - int
    doc: Minimum score to output
    default: 1000
    inputBinding:
      position: 104
      prefix: -minScore
  - id: psl
    type:
      - 'null'
      - boolean
    doc: Input is psl format
    inputBinding:
      position: 104
      prefix: -psl
  - id: score_scheme
    type:
      - 'null'
      - File
    doc: Read the scoring matrix from a file
    inputBinding:
      position: 104
      prefix: -scoreScheme
  - id: verbose
    type:
      - 'null'
      - int
    doc: Set verbosity level
    default: 1
    inputBinding:
      position: 104
      prefix: -verbose
outputs:
  - id: output_chain
    type: File
    doc: Output chain file
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-axtchain:482--h0b57e2e_2
