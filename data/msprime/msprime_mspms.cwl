cwlVersion: v1.2
class: CommandLineTool
baseCommand: mspms
label: msprime_mspms
doc: "The provided text does not contain help information for the tool. It is a system
  error log indicating a failure to build a container image due to lack of disk space.\n
  \nTool homepage: https://github.com/tskit-dev/msprime"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/msprime:0.4.0--py34_gsl1.16_2
stdout: msprime_mspms.out
