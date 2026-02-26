cwlVersion: v1.2
class: CommandLineTool
baseCommand: dr-disco integrate
label: dr-disco_integrate
doc: "Integrates gene annotation and reference sequences for fusion gene estimation
  and classification.\n\nTool homepage: https://github.com/yhoogstrate/dr-disco"
inputs:
  - id: table_input_file
    type: File
    doc: Input table file
    inputBinding:
      position: 1
  - id: fasta
    type:
      - 'null'
      - File
    doc: Use reference sequences to estimate edit distances to splice junction 
      motifs (FASTA file)
    inputBinding:
      position: 102
      prefix: --fasta
  - id: gtf
    type:
      - 'null'
      - File
    doc: Use gene annotation for estimating fusion genes and improve 
      classification of exonic (GTF file)
    inputBinding:
      position: 102
      prefix: --gtf
outputs:
  - id: table_output_file
    type: File
    doc: Output table file
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dr-disco:0.18.3--pyh086e186_0
