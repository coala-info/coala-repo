cwlVersion: v1.2
class: CommandLineTool
baseCommand: snakemake
label: snakemake-minimal
doc: "Snakemake is a workflow management system that aims to reduce the complexity
  of creating workflows by providing a fast and flexible Python-based domain specific
  language.\n\nTool homepage: https://snakemake.readthedocs.io"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/snakemake-minimal:9.16.2--pyhdfd78af_1
stdout: snakemake-minimal.out
