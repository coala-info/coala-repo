cwlVersion: v1.2
class: CommandLineTool
baseCommand: twopaco_graphdump
label: twopaco_graphdump
doc: "The provided text does not contain help information or usage instructions for
  the tool. It consists of system log messages and a fatal error regarding a failed
  container build (No space left on device).\n\nTool homepage: https://github.com/medvedevgroup/TwoPaCo"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/twopaco:1.1.0--hc252753_1
stdout: twopaco_graphdump.out
