cwlVersion: v1.2
class: CommandLineTool
baseCommand: stoatydive
label: stoatydive
doc: "The provided text does not contain help information or a description of the
  tool; it contains error logs from a container build process.\n\nTool homepage: https://github.com/heylf/StoatyDive"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/stoatydive:1.1.1--pyh5e36f6f_0
stdout: stoatydive.out
