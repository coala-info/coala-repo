cwlVersion: v1.2
class: CommandLineTool
baseCommand: marge
label: marge
doc: "The provided text does not contain help information for the tool 'marge'. It
  contains error logs from a container runtime (Apptainer/Singularity) indicating
  a failure to build the container image due to lack of disk space.\n\nTool homepage:
  http://cistrome.org/MARGE"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/marge:1.0--py35h24bf2e0_1
stdout: marge.out
