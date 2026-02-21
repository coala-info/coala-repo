cwlVersion: v1.2
class: CommandLineTool
baseCommand: gnumed-common
label: gnumed-common
doc: The provided text does not contain help information for the tool. It is an error
  log indicating a failure to build a container image due to lack of disk space.
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/gnumed-common:v1.7.5dfsg-3-deb_cv1
stdout: gnumed-common.out
