cwlVersion: v1.2
class: CommandLineTool
baseCommand: tmhg
label: tmhg
doc: "The provided text does not contain help information or usage instructions for
  the 'tmhg' tool. It consists of system logs and a fatal error message related to
  a container build process.\n\nTool homepage: https://github.com/yongze-yin/tMHG-Finder/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tmhg:1.0.3--pyhdfd78af_0
stdout: tmhg.out
