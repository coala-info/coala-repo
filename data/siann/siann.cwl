cwlVersion: v1.2
class: CommandLineTool
baseCommand: siann
label: siann
doc: "The provided text does not contain help information or usage instructions for
  the tool 'siann'. It appears to be a log of a failed container build/fetch process.\n
  \nTool homepage: https://github.com/signaturescience/siann/wiki"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/siann:1.3--hdfd78af_0
stdout: siann.out
