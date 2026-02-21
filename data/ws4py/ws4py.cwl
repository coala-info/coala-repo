cwlVersion: v1.2
class: CommandLineTool
baseCommand: ws4py
label: ws4py
doc: "The provided text does not contain help information for the tool 'ws4py'; it
  contains error logs from a container build process (Apptainer/Singularity) attempting
  to fetch a Docker image.\n\nTool homepage: https://github.com/belisarius222/ws4py-reconnect"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ws4py:0.3.2--py36_0
stdout: ws4py.out
