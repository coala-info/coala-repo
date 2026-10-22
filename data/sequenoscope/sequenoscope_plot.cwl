cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - sequenoscope
  - plot
label: sequenoscope_plot
doc: "Generate plots based on seq manifest files\n\nTool homepage: https://github.com/phac-nml/sequenoscope"
inputs:
  - id: test_dir
    type: Directory
    doc: Path to test directory.
    inputBinding:
      position: 101
      prefix: -T
  - id: control_dir
    type: Directory
    doc: Path to control directory.
    inputBinding:
      position: 101
      prefix: -C
  - id: output_dir
    type: string
    doc: Output directory designation.
    inputBinding:
      position: 101
      prefix: -o
  - id: force
    type:
      - 'null'
      - boolean
    doc: Force overwrite of existing results directory.
    inputBinding:
      position: 101
      prefix: --force
  - id: output_prefix
    type:
      - 'null'
      - string
    doc: Output prefix added before plot names. Default is 'sample'.
    inputBinding:
      position: 101
      prefix: -op
  - id: adaptive_sampling
    type:
      - 'null'
      - boolean
    doc: Generate decision bar charts for adaptive sampling if utilized during sequencing.
    inputBinding:
      position: 101
      prefix: -AS
  - id: violin_data_percent
    type:
      - 'null'
      - float
    doc: Fraction of the data to use for the violin plot. Default=0.1.
    inputBinding:
      position: 101
      prefix: -VP
  - id: time_bin_unit
    type:
      - 'null'
      - type: enum
        symbols:
          - seconds
          - minutes
          - 5m
          - 15m
          - hours
    doc: Time bin used for decision bar charts.
    inputBinding:
      position: 101
      prefix: -bin
outputs:
  - id: output_directory
    type: Directory
    doc: Directory with the plots (HTML) and summary table.
    outputBinding:
      glob: $(inputs.output_dir)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sequenoscope:1.0.0--pyh7e72e81_1
