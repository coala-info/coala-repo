cwlVersion: v1.2
class: CommandLineTool
baseCommand: parse_data.py
label: renet2_parse_data
doc: "parse abstracts/full-text pubtator/json file to RENET2 input format\n\nTool
  homepage: https://github.com/sujunhao/RENET2"
inputs:
  - id: id_f
    type:
      - 'null'
      - File
    doc: PMID/PMCID list file input
    default: ../test/test_download_pmid_list.csv
    inputBinding:
      position: 101
      prefix: --id_f
  - id: in_abs_dir
    type:
      - 'null'
      - Directory
    doc: input abstracts raw file dir
    default: None
    inputBinding:
      position: 101
      prefix: --in_abs_dir
  - id: in_ft_dir
    type:
      - 'null'
      - Directory
    doc: input full-text raw file dir
    default: None
    inputBinding:
      position: 101
      prefix: --in_ft_dir
  - id: no_s_f
    type:
      - 'null'
      - boolean
    doc: disables generate the source session info file
    inputBinding:
      position: 101
      prefix: --no_s_f
  - id: type
    type:
      - 'null'
      - string
    doc: '[abs, ft] download text type: abstrcts or full-text'
    default: abs
    inputBinding:
      position: 101
      prefix: --type
outputs:
  - id: out_dir
    type:
      - 'null'
      - Directory
    doc: output file dir
    outputBinding:
      glob: $(inputs.out_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/renet2:1.2--py_0
