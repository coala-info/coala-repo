cwlVersion: v1.2
class: CommandLineTool
baseCommand: vsnp3_best_reference_sourmash.py
label: vsnp3_vsnp3_best_reference_sourmash.py
doc: "Find the best reference genome for reads with sourmash, using the reference database\
  \ of the image.\n\nTool homepage: https://github.com/USDA-VS/vsnp3"
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
  - id: sourmash
    type: Directory
    doc: Folder with the sourmash search results
    outputBinding:
      glob: sourmash
  - id: stats
    type: File
    doc: Statistics workbook
    outputBinding:
      glob: '*_stats.xlsx'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vsnp3:3.33--hdfd78af_0
stdout: vsnp3_vsnp3_best_reference_sourmash.py.stdout.txt
