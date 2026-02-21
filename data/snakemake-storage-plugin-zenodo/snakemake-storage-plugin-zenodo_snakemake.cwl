cwlVersion: v1.2
class: CommandLineTool
baseCommand: snakemake
label: snakemake-storage-plugin-zenodo_snakemake
doc: "A Snakemake storage plugin that allows for interaction with Zenodo. Note: The
  provided text appears to be a container build log rather than CLI help text, so
  no specific arguments could be extracted.\n\nTool homepage: https://github.com/snakemake/snakemake-storage-plugin-zenodo"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/snakemake-storage-plugin-zenodo:0.1.5--pyhdfd78af_0
stdout: snakemake-storage-plugin-zenodo_snakemake.out
