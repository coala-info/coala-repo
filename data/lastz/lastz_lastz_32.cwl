cwlVersion: v1.2
class: CommandLineTool
baseCommand: lastz
label: lastz_lastz_32
doc: "The provided text does not contain help information for the tool. It is an error
  log indicating a failure to build a container image due to insufficient disk space.\n
  \nTool homepage: http://www.bx.psu.edu/~rsharris/lastz/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/lastz:1.04.52--h7b50bb2_1
stdout: lastz_lastz_32.out
