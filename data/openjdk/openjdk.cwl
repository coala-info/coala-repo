cwlVersion: v1.2
class: CommandLineTool
baseCommand: openjdk
label: openjdk
doc: "The provided text does not contain help information or usage instructions for
  openjdk. It is an error log from a container runtime (Apptainer/Singularity) indicating
  a failure to build a SIF image due to insufficient disk space.\n\nTool homepage:
  https://github.com/openjdk/jdk"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/openjdk:11.0.1--1
stdout: openjdk.out
