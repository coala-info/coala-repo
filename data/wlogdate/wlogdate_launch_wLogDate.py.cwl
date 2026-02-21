cwlVersion: v1.2
class: CommandLineTool
baseCommand: wlogdate_launch_wLogDate.py
label: wlogdate_launch_wLogDate.py
doc: "wLogDate: a tool for dating nodes in a phylogeny using a log-normal relaxed
  clock.\n\nTool homepage: https://github.com/uym2/wLogDate"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/wlogdate:1.0.4--pyhdfd78af_0
stdout: wlogdate_launch_wLogDate.py.out
