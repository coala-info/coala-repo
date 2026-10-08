cwlVersion: v1.2
class: CommandLineTool
baseCommand: workflow.sh
label: gecko_workflow.sh
doc: "GECKO (GEnome Comparison with K-mers Out-of-core): pairwise ungapped genome comparison that reports High-scoring Segment Pairs (HSPs) between a query and a reference sequence.\n\nTool homepage: https://github.com/otorreno/gecko"
inputs:
  - id: query_sequence
    type: File
    doc: "The sequence that will be compared against the reference. Use only FASTA format."
    inputBinding:
      position: 1
  - id: reference_sequence
    type: File
    doc: "The reference sequence where to look for matches from the query. Note that the reverse strand is computed for the reference and also matched. Use only FASTA format."
    inputBinding:
      position: 2
  - id: length
    type: int
    doc: "Minimum length in nucleotides for an HSP (similarity fragment) to be conserved. Use around 40 bp for small organisms and around 100 bp or more for larger organisms."
    inputBinding:
      position: 3
  - id: similarity
    type: int
    doc: "Minimum similarity: the score attained by an HSP divided by the maximum possible score, in percent. Use values above 50-60 to filter noise."
    inputBinding:
      position: 4
  - id: word_length
    type: int
    doc: "Seed size used to find HSPs. Recommended values are 12 or 16 for small organisms (bacteria) and 32 for larger organisms. These values must be multiples of 4."
    inputBinding:
      position: 5
  - id: fixed_length
    type: int
    doc: "Fixed length parameter of the workflow script; use 1 as in the documented example"
    inputBinding:
      position: 6
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: csv_output
    type: File
    doc: CSV file with the HSPs
    outputBinding:
      glob: results/*.csv
  - id: frags_output
    type: File
    doc: Binary fragments file with the HSPs (input of frags2align.sh)
    outputBinding:
      glob: results/*.frags
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gecko:1.2--h7b50bb2_6
stdout: gecko_workflow.sh.out
