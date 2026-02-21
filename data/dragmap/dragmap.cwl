cwlVersion: v1.2
class: CommandLineTool
baseCommand: dragmap
label: dragmap
doc: "The provided text does not contain help information for the tool; it is an error
  log from a container runtime (Apptainer/Singularity) indicating a failure to build
  the image due to insufficient disk space.\n\nTool homepage: https://github.com/Illumina/DRAGMAP"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dragmap:1.3.0--h5ca1c30_7
stdout: dragmap.out
