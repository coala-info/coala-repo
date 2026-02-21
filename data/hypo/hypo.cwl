cwlVersion: v1.2
class: CommandLineTool
baseCommand: hypo
label: hypo
doc: "The provided text is a container execution error log and does not contain help
  documentation or usage information for the tool 'hypo'.\n\nTool homepage: https://github.com/kensung-lab/hypo"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hypo:1.0.3--h9a82719_1
stdout: hypo.out
