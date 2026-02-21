cwlVersion: v1.2
class: CommandLineTool
baseCommand: snakemake-executor-plugin-drmaa
label: snakemake-executor-plugin-drmaa
doc: "A Snakemake executor plugin for DRMAA (Distributed Resource Management Application
  API). Note: The provided text contains build logs and error messages rather than
  standard CLI help documentation.\n\nTool homepage: https://github.com/snakemake/snakemake-executor-plugin-drmaa"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/snakemake-executor-plugin-drmaa:0.1.5--pyhdfd78af_0
stdout: snakemake-executor-plugin-drmaa.out
