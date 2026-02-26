cwlVersion: v1.2
class: CommandLineTool
baseCommand: secapr join_exons
label: secapr_join_exons
doc: "Join exon-alignment files belonging to the same gene\n\nTool homepage: https://github.com/AntonelliLab/seqcap_processor"
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
    doc: The output directory where results will be saved
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/secapr:2.2.8--pyh5e36f6f_0
