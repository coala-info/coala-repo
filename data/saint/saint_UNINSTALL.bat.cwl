cwlVersion: v1.2
class: CommandLineTool
baseCommand: saint_UNINSTALL.bat
label: saint_UNINSTALL.bat
doc: "Uninstall script for SAINT. Note: The provided help text contains execution
  logs and error messages rather than usage instructions.\n\nTool homepage: https://github.com/tiagorlampert/sAINT"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/saint:v2.5.0dfsg-3-deb_cv1
stdout: saint_UNINSTALL.bat.out
