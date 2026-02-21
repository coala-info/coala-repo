cwlVersion: v1.2
class: CommandLineTool
baseCommand: pirs-profiles
label: pirs-profiles
doc: "The provided text does not contain help information for the tool. It is an error
  log from a container runtime (Singularity/Apptainer) indicating a failure to build
  or extract the container image due to insufficient disk space.\n\nTool homepage:
  https://github.com/galaxy001/pirs"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/pirs-profiles:v2.0.2dfsg-8-deb_cv1
stdout: pirs-profiles.out
