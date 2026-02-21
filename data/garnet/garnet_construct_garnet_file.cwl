cwlVersion: v1.2
class: CommandLineTool
baseCommand: garnet_construct_garnet_file
label: garnet_construct_garnet_file
doc: "A tool from the garnet package (Note: The provided text contains only system
  error logs and does not include usage instructions or argument definitions).\n\n
  Tool homepage: https://github.com/fraenkel-lab/GarNet"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/garnet:0.4.5--py35_0
stdout: garnet_construct_garnet_file.out
