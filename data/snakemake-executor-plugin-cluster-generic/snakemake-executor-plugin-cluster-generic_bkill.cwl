cwlVersion: v1.2
class: CommandLineTool
baseCommand: bkill
label: snakemake-executor-plugin-cluster-generic_bkill
doc: "A command used by the Snakemake cluster-generic executor plugin to terminate
  jobs on a cluster (typically LSF).\n\nTool homepage: https://github.com/snakemake/snakemake-executor-plugin-cluster-generic"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: 
      quay.io/biocontainers/snakemake-executor-plugin-cluster-generic:1.0.9--pyhdfd78af_0
stdout: snakemake-executor-plugin-cluster-generic_bkill.out
