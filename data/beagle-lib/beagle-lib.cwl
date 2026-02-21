cwlVersion: v1.2
class: CommandLineTool
baseCommand: beagle-lib
label: beagle-lib
doc: "The provided text is a system error log regarding a container build failure
  (no space left on device) and does not contain CLI help information or usage instructions
  for beagle-lib.\n\nTool homepage: https://github.com/beagle-dev/beagle-lib"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/beagle-lib:4.0.1--h9948957_3
stdout: beagle-lib.out
