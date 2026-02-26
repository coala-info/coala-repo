cwlVersion: v1.2
class: CommandLineTool
baseCommand: ribotricer orfs-seq
label: ribotricer_orfs-seq
doc: "Generate sequence for ORFs in ribotricer's index\n\nTool homepage: https://github.com/smithlabcode/ribotricer"
inputs:
  - id: fasta
    type: string
    doc: Path to FASTA file
    inputBinding:
      position: 101
      prefix: --fasta
  - id: protein
    type:
      - 'null'
      - boolean
    doc: Output protein sequence instead of nucleotide
    inputBinding:
      position: 101
      prefix: --protein
  - id: ribotricer_index
    type: string
    doc: "Path to the index file of ribotricer This file\n                       \
      \    should be generated using ribotricer prepare-orfs"
    inputBinding:
      position: 101
      prefix: --ribotricer_index
outputs:
  - id: saveto
    type: File
    doc: Path to output file
    outputBinding:
      glob: $(inputs.saveto)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ribotricer:1.5.0--pyhdfd78af_0
