cwlVersion: v1.2
class: CommandLineTool
baseCommand: nasp
label: nasp
doc: "The provided text does not contain help information or a description of the
  tool. It appears to be an error log from a container runtime (Apptainer/Singularity)
  indicating a failure to build the container due to insufficient disk space.\n\n
  Tool homepage: https://github.com/TGenNorth/nasp"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nasp:1.2.1--py38hebad582_1
stdout: nasp.out
