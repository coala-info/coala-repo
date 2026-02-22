cwlVersion: v1.2
class: CommandLineTool
baseCommand: pbjelly
label: pbjelly
doc: "PBJelly is a genome assembly upgrading tool. (Note: The provided text contains
  system error messages regarding disk space and container conversion rather than
  the tool's help documentation.)\n\nTool homepage: https://github.com/esrice/PBJelly"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/pbjelly:v15.8.24dfsg-3-deb_cv1
stdout: pbjelly.out
