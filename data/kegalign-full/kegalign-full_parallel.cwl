cwlVersion: v1.2
class: CommandLineTool
baseCommand: kegalign-full_parallel
label: kegalign-full_parallel
doc: "Note: The provided text does not contain help or usage information. It contains
  system error messages regarding a container runtime failure (no space left on device).\n
  \nTool homepage: https://github.com/galaxyproject/KegAlign"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kegalign-full:0.1.2.8--hdfd78af_0
stdout: kegalign-full_parallel.out
