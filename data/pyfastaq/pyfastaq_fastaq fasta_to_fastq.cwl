cwlVersion: v1.2
class: CommandLineTool
baseCommand: pyfastaq_fastaq
label: pyfastaq_fastaq fasta_to_fastq
doc: "Convert FASTA to FASTQ format.\n\nTool homepage: https://github.com/sanger-pathogens/Fastaq"
inputs:
  - id: input_fasta
    type: File
    doc: Input FASTA file
    inputBinding:
      position: 1
outputs:
  - id: output_fastq
    type: File
    doc: Output FASTQ file
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pyfastaq:3.18.0--pyhdfd78af_0
