cwlVersion: v1.2
class: CommandLineTool
baseCommand: esimsa
label: esimsa
doc: "The provided text does not contain help information for the tool 'esimsa'. It
  contains error logs from a container runtime (Apptainer/Singularity) indicating
  a failure to pull the image due to insufficient disk space.\n\nTool homepage: http://www.ms-utils.org/esimsa.html"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/esimsa:1.0--0
stdout: esimsa.out
