cwlVersion: v1.2
class: CommandLineTool
baseCommand: vsnp3_table_compare.py
label: vsnp3_vsnp3_table_compare.py
doc: "Compare two vSNP SNP tables and list the samples and positions found in only one of\
  \ them.\n\nTool homepage: https://github.com/USDA-VS/vsnp3"
inputs:
  - id: table1
    type: File
    doc: Provide a vSNP SNP Table
    inputBinding:
      position: 101
      prefix: -t1
  - id: table2
    type: File
    doc: Provide a vSNP SNP Table
    inputBinding:
      position: 101
      prefix: -t2
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: comparison
    type:
      type: array
      items: File
    doc: Comparison files
    outputBinding:
      glob:
        - '*.tab'
        - '*.xlsx'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vsnp3:3.33--hdfd78af_0
stdout: vsnp3_vsnp3_table_compare.py.stdout.txt
