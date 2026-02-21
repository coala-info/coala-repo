cwlVersion: v1.2
class: CommandLineTool
baseCommand: urllib3
label: urllib3
doc: "The provided text appears to be a log from a container build process (Apptainer/Singularity)
  rather than help text for the urllib3 tool. urllib3 is primarily a Python HTTP library
  and does not typically provide a standalone command-line interface with the arguments
  described in the log.\n\nTool homepage: https://github.com/urllib3/urllib3"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/urllib3:1.25.9
stdout: urllib3.out
