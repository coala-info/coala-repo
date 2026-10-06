cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - biom
  - head
label: biom-format_head
doc: "Dump the first bit of a table.\n\nTool homepage: http://www.biom-format.org"
requirements:
  - class: InlineJavascriptRequirement
inputs:
  - id: input_fp
    type: File
    doc: The input BIOM table
    inputBinding:
      position: 101
      prefix: --input-fp
  - id: output_fp
    type:
      - 'null'
      - string
    doc: An output file-path
    inputBinding:
      position: 101
      prefix: --output-fp
  - id: n_obs
    type:
      - 'null'
      - int
    doc: The number of observations to show
    inputBinding:
      position: 101
      prefix: --n-obs
  - id: n_samp
    type:
      - 'null'
      - int
    doc: The number of samples to show
    inputBinding:
      position: 101
      prefix: --n-samp
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: output_file
    type:
      - 'null'
      - File
    doc: Output file, when output_fp is given
    outputBinding:
      glob: '$(inputs.output_fp ? inputs.output_fp : [])'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/biom-format:2.1.15
stdout: biom-format_head.out
