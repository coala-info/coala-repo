cwlVersion: v1.2
class: CommandLineTool
baseCommand: moabs
label: moabs
doc: "The provided text does not contain help information or a description of the
  tool; it is an error log from a container runtime (Apptainer/Singularity) indicating
  a failure to pull the image due to insufficient disk space.\n\nTool homepage: https://github.com/sunnyisgalaxy/moabs"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/moabs:1.3.9.6--h3e6c209_8
stdout: moabs.out
