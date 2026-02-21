cwlVersion: v1.2
class: CommandLineTool
baseCommand: protmapper
label: protmapper
doc: "The provided text does not contain help information or usage instructions for
  the tool. It appears to be a log of a failed container build/fetch process.\n\n
  Tool homepage: https://github.com/indralab/protmapper"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/protmapper:0.0.29--pyhdfd78af_0
stdout: protmapper.out
