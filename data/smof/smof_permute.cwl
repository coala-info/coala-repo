cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - smof
  - permute
label: smof_permute
doc: "Randomly order letters (or words) in each sequence.\n\nTool homepage: https://github.com/incertae-sedis/smof"
inputs:
  - id: word_size
    type:
      - 'null'
      - int
    doc: "Size of each word (default=1)"
    inputBinding:
      position: 100
      prefix: --word-size
  - id: start_offset
    type:
      - 'null'
      - int
    doc: "Number of letters to ignore at beginning (default=0)"
    inputBinding:
      position: 101
      prefix: --start-offset
  - id: end_offset
    type:
      - 'null'
      - int
    doc: "Number of letters to ignore at end (default=0)"
    inputBinding:
      position: 102
      prefix: --end-offset
  - id: seed
    type:
      - 'null'
      - string
    doc: "Set random seed (for reproducibility/debugging)"
    inputBinding:
      position: 103
      prefix: --seed
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
stdout: smof_permute.out
