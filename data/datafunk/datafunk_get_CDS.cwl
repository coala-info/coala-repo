cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - datafunk
  - get_CDS
label: datafunk_get_CDS
doc: "Extracts CDS from alignments in Wuhan-Hu-1 coordinates\n\nTool homepage: https://github.com/cov-ert/datafunk"
inputs:
  - id: input_fasta
    type: File
    doc: Fasta file to read
    inputBinding:
      position: 101
      prefix: --input-fasta
  - id: translate
    type:
      - 'null'
      - boolean
    doc: output amino acid sequence (default is nucleotides)
    default: false
    inputBinding:
      position: 101
      prefix: --translate
outputs:
  - id: output_fasta
    type:
      - 'null'
      - File
    doc: Fasta file to write. Prints to stdout if not specified
    outputBinding:
      glob: $(inputs.output_fasta)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/datafunk:0.1.0--pyh5e36f6f_0
