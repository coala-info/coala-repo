cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - octopusv
  - plot
label: octopusv_plot
doc: "Generate plots from the statistics file.\n\nTool homepage: https://github.com/ylab-hi/octopusV"
inputs:
  - id: input_file
    type: File
    doc: Input stat.txt file to plot.
    inputBinding:
      position: 1
  - id: output_prefix_path
    type: string
    doc: Output or path parameter `output_prefix_path`
    inputBinding:
      position: 101
      prefix: --output-prefix
outputs:
  - id: output_prefix
    type: File
    doc: Output prefix for plot files.
    outputBinding:
      glob: $(inputs.output_prefix_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/octopusv:0.3.0--pyhdfd78af_0
