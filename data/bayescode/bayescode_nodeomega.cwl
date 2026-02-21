cwlVersion: v1.2
class: CommandLineTool
baseCommand: nodeomega
label: bayescode_nodeomega
doc: "The provided text does not contain help information for the tool. It contains
  system logs and a fatal error message regarding a container build failure (no space
  left on device).\n\nTool homepage: https://github.com/ThibaultLatrille/bayescode"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bayescode:1.3.4--h9948957_0
stdout: bayescode_nodeomega.out
