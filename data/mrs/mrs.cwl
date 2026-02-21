cwlVersion: v1.2
class: CommandLineTool
baseCommand: mrs
label: mrs
doc: "The provided text does not contain help information for the 'mrs' tool. It appears
  to be an error log from a container runtime (Apptainer/Singularity) indicating a
  failure to pull or build the container image due to insufficient disk space.\n\n
  Tool homepage: https://github.com/ctu-mrs/mrs_uav_system"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/mrs:v6.0.5dfsg-2b2-deb_cv1
stdout: mrs.out
