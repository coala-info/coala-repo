cwlVersion: v1.2
class: CommandLineTool
baseCommand: A3Partitioner
label: A3Partitioner
doc: "Create APOBEC3 and non-APOBEC3 partitions from sequence alignments\n\nTool homepage:
  https://github.com/DaanJansen94/a3partitioner"
inputs:
  - id: input
    type: File
    doc: Input FASTA alignment file
    inputBinding:
      position: 101
      prefix: --input
  - id: partition
    type:
      - 'null'
      - string
    doc: Type of partition to create (apobec, non-apobec, both)
    inputBinding:
      position: 101
      prefix: -partition
outputs:
  - id: output
    type: File
    doc: Output FASTA file
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/a3partitioner:0.1.0--pyhdfd78af_1
