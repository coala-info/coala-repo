cwlVersion: v1.2
class: CommandLineTool
baseCommand: pyrpipe
label: pyrpipe
doc: "The provided text does not contain help information for pyrpipe; it contains
  error logs from a container runtime (Apptainer/Singularity) attempting to fetch
  the tool's image.\n\nTool homepage: https://github.com/urmi-21/pyrpipe"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pyrpipe:0.0.5--py_0
stdout: pyrpipe.out
