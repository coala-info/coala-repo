cwlVersion: v1.2
class: CommandLineTool
baseCommand: kled
label: kled
doc: "K-mer based Long-read Error Detection (Note: The provided text contains container
  runtime error logs rather than tool help documentation. No arguments could be extracted
  from the input.)\n\nTool homepage: https://github.com/CoREse/kled"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kled:1.2.10--h4f462e4_0
stdout: kled.out
