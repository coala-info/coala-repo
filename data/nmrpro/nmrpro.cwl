cwlVersion: v1.2
class: CommandLineTool
baseCommand: nmrpro
label: nmrpro
doc: "NMRPro: Nuclear Magnetic Resonance Processing and Analysis. (Note: The provided
  text contains container runtime error messages and does not list specific command-line
  arguments.)\n\nTool homepage: https://github.com/ahmohamed/nmrpro"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nmrpro:20161019--py35_0
stdout: nmrpro.out
