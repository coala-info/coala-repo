cwlVersion: v1.2
class: CommandLineTool
baseCommand: printsextract
label: emboss-test_printsextract
doc: "The provided text does not contain help information for the tool. It contains
  error messages related to a container runtime (Apptainer/Singularity) failing to
  build an image due to lack of disk space.\n\nTool homepage: http://emboss.open-bio.org/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/emboss-test:v6.6.0dfsg-7-deb_cv1
stdout: emboss-test_printsextract.out
