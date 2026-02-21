cwlVersion: v1.2
class: CommandLineTool
baseCommand: murasaki-common
label: murasaki-common
doc: Common utilities for the Murasaki multiple genome aligner.
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/murasaki-common:v1.68.6-8-deb_cv1
stdout: murasaki-common.out
