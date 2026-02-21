cwlVersion: v1.2
class: CommandLineTool
baseCommand: primer3_core
label: primer3-py_primer3_core
doc: "The provided text does not contain help information for the tool. It appears
  to be a fatal error log from a container runtime (Singularity/Apptainer) failing
  to fetch or build the image.\n\nTool homepage: https://github.com/libnano/primer3-py"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/primer3-py:2.3.0--py312h0fa9677_0
stdout: primer3-py_primer3_core.out
