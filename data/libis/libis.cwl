cwlVersion: v1.2
class: CommandLineTool
baseCommand: libis
label: libis
doc: "The provided text does not contain help information or a description of the
  tool; it contains system error logs related to a container runtime (Apptainer/Singularity)
  failure.\n\nTool homepage: https://github.com/Dangertrip/LiBis"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/libis:0.1.6--py_0
stdout: libis.out
