cwlVersion: v1.2
class: CommandLineTool
baseCommand: log4cpp
label: log4cpp
doc: "The provided text is an error message from a container runtime (Apptainer/Singularity)
  and does not contain the help documentation or usage instructions for the log4cpp
  tool.\n\nTool homepage: https://github.com/orocos-toolchain/log4cpp"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/log4cpp:1.1--0
stdout: log4cpp.out
