cwlVersion: v1.2
class: CommandLineTool
baseCommand: tmhg_tmhgf
label: tmhg_tmhgf
doc: "The provided text does not contain help information or a description of the
  tool; it is a log of a failed container build process.\n\nTool homepage: https://github.com/yongze-yin/tMHG-Finder/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tmhg:1.0.3--pyhdfd78af_0
stdout: tmhg_tmhgf.out
