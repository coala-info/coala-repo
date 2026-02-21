cwlVersion: v1.2
class: CommandLineTool
baseCommand: tinscan
label: tinscan
doc: "Tandem Integration Scanner (Note: The provided text is a container build log
  and does not contain CLI help information. No arguments could be extracted.)\n\n
  Tool homepage: https://github.com/Adamtaranto/TE-insertion-scanner"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tinscan:0.2.1--pyhdfd78af_0
stdout: tinscan.out
