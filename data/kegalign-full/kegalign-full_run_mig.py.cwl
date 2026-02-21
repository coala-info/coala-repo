cwlVersion: v1.2
class: CommandLineTool
baseCommand: kegalign-full_run_mig.py
label: kegalign-full_run_mig.py
doc: "The provided text does not contain help information or usage instructions for
  the tool. It contains container runtime log messages indicating a failure to build
  a SIF image due to insufficient disk space.\n\nTool homepage: https://github.com/galaxyproject/KegAlign"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kegalign-full:0.1.2.8--hdfd78af_0
stdout: kegalign-full_run_mig.py.out
