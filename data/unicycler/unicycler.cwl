cwlVersion: v1.2
class: CommandLineTool
baseCommand: unicycler
label: unicycler
doc: "The provided text does not contain help information or a description of the
  tool; it is an error log from a container build process.\n\nTool homepage: https://github.com/rrwick/Unicycler"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/unicycler:0.5.1--py312hdcc493e_5
stdout: unicycler.out
