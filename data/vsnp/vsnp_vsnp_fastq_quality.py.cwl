cwlVersion: v1.2
class: CommandLineTool
baseCommand: vsnp_fastq_quality.py
label: vsnp_vsnp_fastq_quality.py
doc: "Report read count, mean read length, mean quality and the share of reads passing Q30\
  \ for FASTQ files (printed to standard output).\n\nTool homepage: https://github.com/USDA-VS/vSNP"
inputs:
  - id: read1
    type: File
    doc: 'Required: single read, R1 if Illumina read'
    inputBinding:
      position: 101
      prefix: -r1
  - id: read2
    type:
      - 'null'
      - File
    doc: 'Required: R2 Illumina read'
    inputBinding:
      position: 101
      prefix: -r2
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vsnp:2.03--hdfd78af_2
stdout: vsnp_vsnp_fastq_quality.py.out
