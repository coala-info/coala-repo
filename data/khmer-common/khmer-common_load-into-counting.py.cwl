cwlVersion: v1.2
class: CommandLineTool
baseCommand: load-into-counting.py
label: khmer-common_load-into-counting.py
doc: "The provided text does not contain help information or usage instructions. It
  contains system log messages and a fatal error regarding disk space during a container
  build process.\n\nTool homepage: https://khmer.readthedocs.io/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/khmer-common:v2.1.2dfsg-6-deb_cv1
stdout: khmer-common_load-into-counting.py.out
