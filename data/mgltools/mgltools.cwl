cwlVersion: v1.2
class: CommandLineTool
baseCommand: mgltools
label: mgltools
doc: "The provided text does not contain help information for mgltools; it contains
  error logs from a container runtime (Apptainer/Singularity) indicating a failure
  to pull the image due to insufficient disk space.\n\nTool homepage: http://mgltools.scripps.edu/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mgltools:1.5.7--h9ee0642_1
stdout: mgltools.out
