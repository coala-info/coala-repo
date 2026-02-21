cwlVersion: v1.2
class: CommandLineTool
baseCommand: snakemake-executor-plugin-slurm-jobstep
label: snakemake-executor-plugin-slurm-jobstep
doc: "A Snakemake executor plugin for SLURM jobsteps.\n\nTool homepage: https://github.com/snakemake/snakemake-executor-plugin-slurm-jobstep"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: 
      quay.io/biocontainers/snakemake-executor-plugin-slurm-jobstep:0.4.0--pyhdfd78af_0
stdout: snakemake-executor-plugin-slurm-jobstep.out
