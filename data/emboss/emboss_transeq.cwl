cwlVersion: v1.2
class: CommandLineTool
baseCommand: transeq
label: emboss_transeq
doc: "Reads one or more nucleotide sequences and writes the corresponding protein
  translations.\n\nTool homepage: http://emboss.open-bio.org/"
inputs:
  - id: sequence
    type: File
    doc: Nucleotide sequence(s) to be translated
    inputBinding:
      position: 1
  - id: alternative
    type:
      - 'null'
      - boolean
    doc: Define frame '-1' as using the set of codons starting at the last base of
      the sequence
    inputBinding:
      position: 102
      prefix: -alternative
  - id: clean
    type:
      - 'null'
      - boolean
    doc: Change all non-amino acid characters to 'X'
    inputBinding:
      position: 102
      prefix: -clean
  - id: frame
    type:
      - 'null'
      - string
    doc: 'Frame(s) to translate. Possible values: 1, 2, 3, F (forward frames), -1,
      -2, -3, R (reverse frames), 6 (all six frames)'
    inputBinding:
      position: 102
      prefix: -frame
  - id: regions
    type:
      - 'null'
      - string
    doc: Regions to translate (e.g. 1-10, 50-100)
    inputBinding:
      position: 102
      prefix: -regions
  - id: table
    type:
      - 'null'
      - int
    doc: Code table to use (0-23)
    inputBinding:
      position: 102
      prefix: -table
  - id: trim
    type:
      - 'null'
      - boolean
    doc: Trim trailing X's and *'s
    inputBinding:
      position: 102
      prefix: -trim
outputs:
  - id: outseq
    type: File
    doc: Output sequence file
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/emboss:6.6.0--h0f19ade_14
