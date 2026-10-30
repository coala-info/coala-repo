cwlVersion: v1.2
class: CommandLineTool
baseCommand: vsnp3_spoligotype.py
label: vsnp3_vsnp3_spoligotype.py
doc: "Find the Mycobacterium bovis spoligotype from WGS reads. Writes an Excel summary with\
  \ spacer counts, binary and octal code and SB number.\n\nTool homepage: https://github.com/USDA-VS/vsnp3"
inputs:
  - id: sample_name
    type:
      - 'null'
      - string
    doc: Force output files to this sample name
    inputBinding:
      position: 101
      prefix: -n
  - id: fastq_r1
    type: File
    doc: 'Required: single read'
    inputBinding:
      position: 101
      prefix: -r1
  - id: fastq_r2
    type:
      - 'null'
      - File
    doc: 'Optional: paired read'
    inputBinding:
      position: 101
      prefix: -r2
  - id: debug
    type:
      - 'null'
      - boolean
    doc: turn off map.pooling of samples
    inputBinding:
      position: 101
      prefix: -d
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: stats
    type: File
    doc: Statistics workbook with the spoligotype
    outputBinding:
      glob: '*_stats.xlsx'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vsnp3:3.33--hdfd78af_0
stdout: vsnp3_vsnp3_spoligotype.py.stdout.txt
