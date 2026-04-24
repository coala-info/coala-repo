cwlVersion: v1.2
class: CommandLineTool
baseCommand: kernel_plot.py
label: kernel_density_plots_kernel_plot.py
doc: "Kernel Plot Tool\n\nTool homepage: https://github.com/kapurlab/kernel_density_plots"
inputs:
  - id: annotation_size
    type:
      - 'null'
      - int
    doc: 'Annotation text size (default: 6)'
    inputBinding:
      position: 101
      prefix: --annotation-size
  - id: axis_text_size
    type:
      - 'null'
      - int
    doc: 'Axis text size (default: 12)'
    inputBinding:
      position: 101
      prefix: --axis-text-size
  - id: axis_title_size
    type:
      - 'null'
      - int
    doc: 'Axis title text size (default: 14)'
    inputBinding:
      position: 101
      prefix: --axis-title-size
  - id: bin_size
    type:
      - 'null'
      - int
    doc: 'Histogram bin size (default: 25)'
    inputBinding:
      position: 101
      prefix: --bin-size
  - id: density_xlim
    type:
      - 'null'
      - float
    doc: 'Density plot X-axis limit (default: 1400)'
    inputBinding:
      position: 101
      prefix: --density-xlim
  - id: height
    type:
      - 'null'
      - int
    doc: 'Plot height in inches (default: 5)'
    inputBinding:
      position: 101
      prefix: --height
  - id: input_fasta
    type: File
    doc: Input FASTA file
    inputBinding:
      position: 101
      prefix: --fasta
  - id: lineage
    type:
      - 'null'
      - string
    doc: Specify lineage/group name (optional)
    inputBinding:
      position: 101
      prefix: --lineage
  - id: neighbor_xlim
    type:
      - 'null'
      - float
    doc: 'Closest neighbor X-axis limit (default: 600)'
    inputBinding:
      position: 101
      prefix: --neighbor-xlim
  - id: no_annotations
    type:
      - 'null'
      - boolean
    doc: Hide text annotations on plots
    inputBinding:
      position: 101
      prefix: --no-annotations
  - id: outputdir
    type:
      - 'null'
      - Directory
    doc: "Output directory (default: creates folder next to\n                    \
      \    input file)"
    inputBinding:
      position: 101
      prefix: --outputdir
  - id: theme
    type:
      - 'null'
      - string
    doc: 'Plot theme (default: light)'
    inputBinding:
      position: 101
      prefix: --theme
  - id: title_size
    type:
      - 'null'
      - int
    doc: 'Title text size (default: 18)'
    inputBinding:
      position: 101
      prefix: --title-size
  - id: width
    type:
      - 'null'
      - int
    doc: 'Plot width in inches (default: 7)'
    inputBinding:
      position: 101
      prefix: --width
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kernel_density_plots:0.1--pyhdfd78af_0
stdout: kernel_density_plots_kernel_plot.py.out
