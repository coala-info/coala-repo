cwlVersion: v1.2
class: CommandLineTool
baseCommand: snakemake-interface-logger-plugins
label: snakemake-interface-logger-plugins
doc: "Snakemake interface for logger plugins\n\nTool homepage: https://github.com/snakemake/snakemake-interface-logger-plugins"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/snakemake-interface-logger-plugins:2.0.0--pyhd4c3c12_0
stdout: snakemake-interface-logger-plugins.out
