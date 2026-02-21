cwlVersion: v1.2
class: CommandLineTool
baseCommand: arvados-python-client
label: arvados-python-client
doc: "The provided text is a log of a failed container build process (Apptainer/Singularity)
  and does not contain help text, usage instructions, or argument definitions for
  the arvados-python-client tool.\n\nTool homepage: https://github.com/curoverse/arvados/tree/main/sdk/python"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/arvados-python-client:3.2.0--pyh7e72e81_0
stdout: arvados-python-client.out
