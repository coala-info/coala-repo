cwlVersion: v1.2
class: CommandLineTool
baseCommand: quota_anchor
label: quota_anchor
doc: "The provided text does not contain help information for the tool. It contains
  error messages related to a container image build process.\n\nTool homepage: https://github.com/baoxingsong/quota_Anchor"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/quota_anchor:1.0.2--pyhdfd78af_0
stdout: quota_anchor.out
