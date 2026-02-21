cwlVersion: v1.2
class: CommandLineTool
baseCommand: mrs_catkin
label: mrs_catkin
doc: "The provided text is an error log from a container runtime (Apptainer/Singularity)
  indicating a failure to build or pull a container image due to insufficient disk
  space. It does not contain command-line help information or argument definitions.\n
  \nTool homepage: https://github.com/ctu-mrs/mrs_uav_system"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/mrs:v6.0.5dfsg-2b2-deb_cv1
stdout: mrs_catkin.out
