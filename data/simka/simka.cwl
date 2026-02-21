cwlVersion: v1.2
class: CommandLineTool
baseCommand: simka
label: simka
doc: "The provided text does not contain help information for the tool; it is a log
  of a failed container build process.\n\nTool homepage: https://github.com/GATB/simka"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/simka:1.5.3--he513fc3_0
stdout: simka.out
