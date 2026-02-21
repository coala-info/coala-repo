cwlVersion: v1.2
class: CommandLineTool
baseCommand: mixcr
label: mixcr
doc: "MiXCR is a universal framework for processing big immunogenetic data (Note:
  The provided help text contains a container runtime error and does not list specific
  arguments).\n\nTool homepage: https://github.com/milaboratory/mixcr"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mixcr:3.0.12--0
stdout: mixcr.out
