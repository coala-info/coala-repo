cwlVersion: v1.2
class: CommandLineTool
baseCommand: snakemake-storage-plugin-azure
label: snakemake-storage-plugin-azure_docker
doc: "Snakemake storage plugin for Azure (Note: The provided text appears to be a
  container build log rather than CLI help text, so no arguments could be extracted).\n
  \nTool homepage: https://github.com/snakemake/snakemake-storage-plugin-azure"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/snakemake-storage-plugin-azure:0.4.4--pyhdfd78af_0
stdout: snakemake-storage-plugin-azure_docker.out
