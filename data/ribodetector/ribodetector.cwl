cwlVersion: v1.2
class: CommandLineTool
baseCommand: ribodetector
label: ribodetector
doc: "The provided text does not contain help information or usage instructions. It
  appears to be a log of a failed container build or image fetching process.\n\nTool
  homepage: https://github.com/hzi-bifo/RiboDetector"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ribodetector:0.3.3--pyhdfd78af_0
stdout: ribodetector.out
