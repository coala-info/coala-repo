cwlVersion: v1.2
class: CommandLineTool
baseCommand: snakemake
label: snakemake-storage-plugin-azure_snakemake
doc: "Snakemake storage plugin for Azure (Note: The provided text contains execution
  logs and error messages rather than help text; no arguments could be parsed from
  the input).\n\nTool homepage: https://github.com/snakemake/snakemake-storage-plugin-azure"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/snakemake-storage-plugin-azure:0.4.4--pyhdfd78af_0
stdout: snakemake-storage-plugin-azure_snakemake.out
