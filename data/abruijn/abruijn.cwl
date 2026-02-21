cwlVersion: v1.2
class: CommandLineTool
baseCommand: abruijn
label: abruijn
doc: "The provided text does not contain help information for the tool 'abruijn'.
  It contains error logs related to a failed container build (no space left on device).\n
  \nTool homepage: https://github.com/fenderglass/ABruijn/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/abruijn:2.1b--py27_0
stdout: abruijn.out
