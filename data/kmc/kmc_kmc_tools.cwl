cwlVersion: v1.2
class: CommandLineTool
baseCommand: kmc_tools
label: kmc_kmc_tools
doc: "The provided text does not contain help information for kmc_tools; it is an
  error message indicating a failure to build a container image due to lack of disk
  space.\n\nTool homepage: https://github.com/refresh-bio/kmc"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kmc:3.2.4--h5ca1c30_4
stdout: kmc_kmc_tools.out
