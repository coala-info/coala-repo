cwlVersion: v1.2
class: CommandLineTool
baseCommand: vapor_vapor.py
label: vapor_vapor.py
doc: "The provided text does not contain help information or a description of the
  tool; it is a log of a failed container build process.\n\nTool homepage: https://github.com/connor-lab/vapor"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vapor:1.0.3--pyhdfd78af_0
stdout: vapor_vapor.py.out
