cwlVersion: v1.2
class: CommandLineTool
baseCommand: proteowizard
label: proteowizard
doc: "The provided text does not contain help information or usage instructions for
  the tool. It appears to be a system log or error message related to a container
  build failure.\n\nTool homepage: https://github.com/PNNL-Comp-Mass-Spec/Proteowizard-Wrapper"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/proteowizard:3_0_25292_c9a6a18--h9948957_0
stdout: proteowizard.out
