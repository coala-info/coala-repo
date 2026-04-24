cwlVersion: v1.2
class: CommandLineTool
baseCommand: smof_stat
label: smof_stat
doc: "The default action is to count the lengths of all sequences and output summary
  statistics including: 1) the number of sequences, 2) the number of characters, 3)
  the five-number summary of sequence lengths (minimum, 25th quantile, median, 75th
  quantile, and maximum), 4) the mean and standard deviation of lengths, and 5) the
  N50 (if you don't know what that is, you don't need to know).\n\nTool homepage:
  https://github.com/incertae-sedis/smof"
inputs:
  - id: input
    type:
      - 'null'
      - File
    doc: input fasta sequence
    inputBinding:
      position: 1
  - id: aa_profile
    type:
      - 'null'
      - boolean
    doc: display protein profile
    inputBinding:
      position: 102
      prefix: --aa-profile
  - id: byseq
    type:
      - 'null'
      - boolean
    doc: write a line for each sequence
    inputBinding:
      position: 102
      prefix: --byseq
  - id: case_sensitive
    type:
      - 'null'
      - boolean
    doc: match case
    inputBinding:
      position: 102
      prefix: --case-sensitive
  - id: count_lower
    type:
      - 'null'
      - boolean
    doc: count the number of lowercase characters
    inputBinding:
      position: 102
      prefix: --count-lower
  - id: counts
    type:
      - 'null'
      - boolean
    doc: write counts of all characters
    inputBinding:
      position: 102
      prefix: --counts
  - id: delimiter
    type:
      - 'null'
      - string
    doc: output delimiter
    inputBinding:
      position: 102
      prefix: --delimiter
  - id: hist
    type:
      - 'null'
      - boolean
    doc: write ascii histogram of sequence lengths
    inputBinding:
      position: 102
      prefix: --hist
  - id: length
    type:
      - 'null'
      - boolean
    doc: write sequence length
    inputBinding:
      position: 102
      prefix: --length
  - id: log_hist
    type:
      - 'null'
      - boolean
    doc: write ascii histogram of sequence log2 lengths
    inputBinding:
      position: 102
      prefix: --log-hist
  - id: proportion
    type:
      - 'null'
      - boolean
    doc: write proportion of each character
    inputBinding:
      position: 102
      prefix: --proportion
  - id: type
    type:
      - 'null'
      - boolean
    doc: guess sequence type
    inputBinding:
      position: 102
      prefix: --type
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/smof:2.22.4--pyhdfd78af_0
stdout: smof_stat.out
