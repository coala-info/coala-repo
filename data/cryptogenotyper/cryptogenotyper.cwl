cwlVersion: v1.2
class: CommandLineTool
baseCommand: cryptogenotyper
label: cryptogenotyper
doc: "A tool for cryptosporidium genotyper (Note: The provided text is a container
  build error log and does not contain help documentation. No arguments could be extracted.)\n
  \nTool homepage: https://github.com/phac-nml/CryptoGenotyper"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cryptogenotyper:1.5.0--pyhdfd78af_3
stdout: cryptogenotyper.out
