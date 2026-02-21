cwlVersion: v1.2
class: CommandLineTool
baseCommand: gatb-core
label: gatb-core
doc: "The provided text does not contain help information for gatb-core; it is an
  error log from a container runtime (Singularity/Apptainer) indicating a failure
  to build the container image due to lack of disk space.\n\nTool homepage: https://gatb.inria.fr/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/gatb-core:v1.4.1git20181225.44d5a44dfsg-3-deb_cv1
stdout: gatb-core.out
