cwlVersion: v1.2
class: CommandLineTool
baseCommand: ksw
label: ksw
doc: "The provided text contains container runtime error messages and does not include
  help documentation or usage instructions for the tool 'ksw'.\n\nTool homepage: https://github.com/nh13/ksw"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ksw:0.2.3--h43eeafb_0
stdout: ksw.out
