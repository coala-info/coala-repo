cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - riboraptor
  - plot-read-length
label: riboraptor_plot-read-length
doc: "Plot read length distribution\n\nTool homepage: https://github.com/saketkc/riboraptor"
inputs:
  - id: read_lengths
    type:
      - 'null'
      - File
    doc: Path to read length pickle file
    inputBinding:
      position: 101
      prefix: --read-lengths
  - id: title
    type:
      - 'null'
      - string
    doc: Plot Title
    inputBinding:
      position: 101
      prefix: --title
  - id: millify_labels
    type:
      - 'null'
      - boolean
    doc: Convert labels on Y-axis to concise form?
    inputBinding:
      position: 101
      prefix: --millify_labels
  - id: ascii
    type:
      - 'null'
      - boolean
    doc: Do not plot ascii
    inputBinding:
      position: 101
      prefix: --ascii
  - id: saveto_path
    type: string
    doc: Path to file (png/pdf) to save to
    inputBinding:
      position: 102
      prefix: --saveto
outputs:
  - id: saveto
    type:
      - 'null'
      - File
    doc: Path to file (png/pdf) to save to
    outputBinding:
      glob: $(inputs.saveto_path)
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/riboraptor:0.2.2--py36_0
stdout: riboraptor_plot-read-length.out
