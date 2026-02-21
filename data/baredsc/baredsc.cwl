cwlVersion: v1.2
class: CommandLineTool
baseCommand: baredsc
label: baredsc
doc: "The provided text does not contain help information for the tool 'baredsc'.
  It contains system log messages and a fatal error regarding a container build failure
  (no space left on device).\n\nTool homepage: https://github.com/lldelisle/baredSC/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/baredsc:1.1.3--pyhdfd78af_0
stdout: baredsc.out
