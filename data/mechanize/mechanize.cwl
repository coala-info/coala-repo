cwlVersion: v1.2
class: CommandLineTool
baseCommand: mechanize
label: mechanize
doc: "The provided text does not contain help information for the tool 'mechanize'.
  It contains error logs from a container runtime (Apptainer/Singularity) indicating
  a failure to pull the container image due to lack of disk space.\n\nTool homepage:
  https://github.com/sparklemotion/mechanize"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mechanize:0.2.5
stdout: mechanize.out
