cwlVersion: v1.2
class: CommandLineTool
baseCommand: snakemake-executor-plugin-aws-batch
label: snakemake-executor-plugin-aws-batch
doc: "AWS Batch executor plugin for Snakemake\n\nTool homepage: https://github.com/snakemake/snakemake-executor-plugin-aws-batch"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/snakemake-executor-plugin-aws-batch:0.2.1--pyhdfd78af_0
stdout: snakemake-executor-plugin-aws-batch.out
