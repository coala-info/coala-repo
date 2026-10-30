cwlVersion: v1.2
class: CommandLineTool
baseCommand: vsnp3_fastq_stats_seqkit.py
label: vsnp3_vsnp3_fastq_stats_seqkit.py
doc: "Calculate FASTQ statistics with seqkit and write an Excel summary.\n\nTool homepage:\
  \ https://github.com/USDA-VS/vsnp3"
inputs:
  - id: sample_name
    type:
      - 'null'
      - string
    doc: Force output files to this sample name
    inputBinding:
      position: 101
      prefix: -n
  - id: read1
    type:
      - 'null'
      - File
    doc: 'Required: single read, R1 when Illumina read'
    inputBinding:
      position: 101
      prefix: -r1
  - id: read2
    type:
      - 'null'
      - File
    doc: 'Optional: R2 Illumina read'
    inputBinding:
      position: 101
      prefix: -r2
  - id: debug
    type:
      - 'null'
      - boolean
    doc: keep temp files
    inputBinding:
      position: 101
      prefix: -d
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: stats
    type: File
    doc: Statistics workbook
    outputBinding:
      glob: '*_stats.xlsx'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vsnp3:3.33--hdfd78af_0
stdout: vsnp3_vsnp3_fastq_stats_seqkit.py.stdout.txt
