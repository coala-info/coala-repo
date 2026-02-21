cwlVersion: v1.2
class: CommandLineTool
baseCommand: primer3-py
label: primer3-py
doc: "The provided text does not contain help information or a description of the
  tool. It appears to be a fatal error log from a container runtime (Singularity/Apptainer)
  attempting to fetch a Docker image.\n\nTool homepage: https://github.com/libnano/primer3-py"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/primer3-py:2.3.0--py312h0fa9677_0
stdout: primer3-py.out
