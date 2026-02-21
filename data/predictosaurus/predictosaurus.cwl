cwlVersion: v1.2
class: CommandLineTool
baseCommand: predictosaurus
label: predictosaurus
doc: "The provided text does not contain help information or usage instructions for
  predictosaurus. It appears to be a log of a failed container build/pull process.\n
  \nTool homepage: https://github.com/fxwiegand/predictosaurus"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/predictosaurus:0.8.3--hbcba35e_0
stdout: predictosaurus.out
