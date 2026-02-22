cwlVersion: v1.2
class: CommandLineTool
baseCommand: paleomix
label: paleomix
doc: "The provided text does not contain help information or documentation for the
  tool. It consists of system error messages related to a lack of disk space during
  a container execution attempt.\n\nTool homepage: https://github.com/MikkelSchubert/paleomix"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/paleomix:v1.2.13.3-1-deb_cv1
stdout: paleomix.out
