cwlVersion: v1.2
class: CommandLineTool
baseCommand: cactus-hal2maf
label: cactus_cactus-hal2maf
doc: "The provided text does not contain help information or a description of the
  tool; it is an error log indicating a failure to build or run a container due to
  insufficient disk space.\n\nTool homepage: https://github.com/ComparativeGenomicsToolkit/cactus"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cactus:2019.03.01--py27hdbcaa40_0
stdout: cactus_cactus-hal2maf.out
