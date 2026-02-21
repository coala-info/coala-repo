cwlVersion: v1.2
class: CommandLineTool
baseCommand: snakemake-interface-storage-plugins
label: snakemake-interface-storage-plugins
doc: "The provided text does not contain help information or a description of the
  tool. It appears to be a log of a failed container build or image fetch process.\n
  \nTool homepage: https://github.com/snakemake/snakemake-interface-storage-plugins"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/snakemake-interface-storage-plugins:4.3.2--pyhd4c3c12_0
stdout: snakemake-interface-storage-plugins.out
