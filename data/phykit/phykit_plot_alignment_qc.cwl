cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - phykit
  - plot_alignment_qc
label: phykit_plot_alignment_qc
doc: Generate a multi-panel alignment quality-control plot. The figure 
  summarizes per-taxon occupancy and gap rates, composition-distance versus 
  long-branch proxy, and counts of feature-based outlier flags.
inputs:
  - id: alignment
    type: File
    doc: first argument after function name should be an alignment file
    inputBinding:
      position: 1
  - id: output
    type: string
    doc: output image path
    inputBinding:
      position: 102
      prefix: --output
  - id: width
    type:
      - 'null'
      - float
    doc: figure width in inches
    inputBinding:
      position: 102
      prefix: --width
  - id: height
    type:
      - 'null'
      - float
    doc: figure height in inches
    inputBinding:
      position: 102
      prefix: --height
  - id: dpi
    type:
      - 'null'
      - int
    doc: image DPI
    inputBinding:
      position: 102
      prefix: --dpi
  - id: gap_z
    type:
      - 'null'
      - float
    doc: z-threshold for gap_rate outliers
    inputBinding:
      position: 102
      prefix: --gap-z
  - id: composition_z
    type:
      - 'null'
      - float
    doc: z-threshold for composition_distance outliers
    inputBinding:
      position: 102
      prefix: --composition-z
  - id: distance_z
    type:
      - 'null'
      - float
    doc: z-threshold for long_branch_proxy outliers
    inputBinding:
      position: 102
      prefix: --distance-z
  - id: rcvt_z
    type:
      - 'null'
      - float
    doc: z-threshold for rcvt outliers
    inputBinding:
      position: 102
      prefix: --rcvt-z
  - id: occupancy_z
    type:
      - 'null'
      - float
    doc: z-threshold for low occupancy outliers
    inputBinding:
      position: 102
      prefix: --occupancy-z
  - id: entropy_z
    type:
      - 'null'
      - float
    doc: z-threshold for entropy_burden outliers
    inputBinding:
      position: 102
      prefix: --entropy-z
  - id: json
    type:
      - 'null'
      - boolean
    doc: optional argument to output metadata as JSON
    inputBinding:
      position: 102
      prefix: --json
outputs:
  - id: output_output
    type:
      - 'null'
      - File
    doc: output image path
    outputBinding:
      glob: $(inputs.output)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phykit:2.1.92--pyhdfd78af_0
s:url: https://github.com/jlsteenwyk/phykit
$namespaces:
  s: https://schema.org/
