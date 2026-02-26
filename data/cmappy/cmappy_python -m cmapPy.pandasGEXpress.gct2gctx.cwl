cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - python
  - -m
  - cmapPy.pandasGEXpress.gct2gctx
label: cmappy_python -m cmapPy.pandasGEXpress.gct2gctx
doc: "Command-line script to convert a .gct file to .gctx. Main method takes in a
  .gct file path (and, optionally, an out path and/or name to which to save the equivalent
  .gctx) and saves the enclosed content to a .gctx file. Note: Only supports v1.3
  .gct files.\n\nTool homepage: https://github.com/cmap/cmapPy"
inputs:
  - id: col_annot_path
    type:
      - 'null'
      - File
    doc: Path to annotations file for columns
    inputBinding:
      position: 101
      prefix: -col_annot_path
  - id: filename
    type: File
    doc: .gct file that you would like to convert to .gctx
    inputBinding:
      position: 101
      prefix: -filename
  - id: row_annot_path
    type:
      - 'null'
      - File
    doc: Path to annotations file for rows
    inputBinding:
      position: 101
      prefix: -row_annot_path
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Whether to print a bunch of output.
    default: false
    inputBinding:
      position: 101
      prefix: -verbose
outputs:
  - id: output_filepath
    type:
      - 'null'
      - File
    doc: out path/name for output gctx file. Default is just to modify the 
      extension
    outputBinding:
      glob: $(inputs.output_filepath)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cmappy:4.0.1--py39h2de1943_8
