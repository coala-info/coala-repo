cwlVersion: v1.2
class: CommandLineTool
baseCommand: snakemake-storage-plugin-zenodo
label: snakemake-storage-plugin-zenodo
doc: "Snakemake storage plugin for Zenodo\n\nTool homepage: https://github.com/snakemake/snakemake-storage-plugin-zenodo"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/snakemake-storage-plugin-zenodo:0.1.5--pyhdfd78af_0
stdout: snakemake-storage-plugin-zenodo.out
