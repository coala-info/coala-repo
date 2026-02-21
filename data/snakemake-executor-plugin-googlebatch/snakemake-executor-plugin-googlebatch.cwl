cwlVersion: v1.2
class: CommandLineTool
baseCommand: snakemake-executor-plugin-googlebatch
label: snakemake-executor-plugin-googlebatch
doc: "Snakemake executor plugin for Google Batch\n\nTool homepage: https://github.com/snakemake/snakemake-executor-plugin-googlebatch"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/snakemake-executor-plugin-googlebatch:0.5.1--pyhdfd78af_0
stdout: snakemake-executor-plugin-googlebatch.out
