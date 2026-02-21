cwlVersion: v1.2
class: CommandLineTool
baseCommand: king-probe
label: king-probe
doc: "The provided text does not contain help information or a description of the
  tool; it is an error log from a container runtime (Apptainer/Singularity) indicating
  a failure to build the container image due to insufficient disk space.\n\nTool homepage:
  http://people.virginia.edu/~wc9c/KING/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/king-probe:v2.16.160404git20180613.a09b012-1-deb_cv1
stdout: king-probe.out
