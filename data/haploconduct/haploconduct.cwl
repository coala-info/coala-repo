cwlVersion: v1.2
class: CommandLineTool
baseCommand: haploconduct
label: haploconduct
doc: "HaploConduct is a tool for reconstruction of individual haplotypes from next-generation
  sequencing data. (Note: The provided text is a container execution error log and
  does not contain usage instructions or argument definitions).\n\nTool homepage:
  https://github.com/HaploConduct/HaploConduct"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/haploconduct:0.2.1--py27h78a066a_0
stdout: haploconduct.out
