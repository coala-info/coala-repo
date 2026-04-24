cwlVersion: v1.2
class: CommandLineTool
baseCommand: smof_translate
label: smof_translate
doc: "Translate DNA sequences to protein sequences using the standard genetic code.
  Ambiguous codons are translated as 'X'. Trailing characters are ignored. Gaps are
  removed. If --all-frames is true, the longest product is kept, with ties broken
  by position and then frame. Translation starts at the first nucleotide by default.\n\
  \nTool homepage: https://github.com/incertae-sedis/smof"
inputs:
  - id: input
    type:
      - 'null'
      - File
    doc: input fasta sequence
    inputBinding:
      position: 1
  - id: all_frames
    type:
      - 'null'
      - boolean
    doc: Translate in all frames, keep longest
    inputBinding:
      position: 102
      prefix: --all-frames
  - id: cds
    type:
      - 'null'
      - boolean
    doc: Write the DNA coding sequence
    inputBinding:
      position: 102
      prefix: --cds
  - id: from_start
    type:
      - 'null'
      - boolean
    doc: Require each product begin with a start codon
    inputBinding:
      position: 102
      prefix: --from-start
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/smof:2.22.4--pyhdfd78af_0
stdout: smof_translate.out
