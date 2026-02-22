cwlVersion: v1.2
class: CommandLineTool
baseCommand: anadama2
label: anadama2
doc: "AnADAMA2 (Another Automated Data Management and Analysis) is a tool to create
  and run workflows.\n\nTool homepage: http://huttenhower.sph.harvard.edu/anadama2"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/anadama2:0.10.0--pyhdfd78af_0
stdout: anadama2.out
