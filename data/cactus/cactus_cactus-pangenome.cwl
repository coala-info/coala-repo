cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - cactus-pangenome
label: cactus_cactus-pangenome
doc: "The provided text does not contain help information or usage instructions; it
  is a log of a container build failure due to insufficient disk space. No arguments
  could be extracted.\n\nTool homepage: https://github.com/ComparativeGenomicsToolkit/cactus"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cactus:2019.03.01--py27hdbcaa40_0
stdout: cactus_cactus-pangenome.out
