cwlVersion: v1.2
class: CommandLineTool
baseCommand: recentrifuge
label: recentrifuge
doc: "The provided text does not contain help information or a description of the
  tool; it contains container build logs and a fatal error message.\n\nTool homepage:
  https://github.com/khyox/recentrifuge"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/recentrifuge:2.0.0--pyhdfd78af_0
stdout: recentrifuge.out
