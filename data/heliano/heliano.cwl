cwlVersion: v1.2
class: CommandLineTool
baseCommand: heliano
label: heliano
doc: "The provided text does not contain help information for the tool 'heliano'.
  It contains error logs from a container runtime (Apptainer/Singularity) indicating
  a failure to build the SIF image due to insufficient disk space.\n\nTool homepage:
  https://github.com/Zhenlisme/heliano"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/heliano:1.3.1--hdfd78af_0
stdout: heliano.out
