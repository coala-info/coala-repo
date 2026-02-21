cwlVersion: v1.2
class: CommandLineTool
baseCommand: snakemake
label: snakemake-executor-plugin-lsf_snakemake
doc: "Snakemake executor plugin for LSF (Load Sharing Facility). Note: The provided
  text appears to be a container execution log rather than help documentation, so
  no arguments could be extracted.\n\nTool homepage: https://github.com/befh/snakemake-executor-plugin-lsf"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/snakemake-executor-plugin-lsf:0.2.6--pyhdfd78af_0
stdout: snakemake-executor-plugin-lsf_snakemake.out
