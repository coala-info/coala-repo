cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - smof
  - reverse
label: smof_reverse
doc: "Reverse the letters in each sequence (optionally reverse complement).\n\nTool homepage: https://github.com/incertae-sedis/smof"
inputs:
  - id: complement
    type:
      - 'null'
      - boolean
    doc: "Take the reverse complement of the sequence"
    inputBinding:
      position: 100
      prefix: --complement
  - id: no_validate
    type:
      - 'null'
      - boolean
    doc: "Do not check whether the sequence is DNA before reverse complement"
    inputBinding:
      position: 101
      prefix: --no-validate
  - id: preserve_color
    type:
      - 'null'
      - boolean
    doc: "Preserve incoming color"
    inputBinding:
      position: 102
      prefix: --preserve-color
  - id: force_color
    type:
      - 'null'
      - boolean
    doc: "Print in color even to non-tty (DANGEROUS)"
    inputBinding:
      position: 103
      prefix: --force-color
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
stdout: smof_reverse.out
