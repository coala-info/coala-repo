cwlVersion: v1.2
class: CommandLineTool
baseCommand: rsem-prepare-reference
label: rsem_rsem-prepare-reference
doc: "The provided text does not contain help information for rsem-prepare-reference,
  but appears to be a log of a failed container build process.\n\nTool homepage: https://deweylab.github.io/RSEM/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rsem:1.3.3--pl5321h077b44d_12
stdout: rsem_rsem-prepare-reference.out
