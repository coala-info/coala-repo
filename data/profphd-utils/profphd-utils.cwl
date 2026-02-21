cwlVersion: v1.2
class: CommandLineTool
baseCommand: profphd-utils
label: profphd-utils
doc: The provided text does not contain help information; it is a log of a failed
  container build/fetch process for the profphd-utils image.
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/profphd-utils:v1.0.10-5-deb_cv1
stdout: profphd-utils.out
