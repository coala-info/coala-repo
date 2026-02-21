cwlVersion: v1.2
class: CommandLineTool
baseCommand: kernel_density_plots
label: kernel_density_plots
doc: "A tool for generating kernel density plots. (Note: The provided text is a container
  runtime error log and does not contain usage instructions or argument definitions.)\n
  \nTool homepage: https://github.com/kapurlab/kernel_density_plots"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kernel_density_plots:0.1--pyhdfd78af_0
stdout: kernel_density_plots.out
