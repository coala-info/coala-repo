cwlVersion: v1.2
class: CommandLineTool
baseCommand: agrind
label: grinder_agrind
doc: "The provided text does not contain help information; it is an error log from
  a container runtime (Singularity/Apptainer) failure while attempting to pull the
  Grinder container image.\n\nTool homepage: https://github.com/rcoh/angle-grinder"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/grinder:v0.5.4-5-deb_cv1
stdout: grinder_agrind.out
