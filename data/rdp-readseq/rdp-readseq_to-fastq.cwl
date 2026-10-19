cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - rdp-readseq
  - to-fastq
label: rdp-readseq_to-fastq
doc: "Convert a fastq file, or a fasta file with a quality file, to fastq on standard output (ToFastq).

Tool homepage: https://github.com/rdpstaff/ReadSeq"
inputs:
  - id: seqfile
    type: File
    doc: "Sequence file with quality information (fastq), or a fasta file"
    inputBinding:
      position: 1
  - id: qualfile
    type:
      - 'null'
      - File
    doc: "Quality file, for a fasta input"
    inputBinding:
      position: 2
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/rdp-readseq:v2.0.2-6-deb_cv1
stdout: rdp-readseq_to-fastq.out
