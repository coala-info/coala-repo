cwlVersion: v1.2
class: CommandLineTool
baseCommand: tracer
label: tracer
doc: "The provided text does not contain help information or usage instructions. It
  consists of error logs related to a failed container build (no space left on device).\n
  \nTool homepage: http://beast.community/tracer"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tracer:1.7.2--hdfd78af_0
stdout: tracer.out
