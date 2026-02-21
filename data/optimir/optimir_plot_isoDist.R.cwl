cwlVersion: v1.2
class: CommandLineTool
baseCommand: optimir_plot_isoDist.R
label: optimir_plot_isoDist.R
doc: "A tool for plotting isomiR distribution. (Note: The provided text contains container
  runtime error messages rather than command-line help documentation; therefore, no
  arguments could be extracted.)\n\nTool homepage: https://github.com/FlorianThibord/OptimiR"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/optimir:1.2--pyh5e36f6f_0
stdout: optimir_plot_isoDist.R.out
