cwlVersion: v1.2
class: CommandLineTool
baseCommand: recentrifuge_retaxdump
label: recentrifuge_retaxdump
doc: "The provided text does not contain help information or usage instructions; it
  is a log of a container build failure.\n\nTool homepage: https://github.com/khyox/recentrifuge"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/recentrifuge:2.0.0--pyhdfd78af_0
stdout: recentrifuge_retaxdump.out
