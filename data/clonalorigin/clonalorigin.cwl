cwlVersion: v1.2
class: CommandLineTool
baseCommand: clonalorigin
label: clonalorigin
doc: "The provided text does not contain help information or a description of the
  tool; it is a system error log reporting a failure to build a container image due
  to insufficient disk space.\n\nTool homepage: https://github.com/xavierdidelot/ClonalOrigin"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/clonalorigin:v1.0-3-deb_cv1
stdout: clonalorigin.out
