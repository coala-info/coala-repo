cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - scanpy-cli
  - plot
  - scrublet
label: scanpy-scripts_scanpy-cli_plot_scrublet
doc: "Plot histogram of doublet scores for observed transcriptomes and simulated doublets..\n\nTool homepage: https://github.com/ebi-gene-expression-group/scanpy-scripts"
inputs:
  - id: input_obj
    type: File
    doc: input file in format specified by --input-format
    inputBinding:
      position: 1
  - id: output_fig_path
    type: string
    doc: output figure in pdf or png format
    inputBinding:
      position: 2
  - id: input_format
    type:
      - 'null'
      - string
    doc: "Input object format."
    inputBinding:
      position: 101
      prefix: --input-format
  - id: fig_size
    type:
      - 'null'
      - type: array
        items: int
    doc: "Figure size."
    inputBinding:
      position: 101
      prefix: --fig-size
      itemSeparator: ','
  - id: fig_dpi
    type:
      - 'null'
      - int
    doc: "Figure DPI."
    inputBinding:
      position: 101
      prefix: --fig-dpi
  - id: fig_fontsize
    type:
      - 'null'
      - int
    doc: "Figure font size."
    inputBinding:
      position: 101
      prefix: --fig-fontsize
  - id: scale_hist_obs
    type:
      - 'null'
      - string
    doc: "Set y axis scale transformation in matplotlib for the plot of observed transcriptomes."
    inputBinding:
      position: 101
      prefix: --scale-hist-obs
  - id: scale_hist_sim
    type:
      - 'null'
      - string
    doc: "Set y axis scale transformation in matplotlib for the plot of observed transcriptomes."
    inputBinding:
      position: 101
      prefix: --scale-hist-sim
outputs:
  - id: output_fig
    type: File
    doc: output figure
    outputBinding:
      glob: $(inputs.output_fig_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/scanpy-scripts:1.9.301--pyhdfd78af_0
