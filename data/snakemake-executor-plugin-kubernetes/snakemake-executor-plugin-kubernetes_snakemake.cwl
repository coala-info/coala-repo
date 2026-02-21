cwlVersion: v1.2
class: CommandLineTool
baseCommand: snakemake
label: snakemake-executor-plugin-kubernetes_snakemake
doc: "Snakemake executor plugin for Kubernetes. (Note: The provided text appears to
  be a container execution log rather than help text; no arguments could be extracted
  from the input.)\n\nTool homepage: https://github.com/snakemake/snakemake-executor-plugin-kubernetes"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/snakemake-executor-plugin-kubernetes:0.5.1--pyhdfd78af_0
stdout: snakemake-executor-plugin-kubernetes_snakemake.out
