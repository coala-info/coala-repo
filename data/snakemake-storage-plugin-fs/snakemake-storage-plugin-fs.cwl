cwlVersion: v1.2
class: CommandLineTool
baseCommand: snakemake-storage-plugin-fs
label: snakemake-storage-plugin-fs
doc: "A Snakemake storage plugin for the file system.\n\nTool homepage: https://github.com/snakemake/snakemake-storage-plugin-fs"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/snakemake-storage-plugin-fs:1.1.3--pyhdfd78af_0
stdout: snakemake-storage-plugin-fs.out
