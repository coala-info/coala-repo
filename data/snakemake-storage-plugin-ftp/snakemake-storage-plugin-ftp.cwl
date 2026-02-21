cwlVersion: v1.2
class: CommandLineTool
baseCommand: snakemake-storage-plugin-ftp
label: snakemake-storage-plugin-ftp
doc: "A Snakemake storage plugin for interacting with FTP storage backends.\n\nTool
  homepage: https://github.com/snakemake/snakemake-storage-plugin-ftp"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/snakemake-storage-plugin-ftp:0.1.3--pyhdfd78af_0
stdout: snakemake-storage-plugin-ftp.out
