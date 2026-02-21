cwlVersion: v1.2
class: CommandLineTool
baseCommand: rop_rop.sh
label: rop_rop.sh
doc: "The provided text is a container runtime error log and does not contain help
  information or argument definitions for the tool.\n\nTool homepage: https://github.com/smangul1/rop"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rop:1.1.2--py27h516909a_0
stdout: rop_rop.sh.out
