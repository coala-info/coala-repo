cwlVersion: v1.2
class: CommandLineTool
baseCommand: suppa_suppa.py
label: suppa_suppa.py
doc: "The provided text does not contain help information or usage instructions; it
  is a log of a fatal error during a container build/fetch process.\n\nTool homepage:
  https://github.com/comprna/SUPPA"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/suppa:2.4--pyhdfd78af_0
stdout: suppa_suppa.py.out
