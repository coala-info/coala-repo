cwlVersion: v1.2
class: CommandLineTool
baseCommand: mason
label: mason
doc: "The provided text does not contain help information for the tool 'mason'. It
  contains error logs related to a container runtime (Apptainer/Singularity) failing
  to build a SIF image due to insufficient disk space.\n\nTool homepage: https://www.seqan.de/apps/mason.html"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mason:2.0.12--haf24da9_1
stdout: mason.out
