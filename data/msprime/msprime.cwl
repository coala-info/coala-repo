cwlVersion: v1.2
class: CommandLineTool
baseCommand: msprime
label: msprime
doc: "The provided text does not contain a description of the tool, as it consists
  of container runtime error logs.\n\nTool homepage: https://github.com/tskit-dev/msprime"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/msprime:0.4.0--py34_gsl1.16_2
stdout: msprime.out
