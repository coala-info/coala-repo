cwlVersion: v1.2
class: CommandLineTool
baseCommand: axtChain
label: ucsc-axtchain
doc: "Chain together axt alignments. The tool takes axt (or psl) format alignments\
  \ and produces chains, which are sets of alignments that are linked together by\
  \ gaps.\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs:
  - id: input_axt
    type: File
    doc: Input alignment file in .axt format (psl format with -psl)
    inputBinding:
      position: 11
  - id: target_seq
    type: [File, Directory]
    doc: Target sequences (tNibDir) - a directory of nib files, a .2bit file, or
      a single fasta file (with -faT)
    inputBinding:
      position: 12
  - id: query_seq
    type: [File, Directory]
    doc: Query sequences (qNibDir) - a directory of nib files, a .2bit file, or
      a single fasta file (with -faQ)
    inputBinding:
      position: 13
  - id: output_chain_path
    type: string
    doc: Name of the output chain file
    inputBinding:
      position: 14
  - id: linear_gap
    type: [string, File]
    doc: Type of linearGap to use - the word loose (chicken/human costs), the word
      medium (mouse/human costs), or a piecewise linear gap table file.
    inputBinding:
      position: 1
      prefix: -linearGap=
      separate: false
      valueFrom: "$(self.class == 'File' ? self.path : self)"
  - id: min_score
    type:
      - 'null'
      - int
    doc: Minimum score for chain, default 1000
    inputBinding:
      position: 2
      prefix: -minScore=
      separate: false
  - id: psl
    type:
      - 'null'
      - boolean
    doc: Use psl instead of axt format for input
    inputBinding:
      position: 3
      prefix: -psl
  - id: fa_q
    type:
      - 'null'
      - boolean
    doc: The specified qNibDir is a fasta file with multiple sequences for query
    inputBinding:
      position: 4
      prefix: -faQ
  - id: fa_t
    type:
      - 'null'
      - boolean
    doc: The specified tNibDir is a fasta file with multiple sequences for target.
      Will not work with gzipped fasta files
    inputBinding:
      position: 5
      prefix: -faT
  - id: details_path
    type:
      - 'null'
      - string
    doc: Output some additional chain details to this file
    inputBinding:
      position: 6
      prefix: -details=
      separate: false
  - id: score_scheme
    type:
      - 'null'
      - File
    doc: Read the scoring matrix from a blastz-format file
    inputBinding:
      position: 7
      prefix: -scoreScheme=
      separate: false
outputs:
  - id: output_chain
    type: File
    doc: Output chain file
    outputBinding:
      glob: $(inputs.output_chain_path)
  - id: output_details
    type:
      - 'null'
      - File
    doc: Additional chain details
    outputBinding:
      glob: $(inputs.details_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-axtchain:482--h0b57e2e_2
