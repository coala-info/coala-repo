cwlVersion: v1.2
class: CommandLineTool
baseCommand: snakemake
label: snakemake-minimal_7.25.0-pyhdfd78af_0
doc: "Snakemake is a workflow management system that aims to reduce the complexity
  of creating workflows by providing a fast and flexible execution environment.\n\n
  Tool homepage: https://snakemake.github.io"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/snakemake:9.16.2--hdfd78af_1
stdout: snakemake-minimal_7.25.0-pyhdfd78af_0.out
