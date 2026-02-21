cwlVersion: v1.2
class: CommandLineTool
baseCommand: shovill-se
label: shovill-se_shovill
doc: "The provided text does not contain help documentation or usage instructions.
  It appears to be a system error log related to a container image build failure.\n
  \nTool homepage: https://github.com/rpetit3/shovill"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/shovill-se:1.1.0se--hdfd78af_2
stdout: shovill-se_shovill.out
