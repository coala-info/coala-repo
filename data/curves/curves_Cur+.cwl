cwlVersion: v1.2
class: CommandLineTool
baseCommand: Cur+
label: curves_Cur+
doc: "The provided text contains a system error log related to a container build failure
  ('no space left on device') and does not contain the help text or usage information
  for the tool 'curves_Cur+'. As a result, no arguments could be extracted.\n\nTool
  homepage: https://bisi.ibcp.fr/tools/curves_plus/index.html"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/curves:3.0.3--h70c14e6_1
stdout: curves_Cur+.out
