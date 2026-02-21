cwlVersion: v1.2
class: CommandLineTool
baseCommand: snakemake
label: snakemake-executor-plugin-tes_snakemake
doc: "Snakemake executor plugin for the Task Execution Service (TES).\n\nTool homepage:
  https://github.com/snakemake/snakemake-executor-plugin-tes"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/snakemake-executor-plugin-tes:0.1.3--pyhdfd78af_0
stdout: snakemake-executor-plugin-tes_snakemake.out
