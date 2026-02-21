cwlVersion: v1.2
class: CommandLineTool
baseCommand: snakemake-executor-plugin-cluster-sync
label: snakemake-executor-plugin-cluster-sync
doc: "A Snakemake executor plugin for cluster synchronization. (Note: The provided
  text contained system logs rather than help documentation; no arguments could be
  extracted from the input.)\n\nTool homepage: https://github.com/snakemake/snakemake-executor-plugin-cluster-sync"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/snakemake-executor-plugin-cluster-sync:0.1.5--pyhdfd78af_0
stdout: snakemake-executor-plugin-cluster-sync.out
