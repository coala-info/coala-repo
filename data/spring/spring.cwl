cwlVersion: v1.2
class: CommandLineTool
baseCommand: spring
label: spring
doc: "The provided text does not contain help information or usage instructions. It
  appears to be a set of log messages from a container runtime (Apptainer/Singularity)
  that encountered a fatal error while attempting to fetch or build the image for
  the tool 'spring'.\n\nTool homepage: https://github.com/shubhamchandak94/Spring"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/spring:1.1.1--h4ac6f70_3
stdout: spring.out
