cwlVersion: v1.2
class: CommandLineTool
baseCommand: vsnp3_fasta_to_fastq.py
label: vsnp3_vsnp3_fasta_to_fastq.py
doc: "Convert a FASTA file into paired-end FASTQ files with fake quality scores and specific\
  \ coverage.\n\nTool homepage: https://github.com/USDA-VS/vsnp3"
inputs:
  - id: input
    type: File
    doc: Input FASTA file
    inputBinding:
      position: 101
      prefix: -i
  - id: coverage
    type:
      - 'null'
      - int
    doc: 'Desired coverage (default: 100X)'
    inputBinding:
      position: 101
      prefix: -c
  - id: read_length
    type:
      - 'null'
      - int
    doc: 'Read length (default: 150)'
    inputBinding:
      position: 101
      prefix: -l
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: fastq_r1
    type: File
    doc: Simulated R1 reads
    outputBinding:
      glob: '*_R1.fastq.gz'
  - id: fastq_r2
    type: File
    doc: Simulated R2 reads
    outputBinding:
      glob: '*_R2.fastq.gz'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vsnp3:3.33--hdfd78af_0
stdout: vsnp3_vsnp3_fasta_to_fastq.py.stdout.txt
