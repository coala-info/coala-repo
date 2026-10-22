cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - smof
  - split
label: smof_split
doc: "Break a multiple sequence FASTA file into several smaller files.\n\nTool homepage: https://github.com/incertae-sedis/smof"
inputs:
  - id: number
    type:
      - 'null'
      - int
    doc: "Number of output files or sequences per file"
    inputBinding:
      position: 100
      prefix: --number
  - id: seqs
    type:
      - 'null'
      - boolean
    doc: "Split by maximum sequences per file"
    inputBinding:
      position: 101
      prefix: --seqs
  - id: prefix
    type:
      - 'null'
      - string
    doc: "Prefix for output files (default=\"xxx\")"
    inputBinding:
      position: 102
      prefix: --prefix
  - id: input_file
    type: File
    doc: "Input FASTA file (smof reads standard input by default)"
    inputBinding:
      position: 200
outputs:
  - id: stdout
    type: stdout
    doc: "Standard output"
  - id: split_files
    type:
      type: array
      items: File
    doc: Output files, named from the prefix (default xxx)
    outputBinding:
      glob: "$(inputs.prefix ? inputs.prefix : 'xxx')*"
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/smof:2.22.4--pyhdfd78af_0
stdout: smof_split.out
