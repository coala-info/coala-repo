cwlVersion: v1.2
class: CommandLineTool
baseCommand: caspeak
label: caspeak
doc: "The provided text does not contain help information for the tool 'caspeak'.
  It appears to be an error log from a container runtime (Apptainer/Singularity) indicating
  a failure to build or unpack the image due to lack of disk space.\n\nTool homepage:
  https://github.com/Rye-lxy/CasPeak"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/caspeak:1.1.5--pyhdfd78af_0
stdout: caspeak.out
