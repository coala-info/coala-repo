cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - dr-disco
  - integrate
label: dr-disco_integrate
doc: "Maps junctions back together that are likely to correspond to the same fusion
  event.\n\nTool homepage: https://github.com/yhoogstrate/dr-disco"
inputs:
  - id: table_input_file
    type: File
    doc: Input table file
    inputBinding:
      position: 1
  - id: table_output_file
    type: string
    doc: Output table file
    inputBinding:
      position: 2
  - id: fasta
    type:
      - 'null'
      - File
    secondaryFiles:
      - pattern: .fai
        required: false
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
  - id: out_table_output_file
    type: File
    doc: Output table file
    outputBinding:
      glob: '$(inputs.table_output_file)'
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.fasta)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dr-disco:0.18.3--pyh086e186_0
