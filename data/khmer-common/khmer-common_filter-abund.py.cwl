cwlVersion: v1.2
class: CommandLineTool
baseCommand: khmer-common_filter-abund.py
label: khmer-common_filter-abund.py
doc: "The provided text does not contain help information for the tool. It contains
  system error messages related to a container runtime failure (no space left on device).\n
  \nTool homepage: https://khmer.readthedocs.io/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/khmer-common:v2.1.2dfsg-6-deb_cv1
stdout: khmer-common_filter-abund.py.out
