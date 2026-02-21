cwlVersion: v1.2
class: CommandLineTool
baseCommand: jasminesv
label: jasminesv
doc: "The provided text is an error log indicating a failure to build or run the container
  image (no space left on device) and does not contain help text or argument definitions.\n
  \nTool homepage: https://github.com/mkirsche/Jasmine"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/jasminesv:1.1.5--hdfd78af_0
stdout: jasminesv.out
