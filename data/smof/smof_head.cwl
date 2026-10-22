cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - smof
  - head
label: smof_head
doc: "Write the first entries of a FASTA file (entry-based; one entry by default).\n\nTool homepage: https://github.com/incertae-sedis/smof"
inputs:
  - id: entries
    type:
      - 'null'
      - string
    doc: "Print first K entries; or use -n -K to print all but the last K entries"
    inputBinding:
      position: 100
      prefix: --entries
  - id: first
    type:
      - 'null'
      - int
    doc: "Print first K letters of each sequence"
    inputBinding:
      position: 101
      prefix: --first
  - id: last
    type:
      - 'null'
      - int
    doc: "Print last K letters of each sequence"
    inputBinding:
      position: 102
      prefix: --last
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
stdout: smof_head.out
