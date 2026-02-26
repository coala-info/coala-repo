cwlVersion: v1.2
class: CommandLineTool
baseCommand: to-fasta
label: rdp-readseq_to-fasta
doc: Converts RDP readseq format to FASTA format.
inputs:
  - id: input_file
    type: File
    doc: Input RDP readseq file
    inputBinding:
      position: 1
  - id: mask
    type:
      - 'null'
      - string
    doc: Mask sequence name indicating columns to drop
    inputBinding:
      position: 102
      prefix: --mask
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/rdp-readseq:v2.0.2-6-deb_cv1
stdout: rdp-readseq_to-fasta.out
