cwlVersion: v1.2
class: CommandLineTool
baseCommand: snakemake-executor-plugin-azure-batch
label: snakemake-executor-plugin-azure-batch
doc: "Snakemake executor plugin for Azure Batch\n\nTool homepage: https://github.com/snakemake/snakemake-executor-plugin-azure-batch"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/snakemake-executor-plugin-azure-batch:0.1.3--pyhdfd78af_0
stdout: snakemake-executor-plugin-azure-batch.out
