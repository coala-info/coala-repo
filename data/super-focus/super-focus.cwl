cwlVersion: v1.2
class: CommandLineTool
baseCommand: super-focus
label: super-focus
doc: "The provided text contains system error messages related to a failed container
  build/fetch operation and does not contain the help text or usage information for
  the tool 'super-focus'.\n\nTool homepage: https://edwards.sdsu.edu/SUPERFOCUS"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/super-focus:1.6--pyhdfd78af_1
stdout: super-focus.out
