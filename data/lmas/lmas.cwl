cwlVersion: v1.2
class: CommandLineTool
baseCommand: lmas
label: lmas
doc: "The provided text contains error logs from a container runtime environment and
  does not include the help documentation for the 'lmas' tool. As a result, no arguments
  or descriptions could be extracted.\n\nTool homepage: https://github.com/B-UMMI/LMAS"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/lmas:2.0.8--hdfd78af_0
stdout: lmas.out
