cwlVersion: v1.2
class: CommandLineTool
baseCommand: kestrel
label: kestrel
doc: "A tool for structural variation discovery (Note: The provided text contains
  container runtime error logs rather than command-line help documentation).\n\nTool
  homepage: https://github.com/paudano/kestrel"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kestrel:1.0.3--hdfd78af_0
stdout: kestrel.out
