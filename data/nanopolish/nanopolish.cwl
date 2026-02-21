cwlVersion: v1.2
class: CommandLineTool
baseCommand: nanopolish
label: nanopolish
doc: "The provided text does not contain help information for nanopolish; it is a
  fatal error log from a container runtime (Singularity/Apptainer) indicating a failure
  to build the container image due to insufficient disk space.\n\nTool homepage: https://github.com/jts/nanopolish"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nanopolish:0.14.0--h5ca1c30_6
stdout: nanopolish.out
