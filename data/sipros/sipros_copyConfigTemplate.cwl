cwlVersion: v1.2
class: CommandLineTool
baseCommand: sipros_copyConfigTemplate
label: sipros_copyConfigTemplate
doc: "Copy configuration template for Sipros (Note: The provided help text contains
  only system error logs and no argument definitions).\n\nTool homepage: https://github.com/thepanlab/Sipros4"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sipros:5.0.1--hdfd78af_1
stdout: sipros_copyConfigTemplate.out
