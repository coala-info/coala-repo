cwlVersion: v1.2
class: CommandLineTool
baseCommand: recentrifuge_refasplit
label: recentrifuge_refasplit
doc: "A utility from the Recentrifuge suite (Note: The provided text appears to be
  a container build log rather than help text, so no arguments could be extracted).\n
  \nTool homepage: https://github.com/khyox/recentrifuge"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/recentrifuge:2.0.0--pyhdfd78af_0
stdout: recentrifuge_refasplit.out
