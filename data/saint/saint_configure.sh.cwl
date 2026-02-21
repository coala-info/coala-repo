cwlVersion: v1.2
class: CommandLineTool
baseCommand: saint_configure.sh
label: saint_configure.sh
doc: "Configuration script for SAINT (Significance Analysis of INTeractome). Note:
  The provided text contains container build logs and error messages rather than standard
  CLI help documentation.\n\nTool homepage: https://github.com/tiagorlampert/sAINT"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/saint:v2.5.0dfsg-3-deb_cv1
stdout: saint_configure.sh.out
