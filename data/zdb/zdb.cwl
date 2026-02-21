cwlVersion: v1.2
class: CommandLineTool
baseCommand: zdb
label: zdb
doc: "The provided text does not contain help information or a description of the
  tool. It appears to be a log of a failed container build process.\n\nTool homepage:
  https://github.com/metagenlab/zDB/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/zdb:1.3.11--hdfd78af_0
stdout: zdb.out
