cwlVersion: v1.2
class: CommandLineTool
baseCommand: snakemake-storage-plugin-gcs
label: snakemake-storage-plugin-gcs
doc: "Snakemake storage plugin for Google Cloud Storage (GCS)\n\nTool homepage: https://github.com/snakemake/snakemake-storage-plugin-gcs"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/snakemake-storage-plugin-gcs:1.1.4--pyhdfd78af_0
stdout: snakemake-storage-plugin-gcs.out
