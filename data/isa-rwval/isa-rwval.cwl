cwlVersion: v1.2
class: CommandLineTool
baseCommand: isa-rwval
label: isa-rwval
doc: "ISA-Tab Read, Write, and Validation tool\n\nTool homepage: https://github.com/ISA-tools/isa-rwval"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/isa-rwval:0.10.10--pyhdfd78af_0
stdout: isa-rwval.out
