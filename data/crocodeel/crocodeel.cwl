cwlVersion: v1.2
class: CommandLineTool
baseCommand: crocodeel
label: crocodeel
doc: "The provided text does not contain help information or a description for the
  tool; it consists of system error logs regarding a failed container build (no space
  left on device).\n\nTool homepage: https://github.com/metagenopolis/crocodeel"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/crocodeel:1.0.8--pyhdfd78af_0
stdout: crocodeel.out
