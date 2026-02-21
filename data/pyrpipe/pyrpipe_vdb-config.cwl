cwlVersion: v1.2
class: CommandLineTool
baseCommand: pyrpipe_vdb-config
label: pyrpipe_vdb-config
doc: "The provided text does not contain help documentation or usage instructions;
  it consists of system logs and a fatal error message related to fetching a container
  image.\n\nTool homepage: https://github.com/urmi-21/pyrpipe"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pyrpipe:0.0.5--py_0
stdout: pyrpipe_vdb-config.out
