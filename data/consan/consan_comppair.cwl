cwlVersion: v1.2
class: CommandLineTool
baseCommand: comppair
label: consan_comppair
doc: "Compare a test (predicted) pairwise structural alignment with a trusted (reference)
  one: reports the correctly predicted alignment symbols and the base-pair sensitivity
  and PPV for each sequence, each pair and in total.\n\nTool homepage: http://eddylab.org/software/consan/"
inputs:
  - id: trusted_alignment
    type: File
    doc: trusted (reference) pairwise alignments in Stockholm format, with structure
      annotation
    inputBinding:
      position: 201
  - id: test_alignment
    type: File
    doc: test (predicted) pairwise alignments in Stockholm format, in the same order
      as the trusted file (for example the output of scompare)
    inputBinding:
      position: 202
  - id: suppress_totals
    type:
      - 'null'
      - boolean
    doc: suppress comparison totals
    inputBinding:
      position: 103
      prefix: -S
  - id: suppress_alignment_output
    type:
      - 'null'
      - boolean
    doc: suppress every pair alignment prediction output
    inputBinding:
      position: 103
      prefix: -q
  - id: mathews
    type:
      - 'null'
      - int
    doc: turn on Mathews definition of paired (give 1)
    inputBinding:
      position: 103
      prefix: -M
outputs:
  - id: stdout
    type: stdout
    doc: comparison report
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/consan:1.2--h7b50bb2_7
stdout: consan_comppair.out
