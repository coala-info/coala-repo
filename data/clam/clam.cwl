cwlVersion: v1.2
class: CommandLineTool
baseCommand: clam
label: clam
doc: "The provided text is a container build error log and does not contain the tool's
  help information or usage instructions.\n\nTool homepage: https://github.com/cademirch/clam"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/clam:1.1.0--h3ab6199_0
stdout: clam.out
