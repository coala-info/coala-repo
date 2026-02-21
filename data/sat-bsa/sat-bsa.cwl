cwlVersion: v1.2
class: CommandLineTool
baseCommand: sat-bsa
label: sat-bsa
doc: "The provided text does not contain help information or usage instructions for
  the tool 'sat-bsa'. It appears to be a log of a failed container image retrieval/build
  process.\n\nTool homepage: https://github.com/SegawaTenta/Sat-BSA"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sat-bsa:1.12--hdfd78af_1
stdout: sat-bsa.out
