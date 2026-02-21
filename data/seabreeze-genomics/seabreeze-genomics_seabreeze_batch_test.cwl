cwlVersion: v1.2
class: CommandLineTool
baseCommand: seabreeze_batch_test
label: seabreeze-genomics_seabreeze_batch_test
doc: "The provided text does not contain help information for the tool; it is a log
  of a failed container build process due to insufficient disk space.\n\nTool homepage:
  https://github.com/barricklab/seabreeze"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/seabreeze-genomics:1.5.0--pyhdfd78af_0
stdout: seabreeze-genomics_seabreeze_batch_test.out
