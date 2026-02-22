cwlVersion: v1.2
class: CommandLineTool
baseCommand: bsmap
label: bsmap
doc: "The provided text is an error log indicating a system failure ('no space left
  on device') during a container pull/conversion process and does not contain the
  tool's help text or usage information.\n\nTool homepage: https://code.google.com/archive/p/bsmap/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bsmap:2.90--py27_0
stdout: bsmap.out
