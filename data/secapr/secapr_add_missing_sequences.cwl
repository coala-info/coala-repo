cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - secapr
  - add_missing_sequences
label: secapr_add_missing_sequences
doc: "This script will add dummy sequences '?' for missing taxa in each alignments,\n\
  making sure that all alignments in the input folder contain the same taxa (as\n\
  required for e.g. *BEAST)\n\nTool homepage: https://github.com/AntonelliLab/seqcap_processor"
inputs:
  - id: input
    type: Directory
    doc: The directory containing fasta alignments
    inputBinding:
      position: 101
      prefix: --input
outputs:
  - id: output
    type: Directory
    doc: The output directory where results will be safed
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/secapr:2.2.8--pyh5e36f6f_0
