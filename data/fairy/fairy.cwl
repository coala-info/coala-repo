cwlVersion: v1.2
class: CommandLineTool
baseCommand: fairy
label: fairy
doc: "A tool for collecting and analyzing bioinformatics software metadata (Note:
  The provided help text contains only container runtime error messages and no usage
  information).\n\nTool homepage: https://github.com/bluenote-1577/fairy"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fairy:0.5.8--hc1c3326_0
stdout: fairy.out
