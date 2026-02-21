cwlVersion: v1.2
class: CommandLineTool
baseCommand: snakemake-executor-plugin-cluster-generic_sbatch
label: snakemake-executor-plugin-cluster-generic_sbatch
doc: "Snakemake executor plugin for generic cluster sbatch (Note: The provided text
  appears to be a container build error log rather than help text; no arguments could
  be extracted).\n\nTool homepage: https://github.com/snakemake/snakemake-executor-plugin-cluster-generic"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: 
      quay.io/biocontainers/snakemake-executor-plugin-cluster-generic:1.0.9--pyhdfd78af_0
stdout: snakemake-executor-plugin-cluster-generic_sbatch.out
