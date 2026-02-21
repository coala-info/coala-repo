cwlVersion: v1.2
class: CommandLineTool
baseCommand: hiddendomains
label: hiddendomains
doc: "The provided text does not contain help information or usage instructions for
  the tool. It appears to be an error log from a container runtime (Apptainer/Singularity)
  indicating a failure to build the container image due to lack of disk space.\n\n
  Tool homepage: http://hiddendomains.sourceforge.net/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hiddendomains:3.1--pl526r36_0
stdout: hiddendomains.out
