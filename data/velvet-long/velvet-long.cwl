cwlVersion: v1.2
class: CommandLineTool
baseCommand: velvet-long
label: velvet-long
doc: "The provided text does not contain help information for velvet-long; it contains
  system error messages regarding a failed container execution due to insufficient
  disk space.\n\nTool homepage: https://github.com/rprokap/pset-9"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/velvet-long:v1.2.10dfsg1-5-deb_cv1
stdout: velvet-long.out
