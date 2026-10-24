cwlVersion: v1.2
class: CommandLineTool
baseCommand: faToTab
label: ucsc-fatotab
doc: "Convert fa file to tab separated file.\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs:
  - id: input_fasta
    type: File
    doc: Input FASTA file
    inputBinding:
      position: 1
  - id: output_name
    type: string
    doc: Name of the output tab-separated file
    inputBinding:
      position: 2
  - id: type
    type:
      - 'null'
      - string
    doc: Sequence type, dna or protein. Default is dna.
    inputBinding:
      position: 101
      prefix: -type=
      separate: false
  - id: keep_acc_suffix
    type:
      - 'null'
      - boolean
    doc: Do not strip dot version off of sequence id, keep as is
    inputBinding:
      position: 101
      prefix: -keepAccSuffix
outputs:
  - id: output_tab
    type: File
    doc: Output tab-separated file
    outputBinding:
      glob: $(inputs.output_name)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-fatotab:482--h0b57e2e_0
