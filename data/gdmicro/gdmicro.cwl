cwlVersion: v1.2
class: CommandLineTool
baseCommand: gdmicro
label: gdmicro
doc: "The provided text does not contain a description of the tool as it is an error
  log from a container runtime environment.\n\nTool homepage: https://github.com/liaoherui/GDmicro"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gdmicro:1.0.10--pyhdfd78af_0
stdout: gdmicro.out
