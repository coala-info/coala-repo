cwlVersion: v1.2
class: CommandLineTool
baseCommand: snakemake-storage-plugin-s3
label: snakemake-storage-plugin-s3
doc: "A Snakemake storage plugin that allows for using S3 as a storage backend.\n\n
  Tool homepage: https://github.com/snakemake/snakemake-storage-plugin-s3"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/snakemake-storage-plugin-s3:0.3.6--pyhdfd78af_0
stdout: snakemake-storage-plugin-s3.out
