cwlVersion: v1.2
class: CommandLineTool
baseCommand: megahit
label: megahit
doc: "The provided text does not contain help information or a description of the
  tool; it is an error log reporting a failure to build a container image due to insufficient
  disk space.\n\nTool homepage: https://github.com/voutcn/megahit"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/megahit:1.2.9--haf24da9_8
stdout: megahit.out
