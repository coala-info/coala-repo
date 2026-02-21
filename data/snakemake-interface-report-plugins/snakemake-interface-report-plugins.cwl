cwlVersion: v1.2
class: CommandLineTool
baseCommand: snakemake-interface-report-plugins
label: snakemake-interface-report-plugins
doc: "Snakemake interface for report plugins\n\nTool homepage: https://github.com/snakemake/snakemake-interface-report-plugins"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/snakemake-interface-report-plugins:1.3.0--pyhd4c3c12_0
stdout: snakemake-interface-report-plugins.out
