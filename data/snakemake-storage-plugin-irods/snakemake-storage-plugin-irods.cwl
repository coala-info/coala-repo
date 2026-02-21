cwlVersion: v1.2
class: CommandLineTool
baseCommand: snakemake-storage-plugin-irods
label: snakemake-storage-plugin-irods
doc: "A Snakemake storage plugin that allows for interaction with iRODS (Integrated
  Rule-Oriented Data System).\n\nTool homepage: https://github.com/snakemake/snakemake-storage-plugin-irods"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/snakemake-storage-plugin-irods:0.3.1--pyhdfd78af_0
stdout: snakemake-storage-plugin-irods.out
