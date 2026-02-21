cwlVersion: v1.2
class: CommandLineTool
baseCommand: optimir_plot_ASE.R
label: optimir_plot_ASE.R
doc: "The provided text is a container execution error log and does not contain help
  information or argument definitions for the tool.\n\nTool homepage: https://github.com/FlorianThibord/OptimiR"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/optimir:1.2--pyh5e36f6f_0
stdout: optimir_plot_ASE.R.out
