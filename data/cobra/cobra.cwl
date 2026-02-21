cwlVersion: v1.2
class: CommandLineTool
baseCommand: cobra
label: cobra
doc: "The provided text does not contain help information or a description of the
  tool; it contains system logs and a fatal error regarding container image conversion
  and disk space.\n\nTool homepage: https://opencobra.github.io/cobrapy"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cobra:0.29.1
stdout: cobra.out
