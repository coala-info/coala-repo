cwlVersion: v1.2
class: CommandLineTool
baseCommand: phamb
label: phamb
doc: "The provided text contains error logs related to a failed container build/extraction
  and does not include the help text or usage information for the 'phamb' tool.\n\n
  Tool homepage: https://github.com/RasmussenLab/phamb"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phamb:1.0.1--pyhdfd78af_0
stdout: phamb.out
