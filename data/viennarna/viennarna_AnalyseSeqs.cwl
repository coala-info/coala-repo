cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - AnalyseSeqs
label: viennarna_AnalyseSeqs
doc: |-
  Analyse a set of sequences of common length. Reads sequences from standard input and runs statistical geometry, split decomposition, neighbour joining and Ward's method on them.

  Tool homepage: https://www.tbi.univie.ac.at/RNA/
inputs:
  - id: sequences
    type: File
    doc: Sequences of common length, one per line, ended by the separator character @ or %.
  - id: methods
    type:
      - 'null'
      - string
    doc: 'Analysis methods: any of b (statistical geometry, default), s (split decomposition), w (Ward''s
      method) and n (neighbour joining).'
    inputBinding:
      position: 1
      prefix: -X
      separate: false
  - id: quadruples
    type:
      - 'null'
      - boolean
    doc: Statistical geometry on four data sets (for example to test a proposed phylogeny); the -X option
      is then ignored.
    inputBinding:
      position: 2
      prefix: -Q
  - id: mask
    type:
      - 'null'
      - string
    doc: 'Mask (alphabet) for the input: a predefined letter (a, u, l, c, n, R, D, A, S) or % followed
      by the accepted characters; a trailing + makes it case sensitive and ! converts to RY code.'
    inputBinding:
      position: 3
      prefix: -M
      separate: false
  - id: distance
    type:
      - 'null'
      - string
    doc: 'Algorithm for the distance matrix: H (Hamming), A[,cost] (alignment distance) or G[,cost1,cost2]
      (Gotoh distance).'
    inputBinding:
      position: 4
      prefix: -D
      separate: false
  - id: cost_matrix
    type:
      - 'null'
      - string
    doc: 'Edit cost matrix: S (simple, default), H (RNA structure matrix), D (Dayhoff amino acid matrix)
      or B (purine/pyrimidine only).'
    inputBinding:
      position: 5
      prefix: -d
      separate: false
outputs:
  - id: stdout
    type: stdout
    doc: Standard output of the program
  - id: ps_files
    type:
      type: array
      items: File
    doc: PostScript plots written by the program (structure plots, dot plots)
    outputBinding:
      glob:
        - '*.ps'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/viennarna:2.7.2--py310pl5321haba5358_0
stdin: $(inputs.sequences.path)
stdout: AnalyseSeqs.out
s:url: https://www.tbi.univie.ac.at/RNA/
$namespaces:
  s: https://schema.org/
