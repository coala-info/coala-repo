cwlVersion: v1.2
class: CommandLineTool
baseCommand: salmid
label: salmid
doc: "The provided text does not contain help information or a description of the
  tool; it is a log of a failed container build process.\n\nTool homepage: https://github.com/hcdenbakker/SalmID"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/salmid:v0.1.23-1-deb_cv1
stdout: salmid.out
