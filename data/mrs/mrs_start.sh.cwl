cwlVersion: v1.2
class: CommandLineTool
baseCommand: mrs_start.sh
label: mrs_start.sh
doc: "The provided text does not contain help information or a description of the
  tool's functionality. It contains error logs related to a container runtime (Apptainer/Singularity)
  failure while attempting to pull the 'mrs' image.\n\nTool homepage: https://github.com/ctu-mrs/mrs_uav_system"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/mrs:v6.0.5dfsg-2b2-deb_cv1
stdout: mrs_start.sh.out
