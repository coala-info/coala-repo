cwlVersion: v1.2
class: CommandLineTool
baseCommand: tatajuba
label: tatajuba
doc: "A tool for alignment-free sequence comparison (Note: The provided input text
  was a container build log and did not contain help documentation).\n\nTool homepage:
  https://github.com/quadram-institute-bioscience/tatajuba"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tatajuba:1.0.4--h577a1d6_4
stdout: tatajuba.out
