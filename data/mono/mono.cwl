cwlVersion: v1.2
class: CommandLineTool
baseCommand: mono
label: mono
doc: "The provided text does not contain help information or usage instructions for
  the 'mono' command. It appears to be a fatal error log from a container runtime
  (Apptainer/Singularity) indicating a failure to build a SIF image due to insufficient
  disk space.\n\nTool homepage: https://github.com/Seldaek/monolog"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mono:4.6.2.6--0
stdout: mono.out
