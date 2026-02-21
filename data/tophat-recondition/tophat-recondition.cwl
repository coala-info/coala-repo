cwlVersion: v1.2
class: CommandLineTool
baseCommand: tophat-recondition
label: tophat-recondition
doc: "The provided text does not contain help information for the tool; it is a log
  of a failed container build process.\n\nTool homepage: https://github.com/cbrueffer/tophat-recondition"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tophat-recondition:1.4--py35_0
stdout: tophat-recondition.out
