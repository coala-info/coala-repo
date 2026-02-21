cwlVersion: v1.2
class: CommandLineTool
baseCommand: zavolan-multiqc-plugins
label: zavolan-multiqc-plugins
doc: "MultiQC plugins developed by the Zavolan Lab. Note: The provided text contains
  container runtime error logs rather than CLI help documentation, so no arguments
  could be extracted.\n\nTool homepage: https://github.com/zavolanlab/multiqc-plugins"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/zavolan-multiqc-plugins:1.3--pyh5e36f6f_0
stdout: zavolan-multiqc-plugins.out
