cwlVersion: v1.2
class: CommandLineTool
baseCommand: pisad_run.sh
label: pisad_run.sh
doc: "The provided text is a system log indicating a container build failure (no space
  left on device) and does not contain help text, usage instructions, or argument
  definitions for the tool.\n\nTool homepage: https://github.com/ZhantianXu/PISAD"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pisad:1.2.0--pl5321h6f0a7f7_0
stdout: pisad_run.sh.out
