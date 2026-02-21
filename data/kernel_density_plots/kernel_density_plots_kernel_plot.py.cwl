cwlVersion: v1.2
class: CommandLineTool
baseCommand: kernel_density_plots_kernel_plot.py
label: kernel_density_plots_kernel_plot.py
doc: "A tool for generating kernel density plots. (Note: The provided text contains
  container runtime error messages rather than the tool's help documentation.)\n\n
  Tool homepage: https://github.com/kapurlab/kernel_density_plots"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kernel_density_plots:0.1--pyhdfd78af_0
stdout: kernel_density_plots_kernel_plot.py.out
