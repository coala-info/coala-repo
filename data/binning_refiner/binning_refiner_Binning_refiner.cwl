cwlVersion: v1.2
class: CommandLineTool
baseCommand: Binning_refiner
label: binning_refiner_Binning_refiner
doc: "Refines bins based on various criteria.\n\nTool homepage: https://github.com/songweizhi/Binning_refiner"
inputs:
  - id: input_bin_folder
    type: Directory
    doc: input bin folder
    inputBinding:
      position: 101
      prefix: -i
  - id: minimal_size_kbp
    type:
      - 'null'
      - int
    doc: minimal size (Kbp) of refined bin
    inputBinding:
      position: 101
      prefix: -m
  - id: output_prefix
    type:
      - 'null'
      - string
    doc: output prefix
    inputBinding:
      position: 101
      prefix: -p
  - id: plot
    type:
      - 'null'
      - boolean
    doc: visualize refinement with Sankey plot
    inputBinding:
      position: 101
      prefix: -plot
  - id: sankey_plot_height
    type:
      - 'null'
      - int
    doc: the height of sankey plot
    inputBinding:
      position: 101
      prefix: -y
  - id: sankey_plot_width
    type:
      - 'null'
      - int
    doc: the width of sankey plot
    inputBinding:
      position: 101
      prefix: -x
  - id: silent_progress_report
    type:
      - 'null'
      - boolean
    doc: silent progress report
    inputBinding:
      position: 101
      prefix: -q
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/binning_refiner:1.4.3
stdout: binning_refiner_Binning_refiner.out
