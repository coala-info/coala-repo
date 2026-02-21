cwlVersion: v1.2
class: CommandLineTool
baseCommand: snakemake-executor-plugin-lsf-jobstep
label: snakemake-executor-plugin-lsf-jobstep
doc: "Snakemake executor plugin for LSF jobsteps\n\nTool homepage: https://github.com/BEFH/snakemake-executor-plugin-lsf-jobstep"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/snakemake-executor-plugin-lsf-jobstep:0.1.10--pyhdfd78af_0
stdout: snakemake-executor-plugin-lsf-jobstep.out
