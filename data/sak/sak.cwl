cwlVersion: v1.2
class: CommandLineTool
baseCommand: sak
label: sak
doc: "The provided text does not contain help information or usage instructions for
  the tool 'sak'. It appears to be a log of a failed container build/fetch process.\n
  \nTool homepage: https://github.com/seqan/seqan/tree/master/apps/sak"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sak:0.4.8--h9948957_0
stdout: sak.out
