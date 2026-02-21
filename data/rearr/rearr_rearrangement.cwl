cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - rearr
  - rearrangement
label: rearr_rearrangement
doc: "The provided text does not contain help information or usage instructions for
  the tool. It appears to be a log of a failed container build/fetch process.\n\n
  Tool homepage: https://github.com/ljw20180420/sx_lcy"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rearr:1.0.11--h9948957_0
stdout: rearr_rearrangement.out
