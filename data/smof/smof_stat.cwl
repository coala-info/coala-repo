cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - smof
  - stat
label: smof_stat
doc: "Calculate sequence statistics (counts, length summary, N50).\n\nTool homepage: https://github.com/incertae-sedis/smof"
inputs:
  - id: delimiter
    type:
      - 'null'
      - string
    doc: "Output delimiter"
    inputBinding:
      position: 100
      prefix: --delimiter
  - id: byseq
    type:
      - 'null'
      - boolean
    doc: "Write a line for each sequence"
    inputBinding:
      position: 101
      prefix: --byseq
  - id: case_sensitive
    type:
      - 'null'
      - boolean
    doc: "Match case"
    inputBinding:
      position: 102
      prefix: --case-sensitive
  - id: count_lower
    type:
      - 'null'
      - boolean
    doc: "Count the number of lowercase characters"
    inputBinding:
      position: 103
      prefix: --count-lower
  - id: counts
    type:
      - 'null'
      - boolean
    doc: "Write counts of all characters"
    inputBinding:
      position: 104
      prefix: --counts
  - id: type
    type:
      - 'null'
      - boolean
    doc: "Guess sequence type"
    inputBinding:
      position: 105
      prefix: --type
  - id: length
    type:
      - 'null'
      - boolean
    doc: "Write sequence length"
    inputBinding:
      position: 106
      prefix: --length
  - id: proportion
    type:
      - 'null'
      - boolean
    doc: "Write proportion of each character"
    inputBinding:
      position: 107
      prefix: --proportion
  - id: aa_profile
    type:
      - 'null'
      - boolean
    doc: "Display protein profile"
    inputBinding:
      position: 108
      prefix: --aa-profile
  - id: hist
    type:
      - 'null'
      - boolean
    doc: "Write ascii histogram of sequence lengths"
    inputBinding:
      position: 109
      prefix: --hist
  - id: log_hist
    type:
      - 'null'
      - boolean
    doc: "Write ascii histogram of sequence log2 lengths"
    inputBinding:
      position: 110
      prefix: --log-hist
  - id: input_file
    type: File
    doc: "Input FASTA file (smof reads standard input by default)"
    inputBinding:
      position: 200
outputs:
  - id: stdout
    type: stdout
    doc: "Standard output"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/smof:2.22.4--pyhdfd78af_0
stdout: smof_stat.out
