cwlVersion: v1.2
class: CommandLineTool
baseCommand: pylipid
label: pylipid
doc: "The provided text does not contain help information or documentation for the
  tool. It appears to be a log of a failed container build/fetch process.\n\nTool
  homepage: https://github.com/wlsong/PyLipID"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pylipid:1.5.14--pyhdfd78af_0
stdout: pylipid.out
