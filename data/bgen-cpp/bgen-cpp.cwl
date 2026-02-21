cwlVersion: v1.2
class: CommandLineTool
baseCommand: bgen-cpp
label: bgen-cpp
doc: "The provided text does not contain help information for bgen-cpp; it is an error
  log from a container runtime (Apptainer/Singularity) indicating a failure to build
  or extract the OCI image due to insufficient disk space.\n\nTool homepage: https://enkre.net/cgi-bin/code/bgen/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bgen-cpp:1.1.7--h5ca1c30_0
stdout: bgen-cpp.out
