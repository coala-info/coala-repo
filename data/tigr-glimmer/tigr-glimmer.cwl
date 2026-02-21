cwlVersion: v1.2
class: CommandLineTool
baseCommand: tigr-glimmer
label: tigr-glimmer
doc: The provided text does not contain help information or usage instructions for
  the tool. It contains container runtime log messages and a fatal error indicating
  a failure to fetch the OCI image.
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/tigr-glimmer:v3.02b-2-deb_cv1
stdout: tigr-glimmer.out
