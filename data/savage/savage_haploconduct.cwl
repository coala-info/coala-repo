cwlVersion: v1.2
class: CommandLineTool
baseCommand: savage_haploconduct
label: savage_haploconduct
doc: "The provided text does not contain help information for savage_haploconduct;
  it contains error logs related to a container build failure.\n\nTool homepage: https://github.com/HaploConduct/HaploConduct/tree/master/savage"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/savage:0.4.2--py27h3e4de3e_0
stdout: savage_haploconduct.out
