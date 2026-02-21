cwlVersion: v1.2
class: CommandLineTool
baseCommand: ldhelmet
label: ldhelmet
doc: "The provided text does not contain help information for ldhelmet. It appears
  to be an error log from a container runtime (Apptainer/Singularity) indicating a
  failure to build the container image due to insufficient disk space.\n\nTool homepage:
  http://sourceforge.net/projects/ldhelmet/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ldhelmet:1.10--h400b186_3
stdout: ldhelmet.out
