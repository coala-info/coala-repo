cwlVersion: v1.2
class: CommandLineTool
baseCommand: pycov3
label: pycov3
doc: "The provided text is a container build error log and does not contain CLI help
  information or argument definitions for pycov3.\n\nTool homepage: https://github.com/Ulthran/pycov3"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pycov3:2.1.0--pyh7cba7a3_0
stdout: pycov3.out
