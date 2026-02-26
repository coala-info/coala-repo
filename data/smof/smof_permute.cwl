cwlVersion: v1.2
class: CommandLineTool
baseCommand: smof_permute
label: smof_permute
doc: "Randomly order letters in each sequence. The --word-size option allows random
  ordering of words of the given size. The --start-offset and --end-offset options
  are useful if, for example, you want to rearrange the letters within a coding sequence
  but want to preserve the start and stop codons.\n\nTool homepage: https://github.com/incertae-sedis/smof"
inputs:
  - id: input
    type:
      - 'null'
      - File
    doc: input fasta sequence (default = stdin)
    default: stdin
    inputBinding:
      position: 1
  - id: end_offset
    type:
      - 'null'
      - int
    doc: number of letters to ignore at end (default=0)
    default: 0
    inputBinding:
      position: 102
      prefix: --end-offset
  - id: seed
    type:
      - 'null'
      - string
    doc: set random seed (for reproducibility/debugging)
    inputBinding:
      position: 102
      prefix: --seed
  - id: start_offset
    type:
      - 'null'
      - int
    doc: number of letters to ignore at beginning (default=0)
    default: 0
    inputBinding:
      position: 102
      prefix: --start-offset
  - id: word_size
    type:
      - 'null'
      - int
    doc: size of each word (default=1)
    default: 1
    inputBinding:
      position: 102
      prefix: --word-size
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/smof:2.22.4--pyhdfd78af_0
stdout: smof_permute.out
