cwlVersion: v1.2
class: CommandLineTool
baseCommand: snakemake-executor-plugin-kubernetes
label: snakemake-executor-plugin-kubernetes
doc: "A Snakemake executor plugin for running workflows on Kubernetes.\n\nTool homepage:
  https://github.com/snakemake/snakemake-executor-plugin-kubernetes"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/snakemake-executor-plugin-kubernetes:0.5.1--pyhdfd78af_0
stdout: snakemake-executor-plugin-kubernetes.out
