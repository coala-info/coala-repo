cwlVersion: v1.2
class: CommandLineTool
baseCommand: bis-snp-utils
label: bis-snp-utils
doc: "The provided text does not contain help information or usage instructions for
  the tool. It contains system error messages related to container execution and disk
  space issues.\n\nTool homepage: http://people.csail.mit.edu/dnaase/bissnp2011/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bis-snp-utils:0.0.1--pl5.22.0_0
stdout: bis-snp-utils.out
