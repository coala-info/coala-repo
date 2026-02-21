cwlVersion: v1.2
class: CommandLineTool
baseCommand: presto
label: presto
doc: "The provided text does not contain help information or usage instructions. It
  appears to be a log of a failed container build/fetch process for the 'presto' tool.\n
  \nTool homepage: http://presto.readthedocs.io"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/presto:0.7.8--pyhdfd78af_0
stdout: presto.out
