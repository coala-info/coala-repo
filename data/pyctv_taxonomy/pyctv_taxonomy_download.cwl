cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pyctv.py
  - download
label: pyctv_taxonomy_download
doc: "Download the current ICTV Virus Metadata Resource (VMR) workbook.\n\nTool\
  \ homepage: https://github.com/linsalrob/pyctv"
inputs:
  - id: force
    type:
      - 'null'
      - boolean
    doc: Force an update, even if you have the newest file
    inputBinding:
      position: 1
      prefix: --force
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: verbose output
    inputBinding:
      position: 1
      prefix: --verbose
outputs:
  - id: log
    type: stdout
    doc: Messages printed on standard output.
requirements:
  - class: NetworkAccess
    networkAccess: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pyctv_taxonomy:0.25--pyhdfd78af_0
stdout: pyctv_taxonomy_download.out
