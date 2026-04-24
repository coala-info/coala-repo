cwlVersion: v1.2
class: CommandLineTool
baseCommand: ./gecko/bin/workflow.sh
label: gecko_workflow.sh
doc: "GECKO workflow for sequence comparison.\n\nTool homepage: https://github.com/otorreno/gecko"
inputs:
  - id: query_sequence
    type: File
    doc: The sequence that will be compared against the reference. Use only 
      FASTA format.
    inputBinding:
      position: 1
  - id: reference_sequence
    type: File
    doc: The reference sequence where to look for matches from the query. Note 
      that the reverse strand is computed for the reference and also matched. 
      Use only FASTA format.
    inputBinding:
      position: 2
  - id: length
    type: int
    doc: This parameter is the minimum length in nucleotides for an HSP 
      (similarity fragment) to be conserved. Any HSP below this length will be 
      filtered out of the comparison. It is recommended to use around 40 bp for 
      small organisms (e.g. bacterial mycoplasma or E. Coli) and around 100 bp 
      or more for larger organisms (e.g. human chromosomes).
    inputBinding:
      position: 3
  - id: similarity
    type: float
    doc: This parameter is analogous to the minimum length, however, instead of 
      length, the similarity is used as threshold. The similarity is calculated 
      as the score attained by an HSP divided by the maximum possible score. Use
      values above 50-60 to filter noise.
    inputBinding:
      position: 4
  - id: word_length
    type: int
    doc: This parameter is the seed size used to find HSPs. A smaller seed size 
      will increase sensitivity and decrease performance, whereas a larger seed 
      size will decrease sensitivity and increase performance. Recommended 
      values are 12 or 16 for smaller organisms (bacteria) and 32 for larger 
      organisms (chromosomes). These values must be multiples of 4.
    inputBinding:
      position: 5
  - id: constant_one
    type: int
    doc: A constant value of 1, likely for internal workflow logic.
    inputBinding:
      position: 6
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gecko:1.2--h7b50bb2_6
stdout: gecko_workflow.sh.out
