cwlVersion: v1.2
class: CommandLineTool
baseCommand: run-calling
label: fermikit_run-calling
doc: "The provided text does not contain help information for the tool, but appears
  to be a system error log regarding a container build failure (no space left on device).\n
  \nTool homepage: https://github.com/lh3/fermikit"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fermikit:0.14.dev1--pl5321h86e5fe9_2
stdout: fermikit_run-calling.out
