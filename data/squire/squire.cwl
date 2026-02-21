cwlVersion: v1.2
class: CommandLineTool
baseCommand: squire
label: squire
doc: "The provided text does not contain help information or usage instructions for
  the tool 'squire'. It appears to be a log of a failed container build process.\n
  \nTool homepage: https://github.com/wyang17/SQuIRE"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/squire:0.9.9.92--pyhdfd78af_1
stdout: squire.out
