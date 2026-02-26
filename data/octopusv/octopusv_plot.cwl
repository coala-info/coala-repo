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
outputs:
  - id: output_prefix
    type: File
    doc: Output prefix for plot files.
    outputBinding:
      glob: $(inputs.output_prefix)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/octopusv:0.3.0--pyhdfd78af_0
