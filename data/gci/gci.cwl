cwlVersion: v1.2
class: CommandLineTool
baseCommand: gci
label: gci
doc: "The provided text does not contain help information for the tool 'gci'. It appears
  to be a system error log from a container runtime (Apptainer/Singularity) indicating
  a failure to build or pull the container image due to lack of disk space.\n\nTool
  homepage: https://github.com/yeeus/GCI"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gci:1.0--hdfd78af_0
stdout: gci.out
