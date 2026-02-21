cwlVersion: v1.2
class: CommandLineTool
baseCommand: zamp
label: zamp
doc: "The provided text does not contain help information or a description of the
  tool; it consists of error logs from a container build process.\n\nTool homepage:
  https://github.com/metagenlab/zAMP/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/zamp:1.0.0--pyhdfd78af_1
stdout: zamp.out
