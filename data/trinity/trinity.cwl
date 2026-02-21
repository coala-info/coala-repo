cwlVersion: v1.2
class: CommandLineTool
baseCommand: Trinity
label: trinity
doc: "The provided text is a system error log indicating a failed container build
  (no space left on device) and does not contain help text or command-line argument
  definitions.\n\nTool homepage: https://github.com/TrinityCore/TrinityCore"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/trinity:2.15.2--pl5321h077b44d_6
stdout: trinity.out
