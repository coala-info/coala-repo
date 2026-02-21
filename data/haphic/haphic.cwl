cwlVersion: v1.2
class: CommandLineTool
baseCommand: haphic
label: haphic
doc: "HaPhic (Note: The provided text is a container execution error and does not
  contain help information or argument definitions).\n\nTool homepage: https://github.com/zengxiaofei/HapHiC"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/haphic:1.0.7--hdfd78af_0
stdout: haphic.out
