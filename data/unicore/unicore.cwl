cwlVersion: v1.2
class: CommandLineTool
baseCommand: unicore
label: unicore
doc: "The provided text does not contain help information or a description for the
  tool; it appears to be a log of a failed container build process.\n\nTool homepage:
  https://github.com/steineggerlab/unicore"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/unicore:1.1.1--h7ef3eeb_0
stdout: unicore.out
