cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - htseq-clip
  - createMaxCountMatrix
label: htseq-clip_createmaxcountmatrix
doc: "create R friendly matrix from `crosslink_count_position_max` column in \"count\" function output files\n\nTool homepage: https://github.com/EMBL-Hentze-group/htseq-clip"
inputs:
  - id: input_folder
    type: Directory
    doc: Folder name with output files from count function, see "htseq-clip count -h ", supports
      .gz (gzipped files)
    inputBinding:
      position: 101
      prefix: --inputFolder
  - id: prefix
    type:
      - 'null'
      - string
    doc: 'Use files only with this given file name prefix (default: None)'
    inputBinding:
      position: 101
      prefix: --prefix
  - id: postfix
    type:
      - 'null'
      - string
    doc: 'Use files only with this given file name postfix (default: None). Either "--prefix"
      or "--postfix" must be given'
    inputBinding:
      position: 101
      prefix: --postfix
  - id: verbose_level
    type:
      - 'null'
      - string
    doc: 'Allowed choices: debug, info, warn, quiet (default: info)'
    inputBinding:
      position: 101
      prefix: --verbose
  - id: output_file_path
    type: string
    doc: output file name
    inputBinding:
      position: 102
      prefix: --output
outputs:
  - id: output_file
    type: File
    doc: max count matrix (.txt[.gz])
    outputBinding:
      glob: $(inputs.output_file_path)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/htseq-clip:2.19.0b0--pyh086e186_0
  
