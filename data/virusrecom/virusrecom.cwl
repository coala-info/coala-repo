cwlVersion: v1.2
class: CommandLineTool
baseCommand: virusrecom
label: virusrecom
doc: "The provided text contains system logs and a fatal error message regarding a
  container build process rather than the tool's help documentation. Consequently,
  no arguments or functional descriptions could be extracted from this specific input.\n
  \nTool homepage: https://github.com/ZhijianZhou01/virusrecom"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/virusrecom:1.4.0--pyhdfd78af_0
stdout: virusrecom.out
