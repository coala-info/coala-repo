cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - fastaq
  - fasta_to_fastq
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
  - id: fastq_out
    type: string
    doc: Name of output FASTQ file
    inputBinding:
      position: 3
outputs:
  - id: out_fastq_out
    type: File
    doc: Name of output FASTQ file
    outputBinding:
      glob: $(inputs.fastq_out)
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/fastaq:v3.17.0-2-deb_cv1
