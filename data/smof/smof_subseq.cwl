cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - smof
  - subseq
label: smof_subseq
doc: "Extract a subsequence from each entry (reverse complement if a<b is reversed).\n\nTool homepage: https://github.com/incertae-sedis/smof"
inputs:
  - id: bounds
    type:
      - 'null'
      - type: array
        items: int
    doc: "From and to values (indexed from 1)"
    inputBinding:
      position: 100
      prefix: --bounds
  - id: gff
    type:
      - 'null'
      - File
    doc: "Get bounds from this gff3 file"
    inputBinding:
      position: 101
      prefix: --gff
  - id: keep
    type:
      - 'null'
      - boolean
    doc: "With --gff, keep sequences with no matches"
    inputBinding:
      position: 102
      prefix: --keep
  - id: color
    type:
      - 'null'
      - string
    doc: "Color subsequence (do not extract)"
    inputBinding:
      position: 103
      prefix: --color
  - id: annotate
    type:
      - 'null'
      - boolean
    doc: "Append the subsequence interval to the defline"
    inputBinding:
      position: 104
      prefix: --annotate
  - id: force_color
    type:
      - 'null'
      - boolean
    doc: "Print in color even to non-tty (DANGEROUS)"
    inputBinding:
      position: 105
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
stdout: smof_subseq.out
