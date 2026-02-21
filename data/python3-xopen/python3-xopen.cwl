cwlVersion: v1.2
class: CommandLineTool
baseCommand: xopen
label: python3-xopen
doc: The provided text does not contain help documentation; it is a log of a failed
  container build process. No command-line arguments or descriptions could be extracted.
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/python3-xopen:v0.1.1-1-deb_cv1
stdout: python3-xopen.out
