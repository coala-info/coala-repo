cwlVersion: v1.2
class: CommandLineTool
baseCommand: porfast
label: porfast
doc: "The provided text does not contain help information or a description for the
  tool; it is a log of a failed container build process.\n\nTool homepage: https://github.com/telatin/porfast"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/porfast:0.8.0--hbeb723e_0
stdout: porfast.out
