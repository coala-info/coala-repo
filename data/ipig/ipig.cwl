cwlVersion: v1.2
class: CommandLineTool
baseCommand: ipig
label: ipig
doc: "The provided text does not contain help information for the 'ipig' tool; it
  contains a fatal error message from a container runtime (Apptainer/Singularity)
  indicating a 'no space left on device' error while attempting to pull the image.\n
  \nTool homepage: https://github.com/Greysahy/ipiguard"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/ipig:v0.0.r5-3-deb_cv1
stdout: ipig.out
