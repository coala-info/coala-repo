cwlVersion: v1.2
class: CommandLineTool
baseCommand: moca
label: moca
doc: "The provided text does not contain help information for the tool 'moca'. It
  appears to be an error log from a container runtime (Apptainer/Singularity) indicating
  a failure to build the container image due to insufficient disk space.\n\nTool homepage:
  https://github.com/saketkc/moca"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/moca:0.4.3--py27_0
stdout: moca.out
