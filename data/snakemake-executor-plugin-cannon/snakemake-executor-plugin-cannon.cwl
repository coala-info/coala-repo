cwlVersion: v1.2
class: CommandLineTool
baseCommand: snakemake-executor-plugin-cannon
label: snakemake-executor-plugin-cannon
doc: "Snakemake executor plugin for Cannon\n\nTool homepage: https://github.com/harvardinformatics/snakemake-executor-plugin-cannon"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/snakemake-executor-plugin-cannon:1.9.2.post2--pyhdfd78af_0
stdout: snakemake-executor-plugin-cannon.out
