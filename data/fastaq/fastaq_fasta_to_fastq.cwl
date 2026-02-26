cwlVersion: v1.2
class: CommandLineTool
baseCommand: fastaq fasta_to_fastq
label: fastaq_fasta_to_fastq
doc: "Convert FASTA and .qual to FASTQ\n\nTool homepage: https://github.com/sanger-pathogens/Fastaq"
inputs:
  - id: fasta_in
    type: File
    doc: Name of input FASTA file
    inputBinding:
      position: 1
  - id: qual_in
    type: File
    doc: Name of input quality scores file
    inputBinding:
      position: 2
outputs:
  - id: fastq_out
    type: File
    doc: Name of output FASTQ file
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/fastaq:v3.17.0-2-deb_cv1
