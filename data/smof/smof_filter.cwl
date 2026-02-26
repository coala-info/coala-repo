cwlVersion: v1.2
class: CommandLineTool
baseCommand: smof_filter
label: smof_filter
doc: "Prints every entry by default. You may add one or more criteria to filter the\n\
  results (e.g. `smof filter -s 200 -l 100 -c 'GC > .5'` will print only\nsequences
  between 100 and 200 resides in length and greater than 50% GC\ncontent).\n\nTool
  homepage: https://github.com/incertae-sedis/smof"
inputs:
  - id: input
    type:
      - 'null'
      - File
    doc: input fasta sequence (default = stdin)
    default: stdin
    inputBinding:
      position: 1
  - id: composition
    type:
      - 'null'
      - string
    doc: "keep only if composition meets the condition (e.g. 'GC\n               \
      \         > .5')"
    inputBinding:
      position: 102
      prefix: --composition
  - id: longer_than
    type:
      - 'null'
      - int
    doc: keep only if length is greater than or equal to LEN
    inputBinding:
      position: 102
      prefix: --longer-than
  - id: shorter_than
    type:
      - 'null'
      - int
    doc: keep only if length is less than or equal to LEN
    inputBinding:
      position: 102
      prefix: --shorter-than
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/smof:2.22.4--pyhdfd78af_0
stdout: smof_filter.out
