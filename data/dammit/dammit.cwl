cwlVersion: v1.2
class: CommandLineTool
baseCommand: dammit
label: dammit
doc: "The provided text does not contain help information or usage instructions; it
  is a system error log indicating a failure to build or extract a container image
  due to insufficient disk space.\n\nTool homepage: http://dib-lab.github.io/dammit/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dammit:1.2--pyh5ca1d4c_0
stdout: dammit.out
