cwlVersion: v1.2
class: CommandLineTool
baseCommand: kractor
label: kractor
doc: "The provided text does not contain help information or a description of the
  tool; it contains system error logs related to a container runtime failure.\n\n
  Tool homepage: https://github.com/Sam-Sims/kractor"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kractor:4.0.0--h4349ce8_0
stdout: kractor.out
