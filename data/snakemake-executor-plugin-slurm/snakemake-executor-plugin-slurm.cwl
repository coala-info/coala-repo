cwlVersion: v1.2
class: CommandLineTool
baseCommand: snakemake
label: snakemake-executor-plugin-slurm
doc: "Snakemake executor plugin for SLURM. Note: The provided text appears to be a
  container engine error log rather than CLI help text, so no arguments could be extracted.\n
  \nTool homepage: https://github.com/snakemake/snakemake-executor-plugin-slurm"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/snakemake-executor-plugin-slurm:2.1.0--pyhdfd78af_0
stdout: snakemake-executor-plugin-slurm.out
