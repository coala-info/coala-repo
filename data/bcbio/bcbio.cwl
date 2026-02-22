cwlVersion: v1.2
class: CommandLineTool
baseCommand: bcbio
label: bcbio
doc: "The provided text contains system error messages related to container image
  extraction and does not contain help documentation or usage information for the
  bcbio tool.\n\nTool homepage: https://github.com/bcbio/bcbio-nextgen"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/bcbio:v1.1.2-3-deb-py3_cv1
stdout: bcbio.out
