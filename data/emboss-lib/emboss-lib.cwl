cwlVersion: v1.2
class: CommandLineTool
baseCommand: emboss-lib
label: emboss-lib
doc: "The provided text does not contain help information for the tool. It contains
  system error messages related to a container runtime (Apptainer/Singularity) failing
  to pull the image due to lack of disk space.\n\nTool homepage: http://emboss.open-bio.org/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/emboss-lib:v6.6.0dfsg-6-deb_cv1
stdout: emboss-lib.out
