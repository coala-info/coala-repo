cwlVersion: v1.2
class: CommandLineTool
baseCommand: smof_reverse
label: smof_reverse
doc: "Reverse the letters in each sequence. The complement is NOT taken unless the
  -c flag is set. The extended nucleotide alphabet is supported.\n\nTool homepage:
  https://github.com/incertae-sedis/smof"
inputs:
  - id: input
    type:
      - 'null'
      - File
    doc: input fasta sequence
    inputBinding:
      position: 1
  - id: complement
    type:
      - 'null'
      - boolean
    doc: take the reverse complement of the sequence
    inputBinding:
      position: 102
      prefix: --complement
  - id: force_color
    type:
      - 'null'
      - boolean
    doc: print in color even to non-tty (DANGEROUS)
    inputBinding:
      position: 102
      prefix: --force-color
  - id: no_validate
    type:
      - 'null'
      - boolean
    doc: do not check whether the sequence is DNA before reverse complement
    inputBinding:
      position: 102
      prefix: --no-validate
  - id: preserve_color
    type:
      - 'null'
      - boolean
    doc: Preserve incoming color
    inputBinding:
      position: 102
      prefix: --preserve-color
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/smof:2.22.4--pyhdfd78af_0
stdout: smof_reverse.out
