cwlVersion: v1.2
class: CommandLineTool
baseCommand: psascan
label: psascan
doc: "The provided text does not contain help information for psascan; it is a log
  of a failed container build process. No arguments or tool descriptions could be
  extracted from the input.\n\nTool homepage: https://www.cs.helsinki.fi/group/pads/pSAscan.html"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/psascan:0.1.0--h9948957_5
stdout: psascan.out
