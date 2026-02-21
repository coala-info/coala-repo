cwlVersion: v1.2
class: CommandLineTool
baseCommand: privateer
label: privateer
doc: "The provided text does not contain help information or a description of the
  tool. It appears to be a log of a failed container build/execution attempt.\n\n
  Tool homepage: https://github.com/glycojones/privateer"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/privateer:MKV--py312h490764d_2
stdout: privateer.out
