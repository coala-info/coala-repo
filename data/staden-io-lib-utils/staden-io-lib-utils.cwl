cwlVersion: v1.2
class: CommandLineTool
baseCommand: staden-io-lib-utils
label: staden-io-lib-utils
doc: The provided text does not contain help information or usage instructions for
  the tool. It appears to be a log of a failed container image build or execution
  attempt.
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/staden-io-lib-utils:v1.14.11-6-deb_cv1
stdout: staden-io-lib-utils.out
