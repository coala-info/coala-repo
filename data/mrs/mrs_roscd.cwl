cwlVersion: v1.2
class: CommandLineTool
baseCommand: mrs_roscd
label: mrs_roscd
doc: "The provided text is an error log from a container runtime (Apptainer/Singularity)
  and does not contain help information or argument definitions for the tool 'mrs_roscd'.\n
  \nTool homepage: https://github.com/ctu-mrs/mrs_uav_system"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/mrs:v6.0.5dfsg-2b2-deb_cv1
stdout: mrs_roscd.out
