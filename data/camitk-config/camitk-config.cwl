cwlVersion: v1.2
class: CommandLineTool
baseCommand: camitk-config
label: camitk-config
doc: CamiTK configuration tool
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/camitk-config:v4.1.2-3-deb_cv1
stdout: camitk-config.out
