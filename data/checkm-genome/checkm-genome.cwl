cwlVersion: v1.2
class: CommandLineTool
baseCommand: checkm
label: checkm-genome
doc: "The provided text does not contain help information or a description of the
  tool; it is an error log reporting a failure to build a container image due to insufficient
  disk space.\n\nTool homepage: https://github.com/Ecogenomics/CheckM"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/checkm-genome:1.2.4--pyhdfd78af_2
stdout: checkm-genome.out
