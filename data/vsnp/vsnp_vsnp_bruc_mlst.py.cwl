cwlVersion: v1.2
class: CommandLineTool
baseCommand: vsnp_bruc_mlst.py
label: vsnp_vsnp_bruc_mlst.py
doc: "Find the Brucella MLST type from reads by mapping to the ST1 MLST reference and reading\
  \ the variants.\n\nTool homepage: https://github.com/USDA-VS/vSNP"
inputs:
  - id: read1
    type: File
    doc: 'Required: single read'
    inputBinding:
      position: 101
      prefix: -r1
  - id: read2
    type:
      - 'null'
      - File
    doc: 'Optional: paired read'
    inputBinding:
      position: 101
      prefix: -r2
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: mlst
    type: Directory
    doc: Folder with mlst.txt and the MLST VCF file
    outputBinding:
      glob: mlst
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vsnp:2.03--hdfd78af_2
stdout: vsnp_vsnp_bruc_mlst.py.out
