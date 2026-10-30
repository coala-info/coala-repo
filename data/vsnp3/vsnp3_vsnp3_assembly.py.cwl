cwlVersion: v1.2
class: CommandLineTool
baseCommand: vsnp3_assembly.py
label: vsnp3_vsnp3_assembly.py
doc: "Wrapper script for SPAdes assembly. Writes the assembly FASTA and an Excel statistics\
  \ summary.\n\nTool homepage: https://github.com/USDA-VS/vsnp3"
inputs:
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
  - id: fasta
    type:
      - 'null'
      - File
    doc: provide assembly if just stats are needed. Assumed SPAdes assembly
    inputBinding:
      position: 101
      prefix: -f
  - id: debug
    type:
      - 'null'
      - boolean
    doc: keep temp file
    inputBinding:
      position: 101
      prefix: -d
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: assembly_fasta
    type:
      type: array
      items: File
    doc: Assembly FASTA
    outputBinding:
      glob: '*.fasta'
  - id: stats
    type: File
    doc: Statistics workbook
    outputBinding:
      glob: '*_stats.xlsx'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vsnp3:3.33--hdfd78af_0
stdout: vsnp3_vsnp3_assembly.py.stdout.txt
