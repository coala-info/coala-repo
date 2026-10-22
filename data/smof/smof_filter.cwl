cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - smof
  - filter
label: smof_filter
doc: "Print entries that meet the given length and composition conditions.\n\nTool homepage: https://github.com/incertae-sedis/smof"
inputs:
  - id: shorter_than
    type:
      - 'null'
      - int
    doc: "Keep only if length is less than or equal to LEN"
    inputBinding:
      position: 100
      prefix: --shorter-than
  - id: longer_than
    type:
      - 'null'
      - int
    doc: "Keep only if length is greater than or equal to LEN"
    inputBinding:
      position: 101
      prefix: --longer-than
  - id: composition
    type:
      - 'null'
      - string
    doc: "Keep only if composition meets the condition (e.g. 'GC > .5')"
    inputBinding:
      position: 102
      prefix: --composition
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
stdout: smof_filter.out
