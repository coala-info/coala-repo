cwlVersion: v1.2
class: CommandLineTool
baseCommand: emboss-data
label: emboss-data
doc: "The provided text does not contain help information for the tool. It contains
  a fatal error message regarding a container runtime (Apptainer/Singularity) failing
  to build an image due to lack of disk space.\n\nTool homepage: http://emboss.open-bio.org/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/emboss-data:v6.6.0dfsg-7-deb_cv1
stdout: emboss-data.out
