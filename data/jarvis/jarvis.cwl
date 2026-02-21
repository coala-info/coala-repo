cwlVersion: v1.2
class: CommandLineTool
baseCommand: jarvis
label: jarvis
doc: "The provided text does not contain help information or a description of the
  tool; it contains error logs from a container runtime environment.\n\nTool homepage:
  https://github.com/cobilab/jarvis"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/jarvis:1.1--h7b50bb2_6
stdout: jarvis.out
