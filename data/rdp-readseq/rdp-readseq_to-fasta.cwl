cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - rdp-readseq
  - to-fasta
label: rdp-readseq_to-fasta
doc: "Convert a sequence file (genbank, embl, fasta, fastq, sff, stk) to fasta on standard output.

Tool homepage: https://github.com/rdpstaff/ReadSeq"
inputs:
  - id: input_file
    type: File
    doc: "Input sequence file"
    inputBinding:
      position: 2
  - id: mask
    type:
      - 'null'
      - string
    doc: "Mask sequence name indicating columns to drop"
    inputBinding:
      position: 1
      prefix: --mask
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/rdp-readseq:v2.0.2-6-deb_cv1
stdout: rdp-readseq_to-fasta.out
