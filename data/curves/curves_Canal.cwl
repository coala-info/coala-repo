cwlVersion: v1.2
class: CommandLineTool
baseCommand: Canal
label: curves_Canal
doc: "The provided text does not contain help information or usage instructions for
  curves_Canal. It appears to be a system error log indicating a failure to build
  or extract a container image due to insufficient disk space.\n\nTool homepage: https://bisi.ibcp.fr/tools/curves_plus/index.html"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/curves:3.0.3--h70c14e6_1
stdout: curves_Canal.out
