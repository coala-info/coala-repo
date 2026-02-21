cwlVersion: v1.2
class: CommandLineTool
baseCommand: snakemake-executor-plugin-cluster-generic_bsub
label: snakemake-executor-plugin-cluster-generic_bsub
doc: "Snakemake executor plugin for generic cluster submission using bsub.\n\nTool
  homepage: https://github.com/snakemake/snakemake-executor-plugin-cluster-generic"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: 
      quay.io/biocontainers/snakemake-executor-plugin-cluster-generic:1.0.9--pyhdfd78af_0
stdout: snakemake-executor-plugin-cluster-generic_bsub.out
