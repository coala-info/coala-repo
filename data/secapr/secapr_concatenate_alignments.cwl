cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - secapr
  - concatenate_alignments
label: secapr_concatenate_alignments
doc: "Concatenate mutliple alignments (MSAs) into one supermatrix\n\nTool homepage:
  https://github.com/AntonelliLab/seqcap_processor"
inputs:
  - id: input
    type: Directory
    doc: The directory containing the fasta-alignment-files
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
