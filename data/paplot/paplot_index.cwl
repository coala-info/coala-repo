cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - paplot
  - index
label: paplot_index
doc: "Generate index for paplot output\n\nTool homepage: https://github.com/Genomon-Project/paplot.git"
inputs:
  - id: output_dir
    type: Directory
    doc: output file path (an existing paplot report directory; the index is
      rewritten in a writable copy)
    inputBinding:
      position: 1
      valueFrom: $(self.basename)
  - id: config_file
    type:
      - 'null'
      - File
    doc: config file
    inputBinding:
      position: 101
      prefix: --config_file
  - id: remarks
    type:
      - 'null'
      - string
    doc: optional text
    inputBinding:
      position: 101
      prefix: --remarks
outputs:
  - id: out_output_dir
    type: Directory
    doc: output file path
    outputBinding:
      glob: '$(inputs.output_dir.basename)'
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.output_dir)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/paplot:0.5.6--pyh5e36f6f_0
