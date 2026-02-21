cwlVersion: v1.2
class: CommandLineTool
baseCommand: sscocaller
label: sscocaller
doc: "The provided text is a container build log and does not contain the help documentation
  or usage instructions for the sscocaller tool.\n\nTool homepage: https://gitlab.svi.edu.au/biocellgen-public/sscocaller"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sscocaller:0.2.2--hda81887_4
stdout: sscocaller.out
