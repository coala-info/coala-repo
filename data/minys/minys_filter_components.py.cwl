cwlVersion: v1.2
class: CommandLineTool
baseCommand: minys_filter_components.py
label: minys_filter_components.py
doc: "Filter components in MinYS. (Note: The provided text contains container runtime
  error messages and does not include usage instructions or argument definitions.)\n
  \nTool homepage: https://github.com/cguyomar/MinYS"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/minys:1.1--h9948957_6
stdout: minys_filter_components.py.out
