cwlVersion: v1.2
class: CommandLineTool
baseCommand: snakemake-storage-plugin-azure
label: snakemake-storage-plugin-azure
doc: "Snakemake storage plugin for Azure (Note: The provided text is an error log
  and does not contain help documentation or argument definitions).\n\nTool homepage:
  https://github.com/snakemake/snakemake-storage-plugin-azure"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/snakemake-storage-plugin-azure:0.4.4--pyhdfd78af_0
stdout: snakemake-storage-plugin-azure.out
