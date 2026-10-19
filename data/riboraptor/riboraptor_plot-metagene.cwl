cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - riboraptor
  - plot-metagene
label: riboraptor_plot-metagene
doc: "Plot metagene profile\n\nTool homepage: https://github.com/saketkc/riboraptor"
inputs:
  - id: counts
    type:
      - 'null'
      - File
    doc: Path to counts file (if not stdin)
    inputBinding:
      position: 101
      prefix: --counts
  - id: title
    type:
      - 'null'
      - string
    doc: Plot Title
    inputBinding:
      position: 101
      prefix: --title
  - id: marker
    type:
      - 'null'
      - string
    doc: Marker (o/x) for plots
    inputBinding:
      position: 101
      prefix: --marker
  - id: color
    type:
      - 'null'
      - string
    doc: Color
    inputBinding:
      position: 101
      prefix: --color
  - id: millify_labels
    type:
      - 'null'
      - boolean
    doc: Convert labels on Y-axis to concise form?
    inputBinding:
      position: 101
      prefix: --millify_labels
  - id: identify_peak
    type:
      - 'null'
      - boolean
    doc: Identify Peak?
    inputBinding:
      position: 101
      prefix: --identify_peak
  - id: positions
    type:
      - 'null'
      - string
    doc: Range of positions to plot
    inputBinding:
      position: 101
      prefix: --positions
  - id: ylabel
    type:
      - 'null'
      - string
    doc: Y axix label
    inputBinding:
      position: 101
      prefix: --ylabel
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
stdout: riboraptor_plot-metagene.out
