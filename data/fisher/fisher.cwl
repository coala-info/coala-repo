cwlVersion: v1.2
class: CommandLineTool
baseCommand: fisher
label: fisher
doc: "The provided text appears to be a container build error log rather than CLI
  help text. As a result, no command-line arguments, options, or descriptions could
  be extracted from the input.\n\nTool homepage: https://github.com/jorgebucaran/fisher"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fisher:0.1.4
stdout: fisher.out
