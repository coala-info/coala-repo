cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - renet2
  - parse_data
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
      valueFrom: $(self.path)/
  - id: in_ft_dir
    type:
      - 'null'
      - Directory
    doc: input full-text raw file dir
    inputBinding:
      position: 101
      prefix: --in_ft_dir
      valueFrom: $(self.path)/
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
    type: string
    doc: output file dir (created before the run; passed with a trailing slash)
    inputBinding:
      position: 102
      prefix: --out_dir
      valueFrom: $(self)/
outputs:
  - id: out_dir
    type: Directory
    doc: output file dir
    outputBinding:
      glob: $(inputs.out_dir_path)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entryname: $(inputs.out_dir_path)
        writable: true
        entry: '$({"class": "Directory", "listing": []})'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/renet2:1.2--py_0
