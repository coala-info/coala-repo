cwlVersion: v1.2
class: CommandLineTool
baseCommand: snakemake-storage-plugin-sharepoint
label: snakemake-storage-plugin-sharepoint
doc: "A Snakemake storage plugin for SharePoint. Note: The provided text appears to
  be a container execution log/error rather than help text, so no arguments could
  be extracted.\n\nTool homepage: https://github.com/Hugovdberg/snakemake-storage-plugin-sharepoint"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/snakemake-storage-plugin-sharepoint:0.4.4--pyhdfd78af_0
stdout: snakemake-storage-plugin-sharepoint.out
