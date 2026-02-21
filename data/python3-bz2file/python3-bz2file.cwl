cwlVersion: v1.2
class: CommandLineTool
baseCommand: python3-bz2file
label: python3-bz2file
doc: The provided text is an error log from a container build process and does not
  contain help documentation or usage instructions for the tool.
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/python3-bz2file:v0.98-1-deb_cv1
stdout: python3-bz2file.out
