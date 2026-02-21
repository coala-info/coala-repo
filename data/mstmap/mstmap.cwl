cwlVersion: v1.2
class: CommandLineTool
baseCommand: mstmap
label: mstmap
doc: "The provided text does not contain help information for mstmap; it contains
  system error messages related to a container runtime (Singularity/Apptainer) failure
  due to insufficient disk space.\n\nTool homepage: http://mstmap.org/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mstmap:1--h4ac6f70_3
stdout: mstmap.out
