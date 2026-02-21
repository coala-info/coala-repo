cwlVersion: v1.2
class: CommandLineTool
baseCommand: ibdne_plot_ibdne.R
label: ibdne_plot_ibdne.R
doc: "Plotting script for IBDne results. (Note: The provided text contains system
  error messages regarding container execution and does not include usage instructions
  or argument definitions.)\n\nTool homepage: https://github.com/hennlab/AS-IBDNe"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ibdne:04Sep15.e78--0
stdout: ibdne_plot_ibdne.R.out
