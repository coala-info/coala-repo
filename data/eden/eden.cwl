cwlVersion: v1.2
class: CommandLineTool
baseCommand: eden
label: eden
doc: "The provided text does not contain help information for the tool 'eden'. It
  contains error logs from a container runtime (Apptainer/Singularity) indicating
  a failure to build the container image due to lack of disk space.\n\nTool homepage:
  https://github.com/pflyly/eden-nightly"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/eden:2.0--py27hfd84ecd_2
stdout: eden.out
