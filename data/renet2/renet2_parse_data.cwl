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
    inputBinding:
      position: 101
      prefix: --id_f
  - id: in_abs_dir
    type:
      - 'null'
      - Directory
    doc: input abstracts raw file dir
    inputBinding:
      position: 101
      prefix: --in_abs_dir
  - id: in_ft_dir
    type:
      - 'null'
      - Directory
    doc: input full-text raw file dir
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
    inputBinding:
      position: 101
      prefix: --type
  - id: out_dir_path
    type: Directory
    doc: Output or path parameter `out_dir_path`
    inputBinding:
      position: 102
      prefix: --out-dir
outputs:
  - id: out_dir
    type:
      - 'null'
      - Directory
    doc: output file dir
    outputBinding:
      glob: $(inputs.out_dir_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/renet2:1.2--py_0
