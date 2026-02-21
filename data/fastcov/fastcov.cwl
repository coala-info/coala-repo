cwlVersion: v1.2
class: CommandLineTool
baseCommand: fastcov
label: fastcov
doc: "A parallelized gcov wrapper for generating intermediate coverage formats (Note:
  The provided text contains error logs from a container runtime and does not include
  specific help documentation or argument details).\n\nTool homepage: https://github.com/RaverJay/fastcov"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fastcov:0.1.3--hdfd78af_0
stdout: fastcov.out
