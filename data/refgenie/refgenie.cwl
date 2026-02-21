cwlVersion: v1.2
class: CommandLineTool
baseCommand: refgenie
label: refgenie
doc: "The provided text does not contain help information or a description of the
  tool; it appears to be a log of a failed container build/execution attempt.\n\n
  Tool homepage: http://refgenie.databio.org"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/refgenie:0.12.1--pyhdfd78af_0
stdout: refgenie.out
