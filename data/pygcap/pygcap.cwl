cwlVersion: v1.2
class: CommandLineTool
baseCommand: pygcap
label: pygcap
doc: "The provided text does not contain help information or usage instructions for
  the tool 'pygcap'. It appears to be a log of a failed container build/fetch process.\n
  \nTool homepage: https://github.com/jrim42/pyGCAP"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pygcap:1.2.6--pyhdfd78af_0
stdout: pygcap.out
