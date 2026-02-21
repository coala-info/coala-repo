cwlVersion: v1.2
class: CommandLineTool
baseCommand: gottcha_INSTALL.sh
label: gottcha_INSTALL.sh
doc: "Installation script for GOTTCHA. (Note: The provided text contains runtime error
  logs regarding container image conversion and disk space, rather than command-line
  usage instructions.)\n\nTool homepage: https://github.com/poeli/GOTTCHA"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gottcha:1.0--pl526_2
stdout: gottcha_INSTALL.sh.out
