cwlVersion: v1.2
class: CommandLineTool
baseCommand: tantan
label: tantan
doc: "Find simple repeats in sequences\n\nTool homepage: http://cbrc3.cbrc.jp/~martin/tantan/"
inputs:
  - id: fasta_sequence_files
    type:
      type: array
      items: File
    doc: fasta-sequence-file(s)
    inputBinding:
      position: 1
  - id: gap_existence_cost
    type:
      - 'null'
      - int
    doc: gap existence cost
    inputBinding:
      position: 102
      prefix: -a
  - id: gap_extension_cost
    type:
      - 'null'
      - int
    doc: gap extension cost, 0 means no gaps (7 if -f4, else 0)
    inputBinding:
      position: 102
      prefix: -b
  - id: interpret_as_proteins
    type:
      - 'null'
      - boolean
    doc: interpret the sequences as proteins
    inputBinding:
      position: 102
      prefix: -p
  - id: masking_char
    type:
      - 'null'
      - string
    doc: letter to use for masking, instead of lowercase
    inputBinding:
      position: 102
      prefix: -x
  - id: match_score
    type:
      - 'null'
      - int
    doc: match score (BLOSUM62 if -p, else 2 if -f4, else 1)
    inputBinding:
      position: 102
      prefix: -i
  - id: max_tandem_repeat_period
    type:
      - 'null'
      - int
    doc: maximum tandem repeat period to consider (100, but -p selects 50)
    inputBinding:
      position: 102
      prefix: -w
  - id: min_copy_number
    type:
      - 'null'
      - int
    doc: minimum copy number, affects -f4 only
    inputBinding:
      position: 102
      prefix: -n
  - id: min_repeat_probability
    type:
      - 'null'
      - float
    doc: minimum repeat probability for masking
    inputBinding:
      position: 102
      prefix: -s
  - id: mismatch_cost
    type:
      - 'null'
      - int
    doc: mismatch cost, 0 means infinite (BLOSUM62 if -p, else 7 if -f4, else 1)
    inputBinding:
      position: 102
      prefix: -j
  - id: output_type
    type:
      - 'null'
      - int
    doc: 'output type: 0=masked sequence, 1=repeat probabilities, 2=repeat counts,
      3=BED, 4=tandem repeats'
    inputBinding:
      position: 102
      prefix: -f
  - id: period_decay_probability
    type:
      - 'null'
      - float
    doc: probability decay per period
    inputBinding:
      position: 102
      prefix: -d
  - id: preserve_case
    type:
      - 'null'
      - boolean
    doc: preserve uppercase/lowercase in non-masked regions
    inputBinding:
      position: 102
      prefix: -c
  - id: repeat_end_probability
    type:
      - 'null'
      - float
    doc: probability of a repeat ending per position
    inputBinding:
      position: 102
      prefix: -e
  - id: repeat_start_probability
    type:
      - 'null'
      - float
    doc: probability of a repeat starting per position
    inputBinding:
      position: 102
      prefix: -r
  - id: score_matrix_file
    type:
      - 'null'
      - File
    doc: file for letter-pair score matrix
    inputBinding:
      position: 102
      prefix: -m
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tantan:51--h5ca1c30_1
stdout: tantan.out
