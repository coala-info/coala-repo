cwlVersion: v1.2
class: CommandLineTool
baseCommand: plasmar
label: plasmar
doc: "The provided text is an error log from a container build process and does not
  contain help information or usage instructions for the 'plasmar' tool. As a result,
  no arguments could be extracted.\n\nTool homepage: https://https://github.com/rastanton/PLASMAR"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/plasmar:1.5--hdfd78af_0
stdout: plasmar.out
