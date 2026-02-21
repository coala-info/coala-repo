cwlVersion: v1.2
class: CommandLineTool
baseCommand: snakemake
label: snakemake-storage-plugin-sharepoint_snakemake
doc: "A Snakemake storage plugin that allows for using SharePoint as a storage provider.\n
  \nTool homepage: https://github.com/Hugovdberg/snakemake-storage-plugin-sharepoint"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/snakemake-storage-plugin-sharepoint:0.4.4--pyhdfd78af_0
stdout: snakemake-storage-plugin-sharepoint_snakemake.out
