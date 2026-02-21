cwlVersion: v1.2
class: CommandLineTool
baseCommand: snakemake-scheduler-plugin-firstfit
label: snakemake-scheduler-plugin-firstfit
doc: "A Snakemake scheduler plugin that implements a first-fit strategy for job scheduling.\n
  \nTool homepage: https://github.com/snakemake/snakemake-scheduler-plugin-firstfit"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/snakemake-scheduler-plugin-firstfit:0.1.2--pyhdfd78af_0
stdout: snakemake-scheduler-plugin-firstfit.out
