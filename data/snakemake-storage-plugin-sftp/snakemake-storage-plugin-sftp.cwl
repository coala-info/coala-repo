cwlVersion: v1.2
class: CommandLineTool
baseCommand: snakemake-storage-plugin-sftp
label: snakemake-storage-plugin-sftp
doc: "Snakemake storage plugin for SFTP. (Note: The provided text is a container build
  error log and does not contain CLI help information or argument definitions.)\n\n
  Tool homepage: https://github.com/snakemake/snakemake-storage-plugin-sftp"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/snakemake-storage-plugin-sftp:0.1.3--pyhdfd78af_0
stdout: snakemake-storage-plugin-sftp.out
