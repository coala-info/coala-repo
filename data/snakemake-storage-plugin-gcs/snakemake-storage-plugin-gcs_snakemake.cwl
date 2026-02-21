cwlVersion: v1.2
class: CommandLineTool
baseCommand: snakemake
label: snakemake-storage-plugin-gcs_snakemake
doc: "Snakemake storage plugin for Google Cloud Storage (GCS). Note: The provided
  text contains execution logs and error messages rather than help documentation;
  therefore, no arguments could be extracted.\n\nTool homepage: https://github.com/snakemake/snakemake-storage-plugin-gcs"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/snakemake-storage-plugin-gcs:1.1.4--pyhdfd78af_0
stdout: snakemake-storage-plugin-gcs_snakemake.out
