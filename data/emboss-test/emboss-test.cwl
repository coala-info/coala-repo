cwlVersion: v1.2
class: CommandLineTool
baseCommand: emboss-test
label: emboss-test
doc: "The provided text does not contain help information for the tool, but appears
  to be a fatal error log from a container runtime (Apptainer/Singularity) indicating
  a failure to build the container image due to lack of disk space.\n\nTool homepage:
  http://emboss.open-bio.org/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/emboss-test:v6.6.0dfsg-7-deb_cv1
stdout: emboss-test.out
