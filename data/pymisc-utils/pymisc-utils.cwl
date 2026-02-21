cwlVersion: v1.2
class: CommandLineTool
baseCommand: pymisc-utils
label: pymisc-utils
doc: "The provided text does not contain help information or usage instructions for
  the tool. It appears to be a log of a failed container build process.\n\nTool homepage:
  https://github.com/dieterich-lab/pymisc-utils"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pymisc-utils:0.2.11--py36h37e70f2_0
stdout: pymisc-utils.out
