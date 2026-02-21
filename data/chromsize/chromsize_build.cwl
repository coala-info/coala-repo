cwlVersion: v1.2
class: CommandLineTool
baseCommand: chromsize_build
label: chromsize_build
doc: "The provided text appears to be a system log or error message from a container
  build process (Apptainer/Singularity) rather than command-line help text. No CLI
  arguments, flags, or usage instructions were found in the input.\n\nTool homepage:
  https://github.com/alejandrogzi/chromsize"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/chromsize:0.0.32--ha6fb395_0
stdout: chromsize_build.out
