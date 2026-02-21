cwlVersion: v1.2
class: CommandLineTool
baseCommand: fastcov_fastcov.py
label: fastcov_fastcov.py
doc: "A parallel gcov wrapper for generating intermediate coverage formats. (Note:
  The provided text appears to be a container runtime error log rather than help text,
  so no arguments could be extracted.)\n\nTool homepage: https://github.com/RaverJay/fastcov"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fastcov:0.1.3--hdfd78af_0
stdout: fastcov_fastcov.py.out
