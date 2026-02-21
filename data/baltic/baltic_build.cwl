cwlVersion: v1.2
class: CommandLineTool
baseCommand: baltic_build
label: baltic_build
doc: "The provided text appears to be an error log from a container build process
  (Apptainer/Singularity) rather than help text for the 'baltic_build' tool. As a
  result, no command-line arguments, flags, or valid descriptions could be extracted.\n
  \nTool homepage: https://github.com/evogytis/baltic"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/baltic:0.3.0--pyhdfd78af_0
stdout: baltic_build.out
