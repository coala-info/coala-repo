cwlVersion: v1.2
class: CommandLineTool
baseCommand: wlogdate
label: wlogdate
doc: "A tool to add date/time information to log files.\n\nTool homepage: https://github.com/uym2/wLogDate"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/wlogdate:1.0.4--pyhdfd78af_0
stdout: wlogdate.out
