cwlVersion: v1.2
class: CommandLineTool
baseCommand: snakemake
label: snakemake-interface-storage-plugins_snakemake
doc: "Snakemake interface for storage plugins (Note: The provided text contains error
  logs rather than help documentation, so no arguments could be extracted).\n\nTool
  homepage: https://github.com/snakemake/snakemake-interface-storage-plugins"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/snakemake-interface-storage-plugins:4.3.2--pyhd4c3c12_0
stdout: snakemake-interface-storage-plugins_snakemake.out
