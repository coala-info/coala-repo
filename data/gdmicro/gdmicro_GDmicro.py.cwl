cwlVersion: v1.2
class: CommandLineTool
baseCommand: gdmicro_GDmicro.py
label: gdmicro_GDmicro.py
doc: "GDmicro tool (Note: The provided help text contains only system error logs and
  no usage information).\n\nTool homepage: https://github.com/liaoherui/GDmicro"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gdmicro:1.0.10--pyhdfd78af_0
stdout: gdmicro_GDmicro.py.out
