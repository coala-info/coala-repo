cwlVersion: v1.2
class: CommandLineTool
baseCommand: snakemake-interface-scheduler-plugins
label: snakemake-interface-scheduler-plugins
doc: "Interface for Snakemake scheduler plugins. (Note: The provided text appears
  to be a container execution log rather than CLI help text; therefore, no arguments
  could be extracted.)\n\nTool homepage: https://github.com/snakemake/snakemake-interface-scheduler-plugins"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/snakemake-interface-scheduler-plugins:2.0.2--pyhd4c3c12_0
stdout: snakemake-interface-scheduler-plugins.out
