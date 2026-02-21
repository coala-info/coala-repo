cwlVersion: v1.2
class: CommandLineTool
baseCommand: clever-toolkit
label: clever-toolkit
doc: "The provided text does not contain help information or a description of the
  tool's functionality; it is a log of a failed container build process.\n\nTool homepage:
  https://bitbucket.org/tobiasmarschall/clever-toolkit"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/clever-toolkit:2.4--h077b44d_14
stdout: clever-toolkit.out
