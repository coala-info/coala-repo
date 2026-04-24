cwlVersion: v1.2
class: CommandLineTool
baseCommand: download_data.py
label: renet2_download_data
doc: "download abstrcts/full-text pubtator/json file from Pubtator\n\nTool homepage:
  https://github.com/sujunhao/RENET2"
inputs:
  - id: dir
    type:
      - 'null'
      - Directory
    doc: output dir
    inputBinding:
      position: 101
      prefix: --dir
  - id: id_f
    type:
      - 'null'
      - File
    doc: PMID/PMCID list file input
    inputBinding:
      position: 101
      prefix: --id_f
  - id: process_n
    type:
      - 'null'
      - int
    doc: cores number of multoprocessing
    inputBinding:
      position: 101
      prefix: --process_n
  - id: tmp_hit_f
    type:
      - 'null'
      - File
    doc: output hit id list f
    inputBinding:
      position: 101
      prefix: --tmp_hit_f
  - id: type
    type:
      - 'null'
      - string
    doc: 'download text type: abstrcts or full-text'
    inputBinding:
      position: 101
      prefix: --type
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/renet2:1.2--py_0
stdout: renet2_download_data.out
