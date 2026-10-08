cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - htseq-clip
  - trimAnnotation
label: htseq-clip_trimannotation
doc: "trim down large annotation file based on output from 'createMatrix'\n\nTool homepage: https://github.com/EMBL-Hentze-group/htseq-clip"
inputs:
  - id: matrix
    type: File
    doc: Crosslink count matrix, output from the function 'createMatrix'
    inputBinding:
      position: 101
      prefix: --matrix
  - id: annotation
    type: File
    doc: Annotation file, output from the function 'mapToId'
    inputBinding:
      position: 101
      prefix: --annotation
  - id: no_header
    type:
      - 'null'
      - boolean
    doc: Use this flag if the first row in annotation file is not a header
    inputBinding:
      position: 101
      prefix: --no_header
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
    doc: trimmed annotations (.txt[.gz])
    outputBinding:
      glob: $(inputs.output_file_path)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/htseq-clip:2.19.0b0--pyh086e186_0
  
