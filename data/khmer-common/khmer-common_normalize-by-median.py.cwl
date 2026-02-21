cwlVersion: v1.2
class: CommandLineTool
baseCommand: normalize-by-median.py
label: khmer-common_normalize-by-median.py
doc: "The provided text does not contain help information or usage instructions. It
  contains system log messages and a fatal error indicating that the container image
  could not be built because there is no space left on the device.\n\nTool homepage:
  https://khmer.readthedocs.io/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/khmer-common:v2.1.2dfsg-6-deb_cv1
stdout: khmer-common_normalize-by-median.py.out
