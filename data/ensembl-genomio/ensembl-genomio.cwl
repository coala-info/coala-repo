cwlVersion: v1.2
class: CommandLineTool
baseCommand: ensembl-genomio
label: ensembl-genomio
doc: "The provided text does not contain help information or a description of the
  tool; it contains system error logs related to a container runtime failure.\n\n
  Tool homepage: https://www.ensembl.org/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ensembl-genomio:1.6.2--pyhdfd78af_0
stdout: ensembl-genomio.out
