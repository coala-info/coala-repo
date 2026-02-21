cwlVersion: v1.2
class: CommandLineTool
baseCommand: biom
label: python3-biom-format
doc: The provided text is an error log from a container build process and does not
  contain help information or argument definitions for the tool.
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/python3-biom-format:v2.1.5dfsg-7-deb_cv1
stdout: python3-biom-format.out
