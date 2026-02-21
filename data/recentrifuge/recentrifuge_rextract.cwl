cwlVersion: v1.2
class: CommandLineTool
baseCommand: recentrifuge_rextract
label: recentrifuge_rextract
doc: "The provided text does not contain help information or usage instructions for
  the tool. It appears to be a log of a failed container build process.\n\nTool homepage:
  https://github.com/khyox/recentrifuge"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/recentrifuge:2.0.0--pyhdfd78af_0
stdout: recentrifuge_rextract.out
