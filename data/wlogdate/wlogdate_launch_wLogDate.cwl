cwlVersion: v1.2
class: CommandLineTool
baseCommand: wLogDate
label: wlogdate_launch_wLogDate
doc: "A tool for dating phylogenetic trees using a log-normal relaxed clock. (Note:
  The provided text appears to be a container runtime error log rather than CLI help
  text; therefore, no arguments could be extracted from the input.)\n\nTool homepage:
  https://github.com/uym2/wLogDate"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/wlogdate:1.0.4--pyhdfd78af_0
stdout: wlogdate_launch_wLogDate.out
