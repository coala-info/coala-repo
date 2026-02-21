cwlVersion: v1.2
class: CommandLineTool
baseCommand: cactus_hal2fasta
label: cactus_hal2fasta
doc: "A tool to convert HAL files to FASTA format (Note: The provided help text contains
  only container build logs and an error message, so specific arguments could not
  be extracted).\n\nTool homepage: https://github.com/ComparativeGenomicsToolkit/cactus"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cactus:2019.03.01--py27hdbcaa40_0
stdout: cactus_hal2fasta.out
