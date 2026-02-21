cwlVersion: v1.2
class: CommandLineTool
baseCommand: Circle-Map
label: circle-map
doc: "The provided text does not contain help information for the tool. It is an error
  log indicating a failure to build or extract a Singularity/Apptainer container image
  due to lack of disk space.\n\nTool homepage: https://github.com/iprada/Circle-Map"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/circle-map:1.1.4--pyh7e72e81_3
stdout: circle-map.out
